package doongsil.com.web.account.oauth2;

//import java.util.Iterator;
//
//import org.apache.commons.lang3.StringUtils;
//import org.springframework.social.google.api.drive.DriveUser;

//import com.fasterxml.jackson.databind.JsonNode;
//import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SNSLogin {
	private OAuth20Service oauthService;
	private String profileUrl;

	public SNSLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId()).apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl()).scope("profile").build(sns.getApi20Instance());

		this.profileUrl = sns.getProfileUrl();
	}

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public String getKakaoAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public String getUserProfile(String code) throws Exception {
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);

		OAuthRequest request = new OAuthRequest(Verb.GET, this.profileUrl);
		oauthService.signRequest(accessToken, request);

		Response response = oauthService.execute(request);
		return response.getBody();
//		return parseJson(response.getBody());
	}

//	private String parseJson(String body) {
//		User user = new User();
//
//		ObjectMapper mapper = new ObjectMapper();
//		JsonNode rootNode = mapper.readTree(body);
//
//		if (this.sns.isGoogle()) {
//			String id = rootNode.get("id").asText();
//			if (sns.isGoogle()) {
//				user.setGoogleid(id);
//			}
//			user.setNickname(rootNode.get("displayName").asText());
//			JsonNode nameNode = rootNode.path("name");
//			String uname = nameNode.get("familyName").asText() + nameNode.get("givenName").asText();
//			user.setUname(uname);
//
//			Iterator<JsonNode> iterEmails = rootNode.path("emails").elements();
//			while (iterEmails.hasNext()) {
//				JsonNode emailNode = iterEmails.next();
//				String type = emailNode.get("type").asText();
//				if (StringUtils.equals(type, "account")) {
//					user.setEmail(emailNode.get("value").asText());
//					break;
//				}
//
//			} 
//		} else if(this.sns.isNaver()) {
//			JsonNode resNode = rootNode.get("response");
//			String email = emailNode.get("value").asText();
//			
//		}
//
//		return user;
//	}

}
