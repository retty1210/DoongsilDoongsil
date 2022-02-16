package doongsil.com.web.account.oauth2;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.core.oauth.OAuthService;
import com.google.api.client.http.HttpHeaders;

public class SNSLoginKa {
	private OAuth20Service oauthService;
	private SnsValue sns;
	
	public SNSLoginKa(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile_nickname, profile_image, account_email")
				.build(sns.getApi20Instance());
		
		System.out.println("SNSLogin oauthService Complete");
		this.sns = sns;
	}
	
	public String getKakaoAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}
	
	public SnsVO getUserProfile(String code) throws Exception {
		System.out.println("getUserProfile start!");
		System.out.println(code);
		/*
		// httpsURLConnection url -> 옛날방식이라 조금 불편
		// REtrofit2(안드로이드에서 쓰는 라이브러리), OkHttp
		RestTemplate rt = new RestTemplate();
		// httpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		// 현재 http 형식이 key-value 형식임을 알린다
		headers.add("Content-type", "appplication/x-www-form-urlencoded;charset=utf-8");
		
		// httpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant-type", "authorization_code");
		params.add("client-id", "d6cbcb45ce2bd0de56f95ef51e764ec7");
		params.add("redirect-uri", "http://localhost/login/oauth2/kakao/callback");
		
		// 방금 받은 코드 출력
		params.add("code : ", code);
		
		// body data와 header 값을 가지고 있는 하나의 httpEntity가 된다
		// body 값과 header 값을 둘 다 하나로 만든다
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		
		// http 요청하기 - Post 방식으로 + response 변수의 응답을 받음
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token", 
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class);
		System.out.println(response);
		*/
		// OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		// System.out.println("accessToken complete:" + accessToken);
		
		System.out.println(sns.getClientId());
		
		OAuthRequest token = new OAuthRequest(Verb.POST, "https://kauth.kakao.com/oauth/token");
		// token.addHeader("Host", "kauth.kakao.com");
		token.addHeader("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		token.addBodyParameter("grant_type", "authorization_code");
		token.addBodyParameter("client_id", "d6cbcb45ce2bd0de56f95ef51e764ec7");
		token.addBodyParameter("redirect_uri", "http://localhost/login/oauth2/kakao/callback");
		token.addBodyParameter("code", code);
		token.addBodyParameter("client_secret", "vpqr07m6lPpwxrW0mrz4P626NlfnwDMI");
		
		Response respToken = oauthService.execute(token);
		
		System.out.println("바디체크 : " +respToken.getBody());
		
		JSONParser jp = new JSONParser();
		Object jsonObj = jp.parse(respToken.getBody());
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		request.addHeader("Host", "kapi.kakao.com");
		request.addHeader("Authorization", "Bearer " + ((HashMap<String, String>)jsonObj).get("access_token") );
		request.addHeader("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		System.out.println("request getProfile:" + request);
		
		// oauthService.signRequest(accessToken, request);
		// System.out.println("signRequest complete");
		
		Response response = oauthService.execute(request);
		System.out.println("execute complete:"+ response);
		System.out.println("response.getbody: " +response.getBody());
//		return response.getBody();
		jp = new JSONParser();
		jsonObj = jp.parse(response.getBody());
		
		SnsVO snsVo = new SnsVO();
		
		Map<String, Object> jsonMap = (Map<String, Object>)jsonObj;
		for(Entry<String, Object> e: jsonMap.entrySet()) {
			System.out.println(e.getKey() +"|" +e.getValue());
		}
		jsonObj = jp.parse(jsonMap.get("kakao_account").toString());
		jsonMap = (Map<String, Object>)jsonObj;
		snsVo.setSocial_email((String)jsonMap.get("email"));
		System.out.println(snsVo.getSocial_email());
		return snsVo;
	}
	
	private SnsVO parseJson(String body) throws Exception {
		System.out.println("---\n" + body + "\n---");
		SnsVO snsVo = new SnsVO();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);

		if (this.sns.isKakao()) {
			JsonNode resNode = rootNode.get("response");
//			snsVo.setSocial_id(resNode.get("id").asText());
//			snsVo.setSocial_username(resNode.get("email").asText().substring(0, idx));
			snsVo.setSocial_email(resNode.get("email").asText());
			snsVo.setSocial_type("kakao");
		}
		
		System.out.println("snsVo" + snsVo);
		return snsVo;
	}
	
}
