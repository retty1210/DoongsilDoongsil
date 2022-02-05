package doongsil.com.web.calendar.controller;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.databind.*;

import doongsil.com.web.account.model.*;
import doongsil.com.web.calendar.model.*;
import doongsil.com.web.homework.model.*;
import doongsil.com.web.notice.model.*;

@Controller
public class CalendarController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	private CalendarService service;
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private CalendarDTO dto;
	
	@RequestMapping(value="/mainpage", method=RequestMethod.GET)
	public String calendar(Model model) {
		// 공지사항 출력하는 부분
		List<NoticeVO> notice_list = service.selectNotice_two();
		model.addAttribute("noticeList", notice_list);
		// 학급게시판 출력 부분
		List<T_HomeworkVO> homework_list = service.selectHomework();
		model.addAttribute("homeworkList", homework_list);
		// 캘린더 출력 부분
		//JSONObject json = new JSONObject();
		//json.put("calendarList", calendar_list);
		//logger.info("controller 동작");
		// 학사일정 출력 부분
		return "main/mainpage";
	}
	
	@RequestMapping(value="/getEvent", produces="application/text; charset=utf8", method=RequestMethod.GET)
	@ResponseBody
	public String getEvents(Model model) throws Exception {
		logger.info("getController 동작");
		List<CalendarDTO> calendar_list = service.selectCalendar();
		//HashMap<Integer, CalenderDTO> Integer: 달, CalenderDTO
		//for문을 1~12까지 돌게 만들어서
		//for문 안에서 임시로 쓸 CalenderDTO[]를 만들어서 Date중에 월이 for문 i와 동일한 거를 []에 넣고
		//HashMap에 key로 월, value로 CalenderDTO[]를 넣고
		//이걸 model에 넣어서 session에 뿌리고
		//js에서 지금 열려있는 calender의 월 값을 찾아서 그 값을 key로 넣어서 나오는 value값을 div에 뿌림
		//fc-next-button이나 fc-prev-button을 클릭했을때 거기에 맞게 key값을 바꾸도록 로직 짜기
		
		// 밑에 로직 공부
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(calendar_list);
		return jsonStr;
	}
	
	@RequestMapping(value="/insertDate", method=RequestMethod.POST)
	@ResponseBody
	public String calendar(CalendarDTO dto, Model model, HttpServletRequest req) throws Exception {
		// 로그인 하고 로그인 한 사람의 id가 선생님이면 일정 추가 가능 아니면 안되게 하기 
		String title = req.getParameter("cal_title");
		model.addAttribute("title_add", dto);
		//strat & end 데이터포맷변환
		java.sql.Date realStart = new java.sql.Date(dateFormat.parse(req.getParameter("cal_start")).getTime());
		dto.setCal_start(realStart);
		
		java.sql.Date realEnd = new java.sql.Date(dateFormat.parse(req.getParameter("cal_end")).getTime());
		dto.setCal_end(realEnd);
		
			service.InsertEvent(dto);
			logger.info("post 동작");
	   
		return "redirect:/main/mainpage";
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteEvents", method=RequestMethod.POST)
	public String deleteEvents(CalendarDTO dto, HttpServletRequest request) throws Exception {
		System.out.println(dto);
		logger.info("delete부분 메서드 동작");
		
		service.DeleteEvent(dto);
		return"redirect:/main/mainpage";
	}
	
}
