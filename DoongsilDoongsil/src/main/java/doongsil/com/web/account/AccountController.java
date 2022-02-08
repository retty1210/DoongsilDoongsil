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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.builder.ServiceBuilder;

import doongsil.com.web.account.model.*;
import doongsil.com.web.account.oauth2.*;


@Controller
public class AccountController {
	
private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
//	@Inject
//	private AccountService service;
	
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
	
	@RequestMapping(value = "/oauth2/google/callback",
			method = { RequestMethod.GET, RequestMethod.POST })
	public String snsLoginCallback(@PathVariable String snsService, Model model, @RequestParam String code, HttpSession session) throws Exception {
		// 1. code를 이용해서 access_token 받기
		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
		SNSLogin snsLogin = new SNSLogin(googleSns);
		String profile = snsLogin.getUserProfile(code);
		System.out.println("Profile>>" + profile);
		model.addAttribute("result" + profile);
		// 3. DB 해당 유저가 존재하는지 체크 (googleid, naverid, cacaoid 컬럼 추가)
		// 미존재시 회원가입페이지로
		// 4. 존재시 로그인
		return "account/loginResult";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "account/join";
	}
	
//	@RequestMapping(value = "/join", method = RequestMethod.POST)
//	public String join(STJoinVO stJoinVO, PAJoinVO paJoinVO) {
//		if(stJoinVO != null && paJoinVO != null) {
//			return "redirect:/login";
//		}
//		return "account/join";
//	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		
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
	
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(LoginVO loginVO, HttpSession session, Model model) {
//
//		STAccountVO data = service.login(loginVO);
//		
//		if(data != null) {
//			session.setAttribute("logined", true);
//			session.setAttribute("account", data);
//			
//			return "redirect:/";
//		} else {
//			model.addAttribute("isError", true);
//			model.addAttribute("error_msg", "아이디 또는 패스워드가 잘못되었습니다.");
//		}
//		
//		 return "account/login";
//	}
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(LoginVO loginVo, HttpSession session,Model model,HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(loginVo.getUserType().equals("S")||loginVo.getUserType().equals("T") ) {
			STAccountVO stData = this.staService.staLogin(loginVo);
			System.out.println(stData);
			if(stData != null) {
				session.setAttribute("logined", true);
				session.setAttribute("account", stData);
				session.setAttribute("accountType", stData.getSta_usertype());
				session.setAttribute("accountNumber", stData.getSta_id());
				return "redirect:/";
			}else {
				out.println("<script> alert('로그인을 실패 했습니다! 회원 타입을 다시 선택하세요.');</script>");
			}
		}else {
			PAAccountVO paData = this.paaService.paaLogin(loginVo);
			if(paData != null) {
				session.setAttribute("logined", true);
				session.setAttribute("account", paData);
				session.setAttribute("accountType", paData.getSta_usertype());
				session.setAttribute("accountNumber", paData.getPaa_id());
				return "redirect:/";
			}else {
				out.println("<script> alert('로그인을 실패 했습니다! 회원 타입을 다시 선택하세요.');</script>");
			}
		}
		out.flush();
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
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value = "/paaJoin", method = RequestMethod.GET)
	public String paaJoin() {
		return "account/paaJoin";
	}
	
}
