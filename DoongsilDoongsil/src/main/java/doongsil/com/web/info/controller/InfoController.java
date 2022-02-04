package doongsil.com.web.info.controller;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import doongsil.com.web.account.model.PAAccountService;
import doongsil.com.web.account.model.PAAccountVO;
import doongsil.com.web.account.model.STAccountService;
import doongsil.com.web.account.model.STAccountVO;
import doongsil.com.web.homework.model.HomeworkService;
import doongsil.com.web.homework.model.S_HomeworkVO;
import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;
import doongsil.com.web.paging.model.PagingVo;

@Controller
public class InfoController {
	private static final Logger logger = LoggerFactory.getLogger(InfoController.class);
	@Autowired
	private NoticeService noticeSer;
	@Autowired
	private STAccountService staSer;
	@Autowired
	private HomeworkService hwSer;
	@Autowired
	private PAAccountService paaSer;
	
	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String Info(HttpSession session, Model model) throws Exception {
		int userNumber = (int)session.getAttribute("accountNumber");
		STAccountVO staDto = (STAccountVO) session.getAttribute("account");
	
		//공지사항 목록 불러오기
		List<NoticeVO> noticeData = noticeSer.infoNoticeList(userNumber);
		//학생목록 불러오기
		List<STAccountVO> studentList = staSer.infoStudentList(staDto);
		//채점안된 숙제 불러오기	
		List<S_HomeworkVO> noCheck = hwSer.noCheckHomework(userNumber);
		if(studentList.size() != 0) {
			session.setAttribute("infoStudentList", studentList);
		} else {
			model.addAttribute("infoStudentListError","학생 목록이 없습니다.");
		}
		if(noticeData.size() != 0) {
			session.setAttribute("myNoticeList", noticeData);
		}else {
			model.addAttribute("myNoticeListError","내가 쓴 게시물이 없습니다.");
		}
		if(noCheck.size() != 0) {
			model.addAttribute("noCheckHomeworkList",noCheck);
		}else {
			model.addAttribute("noCheckError","채점 안된 목록이 없습니다.");
		}
		return "info/info";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.GET)
	public String studentDel() {
		return "admin/popup/studentDel";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.POST)
	public String studentDel(HttpServletResponse response,HttpServletRequest request, HttpSession session) throws Exception {
		boolean all = Boolean.valueOf(request.getParameter("selectAll"));
		String[] student = request.getParameterValues("selectStudent");
		PrintWriter out = response.getWriter();
		System.out.println("all delete = > " + all);
		System.out.println("student delete = > " + Arrays.toString(student));
		
		
		if(all) {
			for(String s : student) {
				if(staSer.allDelete(Integer.parseInt(s))) {
					out.println("<script>alert('학생데이터를 전체 삭제 했습니다.');"
							+ "window.close();"
							+ "</script>");
					return "redirect:info/info";
					
				}else {
					out.println("<script>alert('삭제에 실패 하셨습니다. 다시 시도해주세요.');"
							+ "location.reload();"
							+ "opener.location.reload();"
							+ "</script>");
					return "redirect:admin/popup/studentDel";
				}
			}
		}else {
			boolean selectDel = false;
			for(String s: student) {
				if(staSer.selectDelete(Integer.parseInt(s))) {
					selectDel = true;
				}
			}
			if(selectDel) {
				out.println("<script>alert('선택하신 학생데이터를 삭제 했습니다.');"
						+ "window.close();"
						+ "opener.location.reload();"
						+ "</script>");
				
			}else {
				out.println("<script>alert('삭제에 실패 하셨습니다. 다시 시도해주세요.');"
						+ "location.reload();"
						+ "opener.location.reload();"
						+ "</script>");
			}
		}
		out.flush();
		return "admin/popup/studentDel";
	}
	@RequestMapping(value="/infoUpdate",method=RequestMethod.GET)
	public String studentInfoUpdate(HttpServletRequest req, Model model) {
		int idNumber = Integer.parseInt(req.getParameter("id"));
		
		STAccountVO studentUpdate = staSer.studentUpdate(idNumber);
		PAAccountVO parentUpdate = paaSer.parentUpdate(idNumber);
		
		req.setAttribute("parentUpdate",parentUpdate);
		req.setAttribute("studentUpdate",studentUpdate);
		return "popup/infoUpdate";
	}
	
	@RequestMapping(value="/admin/infoUpdate",method=RequestMethod.POST)
	public String infoUpdate(@RequestParam("userPhoto")MultipartFile multi,HttpServletRequest request,HttpServletResponse response, STAccountVO staVo,HttpSession session,Model model) throws Exception {
		
		String save = request.getServletContext().getRealPath("/resources/upload/");
		int id = Integer.parseInt(request.getParameter("userId"));
		String name = request.getParameter("userName");
		int grade = Integer.parseInt(request.getParameter("userGrade"));
		int Gclass = Integer.parseInt(request.getParameter("userClass"));
		String adress = request.getParameter("userAdress");
		String phone = request.getParameter("userPhone");
		String email = request.getParameter("userEmail");
		Date bd =Date.valueOf(request.getParameter("userBirthday"));
		String path = null;
		String type = request.getParameter("userType");
		
		STAccountVO update;
		if(!multi.getOriginalFilename().isEmpty()) {
			path = "/stc/up/" + multi.getOriginalFilename();
			File file = new File(save + multi.getOriginalFilename());
			multi.transferTo(file);
		}
		
		update = new STAccountVO(id,name,email,adress,phone,grade,Gclass,bd,path,type);
		
		PrintWriter out = response.getWriter();
		if(staSer.infoUpdate(update)) {
			update = staSer.studentUpdate(id);
			model.addAttribute("studentUpdate", update);
			out.println("<script>opener.location.reload(); window.close();</script>");
		}else {
			out.println("<script>alert('정보 수정에 실패 하였습니다.');");
		}
		out.flush();
		return "admin/popup/infoUpdate";
	}
	@RequestMapping(value="/parent/infoUpdate",method=RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String phone = (String) request.getParameter("userPhone");
		String password = (String) request.getParameter("newPassword");
		
		PAAccountVO vo = new PAAccountVO(password,phone);
		
		PrintWriter out = response.getWriter();
		if(paaSer.parentInfoUpdate(vo)) {
			out.println("<script>opener.location.reload(); window.close();</script>");
		}else {
			out.println("<script>alert('정보 수정에 실패 하였습니다.');");
		}
		return "parent/popup/infoUpdate";
	}
	
}
