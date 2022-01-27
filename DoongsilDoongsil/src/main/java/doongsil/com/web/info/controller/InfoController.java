package doongsil.com.web.info.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;
import doongsil.com.web.paging.model.PagingVo;

@Controller
public class InfoController {
	
	@Autowired
	private NoticeService noticeSer;

	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String Info(HttpSession session, Model model) throws Exception {
		int userNumber = (int)session.getAttribute("accountNumber");
		List<NoticeVO> noticeData = noticeSer.infoNoticeList(userNumber);
		
		if(noticeData.size() != 0) {
			session.setAttribute("myNoticeList", noticeData);
		}else {
			model.addAttribute("myNoticeListError","내가 쓴 게시물이 없습니다.");
		}
		return "info/info";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.GET)
	public String studentDel() {
		return "admin/popup/studentDel";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.POST)
	public String studentDel(HttpServletRequest request) {
		boolean all = Boolean.valueOf(request.getParameter("selectAll"));
		String[] student = request.getParameterValues("selectStudent");
		System.out.println("selectALl = " + all);
		System.out.println("selectStudent == " + Arrays.toString(student));
		
//		if(all) {
////			service.AllDelete();
//		}else {
////			for(String s: student) {
////				service.selectDelete(Integer.parseInt(s));
//			}
////		}
		
		return "admin/popup/studentDel";
	}
	@RequestMapping(value="/infoUpdate",method=RequestMethod.GET)
	public String infoUpdate() {
		return "admin/popup/infoUpdate";
	}
	@RequestMapping(value="/infoUpdate",method=RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request) {
		String name = request.getParameter("userName");
		String grade = request.getParameter("userGrade");
		String Gclass = request.getParameter("userClass");
		String adress = request.getParameter("userAdress");
		String email = request.getParameter("userEmail");
		String bd = request.getParameter("userBirthday");
		String path = request.getParameter("userPhoto");
		String type = request.getParameter("userType");
		
//		service.infoUpdate();
		return "admin/popup/infoUpdate";
	}
	
}
