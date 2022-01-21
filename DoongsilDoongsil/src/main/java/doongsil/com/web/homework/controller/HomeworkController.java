package doongsil.com.web.homework.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import doongsil.com.web.homework.model.*;

@Controller
public class HomeworkController {

	@Autowired
	private HomeworkService service;
	
	@RequestMapping(value = "/homework", method = RequestMethod.GET)
	public String homeworklist(HttpServletRequest request, HttpSession session) {
		List<T_HomeworkVO> datas = service.selectHWList();
		if(datas.size() == 0) {
			return "homework/empty";
		} else {
			session.setAttribute("datas", datas);
		}
		
		
		return "homework/list";
	}
	
	@RequestMapping(value="homework/write", method = RequestMethod.GET)
	public String homeworkwrite() {
		return "homework/write";
	}
}
