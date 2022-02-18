package doongsil.com.web.homework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class HomeworkInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		boolean ifLogin = this.confirmLogin(request);
		String accountType = "";
		if(ifLogin) {
			accountType = session.getAttribute("accountType").toString();
			if(accountType.equals("T") || accountType.equals("S")) {
				System.out.println("teacher/student");
				return true;
			} else if(accountType.equals("P")) {
				System.out.println("parents");
				session.setAttribute("error", true);
				session.setAttribute("errormsg", "학급게시판은 학생, 교사만 이용 가능한 게시판입니다.");
				response.sendRedirect("/");
				return false;
			} else {
				System.out.println("other");
				response.sendRedirect("/");
				return false;
			}
		} else {
			session.setAttribute("error", true);
			session.setAttribute("errormsg", "학급게시판은 학생, 교사만 이용 가능한 게시판입니다. 로그인해주세요.");
			response.sendRedirect("/login");
			return false;
		}
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}
	
	public boolean confirmLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("logined") != null && session.getAttribute("account") != null 
				&& session.getAttribute("accountType") != null && session.getAttribute("accountNumber") != null) {
			return true;
		} else {
			return false;
		}
	}

}
