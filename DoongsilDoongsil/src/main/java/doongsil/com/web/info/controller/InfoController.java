package doongsil.com.web.info.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import doongsil.com.web.paging.model.PagingVo;

@Controller
public class InfoController {

	@RequestMapping(value="admin/info",method=RequestMethod.GET)
	public String adminInfo() {
		return "admin/info/info";
	}
	@RequestMapping(value="parent/info",method=RequestMethod.GET)
	public String parentInfo() {
		return "parent/info/info";
	}
	@RequestMapping(value="student/info",method=RequestMethod.GET)
	public String studentInfo() {
		return "student/info/info";
	}
}
