package doongsil.com.web.account.oauth2;

import java.util.concurrent.ExecutionException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SNSLogin {
	private OAuth20Service oauthService;
	private SnsValue sns;
	
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

	public SnsVO getUserProfile(String code) throws Exception {
		System.out.println("getUserProfile start");
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		System.out.println("accessToken complete:" + accessToken);
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		System.out.println("request getProfile:" + request);
		oauthService.signRequest(accessToken, request);
		System.out.println("signRequest complete");
		
		Response response = oauthService.execute(request);
		System.out.println("execute complete:" + response);
		System.out.println("response.getbody: " + response.getBody());
//		return response.getBody();
		return parseJson(response.getBody());
	}
	
	public SnsVO getUserTokenTemp(String code) throws Exception, InterruptedException, ExecutionException {
		OAuth20Service oAuth = new ServiceBuilder("536429627526-cbc02vfg4p18ltdsg4lo1ljlbg947hcd.apps.googleusercontent.com")
				.apiSecret("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")
				.scope("https://www.googleapis.com/auth/user.addresses.read https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/user.phonenumbers.read https://www.googleapis.com/auth/user.birthday.read openid https://www.googleapis.com/auth/user.emails.read https://www.googleapis.com/auth/userinfo.profile")
				.callback("http://localhost/login/oauth2/google/callback")
				.build(GoogleApi20.instance());
		OAuth2AccessToken aToken = oAuth.getAccessToken(code);
		System.out.println("aToken get RawRes = >" +aToken.getRawResponse());
		aToken.getParameter("access_token");
		
		OAuthRequest authRequest = new OAuthRequest(Verb.GET, "https://www.googleapis.com/oauth2/v2/userinfo");
		oAuth.signRequest(aToken, authRequest);
		Response oAuthResponse = oAuth.execute(authRequest);
		System.out.println("oAuthres get body => "+oAuthResponse.getBody());
		System.out.println("email: " + oAuthResponse.getBody().substring(oAuthResponse.getBody().indexOf("email") + 9, oAuthResponse.getBody().indexOf("verified_email") - 6));
		System.out.println("google id:" + oAuthResponse.getBody().substring(oAuthResponse.getBody().indexOf("email") + 9, oAuthResponse.getBody().indexOf("@")));
//		System.out.println("token email = > "+oAuthResponse.);
		
		String temp = oAuthResponse.getBody();
		String googleID = temp.substring(temp.indexOf("email") + 9, temp.indexOf("@"));
		SnsVO snsData = new SnsVO();
		snsData.setSocial_email(googleID);
		snsData.setSocial_type("google");
		return snsData;
	}
	 
	private SnsVO parseJson(String body) throws Exception {
		System.out.println("---\n" + body + "\n---");
		SnsVO snsVo = new SnsVO();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		//int idx = rootNode.get("email").asText().indexOf("@");
		
		/*
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
		} else 
		*/
			
		if (this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
//			snsVo.setSocial_id(resNode.get("id").asText());
//			snsVo.setSocial_username(resNode.get("email").asText().substring(0, idx));
			snsVo.setSocial_email(resNode.get("email").asText());
			snsVo.setSocial_type("naver");
		} 
		
		System.out.println("snsVo" + snsVo);
		return snsVo;
		}
	
}
