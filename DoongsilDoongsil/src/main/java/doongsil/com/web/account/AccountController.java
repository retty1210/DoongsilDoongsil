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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.EnumKeySerializer;
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
	public String snsLoginCallback(@PathVariable String snsService, Model model, @RequestParam("code") String code, HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("code => " + code);
		logger.info("snsLoginCallback: service={}", snsService);
		
		SnsValue sns = null;
		
		if (StringUtils.equals("naver", snsService)) {
			sns = naverSns;
			SNSLogin snsLogin = new SNSLogin(sns);
			SnsVO snsData = snsLogin.getUserProfile(code);
			logger.info("Profile = " + snsData.getSocial_email());
		} else if (StringUtils.equals("google", snsService)) {
			sns = googleSns;
			SNSLogin snsLogin = new SNSLogin(sns);
			SnsVO snsData = snsLogin.getUserTokenTemp(code); // 1,2번 동시
			logger.info("Profile = " + snsData.getSocial_email());
		} else if (StringUtils.equals("kakao", snsService)) {
			sns = kakaoSns;
			SNSLoginKa snsLoginKa = new SNSLoginKa(sns);
			SnsVO snsData = snsLoginKa.getUserProfile(code);
			logger.info("Profile = " + snsData.getSocial_email());
		}
		
		// 1. code를 이용해서 access_token 받기
		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
		//System.out.println("Profile : " + snsVo);
		
		// 3. DB 해당 유저가 존재하는지 체크 (googleid, naverid, kakaoid 컬럼 추가)
		/*
		 * 1번 문제. password가 NN이라서 google id로 가입할 경우 pw 처리가 애매함.
		 * ->pw를 구글로 로그인 한 경우엔 google로 db에 입력하고 로그인 화면에서 pw에 google을 입력했을때 
		 * 쿼리로 넘어가기 전에 아예 false를 반환시키게.(유지보수가 쉽지 않다는 단점)
		 * 2번. 구글에서 받는 데이터가 이메일, 프로필사진, 아이디뿐이라서 이름 주소 등등을 따로 넣어줘야 하고
		 * 3번. 로그인할때 query문 보면 id랑 password로 select을 하게 되어 있는데 sns로 로그인한 회원은 pw가 없는 문제
		 * 4번. 학부모가 db에서 테이블이 따로 있는데 이거 관련해서 처리(로그인, 회원가입)
		 * ->회원가입할때 2번문제 해결하려면 추가정보 받는 창을 띄워야 하는데
		 * 이 때 회원 타입을 선택하면 그거에 맞춰서 생성하는 VO를 다르게 생성해서(if문 사용)
		 * 쿼리를 돌리면 되고, 로그인할때는 토큰 관련된 처리가 끝난 다음에
		 * db에 있는 데이터랑 확인할때 로그인화면에서 입력받은 회원타입이랑 비교까지 한번에
		 */
		
//		STAccountVO snsData = staService.snsLoginCheck(stVo);		
		// 미존재시 회원가입페이지로
//		if(snsData == null) {
//			model.addAttribute("result", stVo);
//			return "account/join";
//		} 
//		// 4. 존재시 로그인
//		
		session.setAttribute("logined", true);
//		session.setAttribute("account", snsData);
//		session.setAttribute("accountType", snsData.getSta_usertype());
//		session.setAttribute("accountNumber", snsData.getSta_id());
		
//		return "./admin/popup/infoUpdate";
		return "redirect:/";
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
		
		SNSLoginKa snSloginKa = new SNSLoginKa(kakaoSns);
		model.addAttribute("kakao_url", snSloginKa.getKakaoAuthURL());
		
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
				session.setAttribute("accountType", "P");
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
	public String findId(HttpSession session, STAccountVO st, Model model, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		List<STAccountVO> data = staService.findId(st);
		if(data.size() != 0) {
			logger.info("data" + data);
			model.addAttribute("check", 0);
			model.addAttribute("id", data);
		} else {
			logger.info("null");
			model.addAttribute("check", 1);
		}
		return "account/findId";
	}
	
	// 아이디 찾기 실행(학부모)
	@RequestMapping(value = "/findId2", method = RequestMethod.GET)
	public String findId2() {
		return "account/findId";
	}
	
	@RequestMapping(value = "/findId2", method = RequestMethod.POST)
	public String findId2(PAAccountVO pa, Model model, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		List<PAAccountVO> data = paaService.findId2(pa);
		if(data.size() != 0) {
			logger.info("data" + data);
			model.addAttribute("check", 2);
			model.addAttribute("id2", data);
		} else {
			logger.info("null");
			model.addAttribute("check", 3);
		}
		return "account/findId";
	}
	
	// 비밀번호 찾기 실행
	@RequestMapping(value = "/findPss", method = RequestMethod.GET)
	public String findPss() {
		return "account/findPss";
	}
	
	@RequestMapping(value = "/findPss", method = RequestMethod.POST)
	public String findPss(STAccountVO stVo, Model model, HttpServletResponse res) throws Exception {
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
		, STAccountVO stVo, HttpServletResponse res) throws Exception {
			stVo.setSta_username(sta_username);
			System.out.println(stVo);
			staService.updatePassword(stVo);
			PrintWriter out = res.getWriter();
			out.println("<script>alert('비밀번호가 변경되었습니다.');</script>");
			out.flush();
			return "account/login";
	}
	
	// 비밀번호 찾기 실행
	@RequestMapping(value = "/findPss2", method = RequestMethod.GET)
	public String findPss2() {
		return "account/findPss";
	}
	
	@RequestMapping(value = "/findPss2", method = RequestMethod.POST)
	public String findPss2(PAAccountVO paVo, Model model, HttpServletResponse res) throws Exception {
		PAAccountVO datas = paaService.findPassword2(paVo);
		if(datas == null) {
			logger.info("pss null");
			model.addAttribute("check", 3);
		} else {
			model.addAttribute("check", 2);
			model.addAttribute("updateid2", paVo.getPaa_username());
		}
		return "account/findPss";
	}
	
    // 비밀번호 바꾸기 실행
	@RequestMapping(value="/update_password2", method = RequestMethod.POST)
	public String updatePasswordAction2(@RequestParam(value="updateid2", defaultValue="", required = false) String paa_username
		, PAAccountVO paVo, HttpServletResponse res) throws Exception {
			paVo.setPaa_username(paa_username);
			System.out.println(paVo);
			paaService.updatePassword2(paVo);
			PrintWriter out = res.getWriter();
			out.println("<script>alert('비밀번호가 변경되었습니다.');</script>");
			out.flush();
			return "account/login";
	}
	
	// 학부모 회원가입
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
