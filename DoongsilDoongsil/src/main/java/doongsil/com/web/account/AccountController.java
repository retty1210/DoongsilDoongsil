package doongsil.com.web.account;

import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.*;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

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
	STAccountService staService;
	
	@Autowired
	PAAccountService paaService;
	
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
	
	@RequestMapping(value = "/login/oauth2/{snsService}/callback",
			method = { RequestMethod.GET, RequestMethod.POST })
	public String snsLoginCallback(@PathVariable String snsService, Model model, @RequestParam String code, STAccountVO stVo, HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("code => "+code);
		
		logger.info("snsLoginCallback: service={}", snsService);
		SnsValue sns = null;
		if(StringUtils.equals("naver", snsService)) {
			sns = naverSns;
		} else if(StringUtils.equals("kakao", snsService)) {
			sns = kakaoSns;
		} else if(StringUtils.equals("google", snsService)) {
			sns = googleSns;
		}
		
		/*
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
//		System.out.println("token email = > "+oAuthResponse.);
		*/
		// 1. code를 이용해서 access_token 받기
		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
		SNSLogin snsLogin = new SNSLogin(sns);
		
		SnsVO snsVo = snsLogin.getUserProfile(code); // 1,2번 동시
		System.out.println("Profile : " + snsVo);
		
		// 3. DB 해당 유저가 존재하는지 체크 (googleid, naverid, kakaoid 컬럼 추가)
		
//		STAccountVO snsData = staService.snsLoginCheck(stVo);		
		// 미존재시 회원가입페이지로
//		if(snsData == null) {
//			model.addAttribute("result", stVo);
//			return "account/join";
//		} 
//		// 4. 존재시 로그인
//		
//		session.setAttribute("logined", true);
//		session.setAttribute("account", snsData);
//		session.setAttribute("accountType", snsData.getSta_usertype());
//		session.setAttribute("accountNumber", snsData.getSta_id());
		
//		return "./admin/popup/infoUpdate";
		return "redirect:/home";
	}
	
