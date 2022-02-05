package doongsil.com.web.info.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import doongsil.com.web.account.model.PAAccountVO;
import doongsil.com.web.account.model.STAccountVO;

public class InfoUpdateInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		String type = "";
		
		if(request.getAttribute("studentUpdate") != null) {
			STAccountVO userType = (STAccountVO)request.getAttribute("studentUpdate");
			type = userType.getSta_usertype();
		}
		if(request.getAttribute("parentUpdate") != null) {
			PAAccountVO userType = (PAAccountVO)request.getAttribute("parentUpdate");
		}
		System.out.println("dadadada +> "+type);
		System.out.println("interceptor => " + modelAndView.getViewName());
		if(type.equals("T")) {
			modelAndView.setViewName("admin/" + modelAndView.getViewName());
		} else if(type.equals("S")) {
			modelAndView.setViewName("student/" + modelAndView.getViewName());
		}else {
			modelAndView.setViewName("parent/" + modelAndView.getViewName());
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
