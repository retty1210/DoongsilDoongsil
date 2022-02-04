package doongsil.com.web.account;

import java.io.PrintWriter;
import javax.servlet.http.*;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import doongsil.com.web.account.model.*;
import doongsil.com.web.account.oauth2.*;


@Controller
public class AccountController {
	
private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@Autowired
	private AccountService service;
	
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private SnsValue googleSns;
	
	@Inject
	private SnsValue kakaoSns;
	
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	STAccountService staService;
	@Autowired
	PAAccountService paaService;
	
	@RequestMapping(value = "/login/oauth2/google/callback",
			method = { RequestMethod.GET, RequestMethod.POST })
	public String snsLoginCallback(Model model, @RequestParam String code, HttpServletRequest request) throws Exception {
		System.out.println(request.getParameter("code"));
		// 1. code를 이용해서 access_token 받기
		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
		
		OAuth20Service oAuth = new ServiceBuilder("536429627526-cbc02vfg4p18ltdsg4lo1ljlbg947hcd.apps.googleusercontent.com")
				.apiSecret("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")
				.scope("https://www.googleapis.com/auth/user.addresses.read https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/user.phonenumbers.read https://www.googleapis.com/auth/user.birthday.read openid https://www.googleapis.com/auth/user.emails.read https://www.googleapis.com/auth/userinfo.profile")
				.callback("http://localhost/login/oauth2/google/callback")
				.build(GoogleApi20.instance());
		OAuth2AccessToken aToken = oAuth.getAccessToken(code);
		System.out.println(aToken.getRawResponse());
		aToken.getParameter("access_token");
		
		OAuthRequest authRequest = new OAuthRequest(Verb.GET, "https://www.googleapis.com/oauth2/v2/userinfo");
		oAuth.signRequest(aToken, authRequest);
		Response oAuthResponse = oAuth.execute(authRequest);
		System.out.println(oAuthResponse.getBody());
		
//		SNSLogin snsLogin = new SNSLogin(googleSns);
//		String profile = snsLogin.getUserProfile(code);
//		System.out.println("Profile>>" + profile);
//		model.addAttribute("result" + profile);
		// 3. DB 해당 유저가 존재하는지 체크 (googleid, naverid, cacaoid 컬럼 추가)
		// 미존재시 회원가입페이지로
		// 4. 존재시 로그인
		return "account/loginResult";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "account/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(STJoinVO stJoinVO, PAJoinVO paJoinVO) {
		if(stJoinVO != null && paJoinVO != null) {
			return "redirect:/login";
		}
		return "account/join";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		logger.info("method: GET, login(), 로그인 페이지 요청");
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		SNSLogin snSlogin = new SNSLogin(kakaoSns);
		model.addAttribute("kakao_url", snSlogin.getKakaoAuthURL());
		
//		SNSLogin googleLogin = new SNSLogin(googleSns);
//		model.addAttribute("google_url", googleLogin.getNaverAuthURL());
		
		/* 구글 code 발행을 위한 URL 생성 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		
		model.addAttribute("google_url", url);
		
		return "account/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(LoginVO vo, HttpSession session, Model model) {

		STAccountVO data = service.login(vo);
		
		if(data != null) {
			session.setAttribute("logined", true);
			session.setAttribute("account", data);
			
			return "redirect:/login";
		} else {
			model.addAttribute("isError", true);
			model.addAttribute("error_msg", "아이디 또는 패스워드가 잘못되었습니다.");
		}
		
		 return "account/login";
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String findId() {
		return "account/findId";
	}
	
//	@RequestMapping(value = "/findId", method = RequestMethod.POST)
//	public String findId() {
//		return "account/findId";
//	}
	
	@RequestMapping(value = "/findPss", method = RequestMethod.GET)
	public String findPss() {
		return "account/findPss";
	}
	
//	@RequestMapping(value = "/findPss", method = RequestMethod.POST)
//	public String findPss() {
//		return "account/findPss";
//	}
	
	@RequestMapping(value = "/paaJoin", method = RequestMethod.GET)
	public String paaJoin() {
		return "account/paaJoin";
	}
	
}
