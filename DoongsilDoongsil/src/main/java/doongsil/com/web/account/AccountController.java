package doongsil.com.web.account;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import doongsil.com.web.account.model.*;

@Controller
public class AccountController {
	
	@Autowired
	STAccountService staService;
	@Autowired
	PAAccountService paaService;
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "account/join";
	}
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "account/login";
	}
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
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