//	@RequestMapping(value = "/insertSns", method = RequestMethod.GET)
//	public String insertSns() {
//		return "account/insertSns";
//	}
//	
//	@RequestMapping(value = "/insertSns", method = RequestMethod.POST) 
//	public String insertSns(STAccountVO stvo, Model model) {
//		
//		return "";
//	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "account/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(STJoinVO stVo, Model model) throws Exception {
		if(stVo != null) {
			logger.info("회원가입 성공 - stVo" + stVo);
			staService.join(stVo);
			return "redirect:/login";
		}
		return "account/join";
	}
	
	// 학생과 교사 아이디 중복 체크
	@RequestMapping(value = "/dupcheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String idCheck(STAccountVO stVo) throws Exception {
		boolean isDuplicate = false;
		// 중복 체크를 위한 서비스 동작
		isDuplicate = staService.idCheck(stVo);
		JSONObject json = new JSONObject();
		
		if(isDuplicate) { //false
			// 아이디 중복됨
			logger.info("아이디가 중복됨.");
			json.put("state", "fail");
			json.put("msg", "아이디가 중복되었습니다.");
			System.out.println(json.toString());
		} else { //true
			// 아이디 중복 안됨
			logger.info("아이디가 중복 안됨.");
			json.put("state", "success");
		}
		return json.toJSONString();
	}
	
	// 학부모 아이디 중복 체크
		@RequestMapping(value = "/dupcheck2", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
		@ResponseBody
		public String idCheck2(PAAccountVO paVO) throws Exception {
			boolean isDuplicate = false;
			isDuplicate = paaService.idCheck2(paVO);
			JSONObject json = new JSONObject();
			
			if(isDuplicate) { //false
				logger.info("아이디가 중복됨.");
				json.put("state", "fail");
				json.put("msg", "아이디가 중복되었습니다.");
				System.out.println(json.toString());
			} else { //true
				logger.info("아이디가 중복 안됨.");
				json.put("state", "success");
			}
			return json.toJSONString();
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
	public String login(LoginVO loginVo, HttpSession session, Model model, HttpServletResponse response) throws Exception{
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
			} else {
				out.println("<script> alert('로그인을 실패 했습니다! 회원 타입을 다시 선택하세요.');</script>");
			}
		} else {
			PAAccountVO paData = this.paaService.paaLogin(loginVo);
			if(paData != null) {
				session.setAttribute("logined", true);
				session.setAttribute("account", paData);
				session.setAttribute("accountType", paData.getSta_usertype());
				session.setAttribute("accountNumber", paData.getPaa_id());
				return "redirect:/";
			} else {
				out.println("<script> alert('로그인을 실패 했습니다! 회원 타입을 다시 선택하세요.');</script>");
			}
		}
		out.flush();
		return "account/login";
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 아이디 찾기 실행
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String findId() {
		return "account/findId";
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findId(STAccountVO st, Model model) {
		STAccountVO data = staService.findId(st);
		if(data == null) {
			logger.info("null");
			model.addAttribute("check", 1);
		} else {
			logger.info("data" + data);
			model.addAttribute("check", 0);
			model.addAttribute("id", data.getSta_username());
		}
		return "account/findId";
	}
	
	// 비밀번호 찾기 실행
	@RequestMapping(value = "/findPss", method = RequestMethod.GET)
	public String findPss() {
		return "account/findPss";
	}
	
	@RequestMapping(value = "/findPss", method = RequestMethod.POST)
	public String findPss(STAccountVO stVo, Model model) throws Exception {
		STAccountVO datas = staService.findPassword(stVo);
		
		if(datas == null) {
			logger.info("pss null");
			model.addAttribute("check", 1);
		} else {
			model.addAttribute("check", 0);
			model.addAttribute("updateid", stVo.getSta_username());
		}
		return "account/findPss";
	}
	
    // 비밀번호 바꾸기 실행
	@RequestMapping(value="/update_password", method = RequestMethod.POST)
	public String updatePasswordAction(@RequestParam(value="updateid", defaultValue="", required = false) String sta_username
		, STAccountVO stVo) {
			stVo.setSta_username(sta_username);
			System.out.println(stVo);
			staService.updatePassword(stVo);
			return "account/findPasswordConfirm";
	}
	
    // 비밀번호 바꾸기할 경우 성공 페이지 이동
	@RequestMapping(value="/check_password_view")
	public String checkPasswordForModify(HttpSession session, Model model) {
		STAccountVO loginUser = (STAccountVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			return "account/login";
		} else {
			return "admin/infoUpdate";
		}
	}
	
	@RequestMapping(value = "/paaJoin", method = RequestMethod.GET)
	public String paaJoin() {
		return "account/paaJoin";
	}
	
	@RequestMapping(value = "/paaJoin", method = RequestMethod.POST)
	public String paaJoin(PAJoinVO paVo, Model model) throws Exception {
		if(paVo != null) {
			logger.info("회원가입 성공 - paVo" + paVo);
			System.out.println("vo : " + paVo.getPaa_child_id());
			paaService.join(paVo);
			return "redirect:/login";
		}
		return "account/paaJoin";
	}
	
	@RequestMapping(value = "/childCheck", method = RequestMethod.GET)
	public String findChild() {
		return "account/findChild";
	}
	
	@RequestMapping(value = "/childCheck", method = RequestMethod.POST) 
	public String findChild(STAccountVO stVo, HttpSession session, Model model) {
		STAccountVO stList = (STAccountVO) session.getAttribute("list");
		List<STAccountVO> list = staService.findChild(stVo);
		
		if(list.size() != 0) {
			logger.info("아이 이름 찾기 성공");
			System.out.println(list.get(0));
			model.addAttribute("success_list", 0);
			model.addAttribute("list", list);
		} else {
			model.addAttribute("fail_list", 1);
		}
		return "account/findChild";
	}
	
}
