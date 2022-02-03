package doongsil.com.web.info.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class InfoInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("logined") != null);
		if(session.getAttribute("logined") != null) {
			return true;
		} else {
			response.sendRedirect("/login");
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
<<<<<<< HEAD
		String userType = String.valueOf(session.getAttribute("accountType"));
		System.out.println("userType = " + userType);
		if(userType.equals("T")) {
			modelAndView.setViewName("admin/" + modelAndView.getViewName());
		} else if(userType.equals("S")) {
			modelAndView.setViewName("student/" + modelAndView.getViewName());
		}else {
			modelAndView.setViewName("parent/" + modelAndView.getViewName());
		}
=======
		//AccountVO vo = (AccountVO) session.getAttribute("account");
		
//		if(vo.getUserType().equals("T")) {
//			modelAndView.setViewName("admin/" + modelAndView.getViewName());
//		} else if(vo.getUserType().equals("S")) {
//			modelAndView.setViewName("student/" + modelAndView.getViewName());
//		}else {
//			modelAndView.setViewName("parent/" + modelAndView.getViewName());
//		}
>>>>>>> refs/remotes/origin/조정현

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
