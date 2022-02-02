package doongsil.com.web.calendar.controller;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import doongsil.com.web.calendar.model.*;
import doongsil.com.web.homework.model.*;
import doongsil.com.web.notice.model.*;

@Controller
public class CalendarController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	private CalendarService service;
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	@RequestMapping(value="/mainpage", method=RequestMethod.GET)
	public String calendar(Model model) {
		// 공지사항 출력하는 부분
		List<NoticeVO> notice_list = service.selectNotice_two();
		model.addAttribute("noticeList", notice_list);
		// 학급게시판 출력 부분
		List<T_HomeworkVO> homework_list = service.selectHomework();
		model.addAttribute("homeworkList", homework_list);
		// 캘린더 출력 부분
		List<CalendarDTO> calendar_list = service.selectCalendar();
		//System.out.println(calendar_list);
		model.addAttribute("calendarList", calendar_list);
		logger.info("controller 동작");
		// 학사일정 출력 부분
		return "main/mainpage";
	}
	
	@RequestMapping(value="/mainpage", method=RequestMethod.POST)
	@ResponseBody
	public String calendar(CalendarDTO dto, HttpServletRequest req) throws Exception {
		String title = req.getParameter("cal_title");
		//strat & end 데이터포맷변환
		java.sql.Date realStart = new java.sql.Date(dateFormat.parse(req.getParameter("cal_start")).getTime());
		dto.setCal_start(realStart);
		
		java.sql.Date realEnd = new java.sql.Date(dateFormat.parse(req.getParameter("cal_end")).getTime());
		dto.setCal_end(realEnd);
		
			service.InsertEvent(dto);
			logger.info("post 동작");
	   
		return "redirect:/main/mainpage";
	}
	
	@RequestMapping(value="/deleteEvents", method=RequestMethod.POST)
	public String deleteEvents(CalendarDTO dto, HttpServletRequest request) throws Exception {
		logger.info("delete부분 메서드 동작");
		String delete_title = request.getParameter("title");
		
		java.sql.Date delete_start = new java.sql.Date(dateFormat.parse(request.getParameter("cal_start")).getTime());
		dto.setCal_start(delete_start);
		java.sql.Date delete_end = new java.sql.Date(dateFormat.parse(request.getParameter("cal_end")).getTime());
		dto.setCal_end(delete_end);
		
		service.DeleteEvent(dto);
		return"redirect:/main/mainpage";
	}
	
}
