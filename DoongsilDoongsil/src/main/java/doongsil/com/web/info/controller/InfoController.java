package doongsil.com.web.info.controller;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
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

import doongsil.com.web.account.model.PAAccountService;
import doongsil.com.web.account.model.PAAccountVO;
import doongsil.com.web.account.model.STAccountService;
import doongsil.com.web.account.model.STAccountVO;
import doongsil.com.web.calendar.model.CalendarDTO;
import doongsil.com.web.calendar.model.CalendarService;
import doongsil.com.web.homework.model.HomeworkService;
import doongsil.com.web.homework.model.S_HomeworkVO;
import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;
import doongsil.com.web.paboard.model.PabService;
import doongsil.com.web.paboard.model.PabVO;

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
	@Autowired
	private CalendarService calSer;
	@Autowired
	private PabService pabSer;
	
	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String Info(HttpSession session, Model model) throws Exception {
		int userNumber = (Integer) session.getAttribute("accountNumber");
		STAccountVO staDto = (STAccountVO) session.getAttribute("account");
		LocalDate date = LocalDate.now();
		String now = String.valueOf(date);
		System.out.println(date);
		
		//???????????? ?????? ????????????
		List<NoticeVO> noticeData = noticeSer.infoNoticeList(userNumber);
		//???????????? ????????????
		List<STAccountVO> studentList = staSer.infoStudentList(staDto);
		//???????????? ?????? ????????????	
		List<S_HomeworkVO> noCheck = hwSer.noCheckHomework(userNumber);
		//???????????? ????????????
		List<CalendarDTO> cal = calSer.infoCalendar(now);
		
		//???????????? ????????????
		List<PabVO> pabList = pabSer.infoPaBoardList(userNumber);
		
		if(studentList.size() != 0) {
			session.setAttribute("infoStudentList", studentList);
		} else {
			model.addAttribute("infoStudentListError","?????? ????????? ????????????.");
		}
		if(noticeData.size() != 0) {
			session.setAttribute("myNoticeList", noticeData);
		}else {
			model.addAttribute("myNoticeListError","?????? ??? ???????????? ????????????.");
		}
		if(noCheck.size() != 0) {
			model.addAttribute("noCheckHomeworkList",noCheck);
		}else {
			model.addAttribute("noCheckError","?????? ?????? ????????? ????????????.");
		}
		if(cal.size() != 0) {
			model.addAttribute("schoolCal",cal);
		}else {
			model.addAttribute("schoolCalError","?????? ????????? ????????????.");
		}
		if(pabList.size() != 0) {
			model.addAttribute("paboardList",pabList);
		}else {
			model.addAttribute("paboardListError","?????? ??? ????????? ????????? ????????????.");
		}
		return "info/info";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.GET)
	public String studentDel() {
		return "admin/popup/studentDel";
	}
	@RequestMapping(value="/studentDel",method=RequestMethod.POST)
	public String studentDel(HttpServletResponse response,HttpServletRequest request, HttpSession session) throws Exception {
		response.setContentType("text/html; charset=UTF-8;");
		boolean all = Boolean.valueOf(request.getParameter("selectAll"));
		String[] student = request.getParameterValues("selectStudent");
		PrintWriter out = response.getWriter();
		System.out.println("all delete = > " + all);
		System.out.println("student delete = > " + Arrays.toString(student));
		
		
		if(all) {
			for(String s : student) {
				if(staSer.allDelete(Integer.parseInt(s))) {
					out.println("<script>alert('?????????????????? ?????? ?????? ????????????.');"
							+ "window.close();"
							+"opener.location.reload();"
							+ "</script>");
					
				}else {
					out.println("<script>alert('????????? ?????? ???????????????. ?????? ??????????????????.');"
							+ "location.reload();"
							+ "opener.location.reload();"
							+ "</script>");
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
				out.println("<script>alert('???????????? ?????????????????? ?????? ????????????.');"
						+ "window.close();"
						+ "opener.location.reload();"
						+ "</script>");
				
			}else {
				out.println("<script>alert('????????? ?????? ???????????????. ?????? ??????????????????.');"
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
		System.out.println("idNumber = > " + idNumber);
		STAccountVO studentUpdate = staSer.studentUpdate(idNumber);
		PAAccountVO parentUpdate = paaSer.parentUpdate(idNumber);
		
		req.setAttribute("parentUpdate",parentUpdate);
		req.setAttribute("studentUpdate",studentUpdate);
		return "popup/infoUpdate";
	}
	
	@RequestMapping(value="/admin/infoUpdate",method=RequestMethod.POST)
	public String infoUpdate(@RequestParam("userPhoto")MultipartFile multi,HttpServletRequest request,HttpServletResponse response, STAccountVO staVo,HttpSession session,Model model) throws Exception {
		response.setContentType("text/html; charset=UTF-8;");
		String save = request.getServletContext().getRealPath("/resources/upload/");
		int id = Integer.parseInt(request.getParameter("userId"));
		String name = request.getParameter("userName");
		int grade = Integer.parseInt(request.getParameter("userGrade"));
		int Gclass = Integer.parseInt(request.getParameter("userClass"));
		String newPassword = null;
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
		if(!request.getParameter("newPassword").isEmpty()) {
			newPassword = request.getParameter("newPassword");
		}
		
		update = new STAccountVO(id,name,email,adress,phone,grade,Gclass,bd,path,type,newPassword);
		PrintWriter out = response.getWriter();
		if(staSer.infoUpdate(update)) {
			update = staSer.studentUpdate(id);
			model.addAttribute("studentUpdate", update);
			session.setAttribute("account",update);
			out.println("<script>window.close(); opener.location.reload();</script>");
		}else {
			out.println("<script>alert('?????? ????????? ?????? ???????????????.');");
		}
		out.flush();
		return "popup/infoUpdate";
	}
	@RequestMapping(value="/student/infoUpdate",method=RequestMethod.POST)
	public String studentInfoUpdate(@RequestParam("userPhoto")MultipartFile multi,HttpServletRequest request,HttpServletResponse response, STAccountVO staVo,HttpSession session,Model model) throws Exception {
		response.setContentType("text/html; charset=UTF-8;");
		String save = request.getServletContext().getRealPath("/resources/upload/");
		int id = Integer.parseInt(request.getParameter("userId"));
		String name = request.getParameter("userName");
		String newPassword = null;
		String adress = request.getParameter("userAdress");
		String phone = request.getParameter("userPhone");
		String email = request.getParameter("userEmail");
		Date bd =Date.valueOf(request.getParameter("userBirthday"));
		String path = null;
		
		STAccountVO update;
		if(!multi.getOriginalFilename().isEmpty()) {
			path = "/stc/up/" + multi.getOriginalFilename();
			File file = new File(save + multi.getOriginalFilename());
			multi.transferTo(file);
		}
		if(!request.getParameter("newPassword").isEmpty()) {
			newPassword = request.getParameter("newPassword");
		}
		
		update = new STAccountVO(id,name,email,adress,phone,bd,path,newPassword);
		PrintWriter out = response.getWriter();
		if(staSer.studentInfoUpdate(update)) {
			update = staSer.studentUpdate(id);
			model.addAttribute("studentUpdate", update);
			session.setAttribute("account",update);
			out.println("<script>window.close(); opener.location.reload();</script>");
		}else {
			out.println("<script>alert('?????? ????????? ?????? ???????????????.');");
		}
		out.flush();
		return "popup/infoUpdate";
	}
	@RequestMapping(value="/parent/infoUpdate",method=RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		response.setContentType("text/html; charset=UTF-8;");
		int id = Integer.parseInt(request.getParameter("userId"));
		String phone = (String) request.getParameter("userPhone");
		String password = null;
		
		if(!request.getParameter("newPassword").isEmpty()) {
			password = (String) request.getParameter("newPassword");
		}
		
		PAAccountVO vo = new PAAccountVO(id,password,phone);
		
		PrintWriter out = response.getWriter();
		if(paaSer.parentInfoUpdate(vo)) {
			vo = paaSer.parentUpdate(vo.getPaa_id());
			session.setAttribute("account",vo);
			out.println("<script>window.close(); opener.location.reload();</script>");
		}else {
			out.println("<script>alert('?????? ????????? ?????? ???????????????.');");
		}
		out.flush();
		return "popup/infoUpdate";
	}
	@RequestMapping(value = "/popuppassword", method=RequestMethod.GET)
	public String popupPassword() {
		return "popuppassword/popupPassword";
	}
	
}
