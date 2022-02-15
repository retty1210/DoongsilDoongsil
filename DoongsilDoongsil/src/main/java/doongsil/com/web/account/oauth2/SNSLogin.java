package doongsil.com.web.account.oauth2;

import java.util.Iterator;

import org.apache.commons.lang3.StringUtils;
import org.springframework.social.google.api.drive.DriveUser;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import doongsil.com.web.account.model.STAccountVO;

public class SNSLogin {
	private OAuth20Service oauthService;
	private String profileUrl;
	private SnsValue sns;
	
	/*
	public SNSLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile")
				.build(sns.getApi20Instance());

		this.profileUrl = sns.getProfileUrl();
	}
	 */
	
	public SNSLogin(SnsValue sns) {
		System.out.println("SNSLogin start");
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile")
				.build(sns.getApi20Instance());
		
		System.out.println("SNSLogin oauthService Complete");
		this.sns = sns;
	}

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public String getKakaoAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public SnsVO getUserProfile(String code) throws Exception {
		System.out.println("getUserProfile start");
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		System.out.println("accessToken complete");
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		System.out.println("request getProfile");
		oauthService.signRequest(accessToken, request);
		System.out.println("signRequest complete");
		
		Response response = oauthService.execute(request);
		System.out.println("execute complete");
//		return response.getBody();
		return parseJson(response.getBody());
	}

	/*
	 */
	private SnsVO parseJson(String body) throws Exception {
		System.out.println("---\n" + body + "\n---");
		SnsVO snsVo = new SnsVO();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		int idx = rootNode.get("email").asText().indexOf("@");
		
		if(this.sns.isGoogle()) {
			String id = rootNode.get("id").asText();
			if(sns.isGoogle()) {
				JsonNode resNode = rootNode.get("response");
//				snsVo.setSocial_id(resNode.get("id").asText());
//				snsVo.setSocial_username(resNode.get("email").asText().substring(0, idx));
				System.out.println("astext: "+ resNode.get("email").asText());
				System.out.println("toString: "+ resNode.get("email").toString());
				System.out.println("basic: "+ resNode.get("email"));
				snsVo.setSocial_email(resNode.get("email").asText());
				snsVo.setSocial_type("google");
			}
		} else if (this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
//			snsVo.setSocial_id(resNode.get("id").asText());
//			snsVo.setSocial_username(resNode.get("email").asText().substring(0, idx));
			snsVo.setSocial_email(resNode.get("email").asText());
			snsVo.setSocial_type("naver");
		} else if (this.sns.isKakao()) {
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
