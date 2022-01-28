package doongsil.com.web.calendar;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import doongsil.com.web.calendar.model.*;
import doongsil.com.web.notice.model.*;

@Controller
public class CalendarController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	private CalendarService service;
	private NoticeService NService;
	
	@RequestMapping(value="/cal", method=RequestMethod.GET)
	public String calendar(Model model) {
		List<NoticeVO> arr = service.selectNotice_two();
		logger.info("controller 동작");
		model.addAttribute("noticeList", arr);
		return "module/cal";
	}
	
	@RequestMapping(value="/cal", method=RequestMethod.POST)
	@ResponseBody
	public String calendar(CalendarDTO dto, Model model, HttpServletRequest req) throws Exception {
		String title = req.getParameter("cal_title");
		
		SimpleDateFormat start = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date realStart = new java.sql.Date(start.parse(req.getParameter("cal_start")).getTime());
		dto.setCal_start(realStart);
		SimpleDateFormat end = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date realEnd = new java.sql.Date(end.parse(req.getParameter("cal_end")).getTime());
		dto.setCal_end(realEnd);
		System.out.println(start.parse(req.getParameter("cal_start")).getTime());
		System.out.println(start.parse(req.getParameter("cal_end")).getTime());
		System.out.println(dto.getCal_title());
		System.out.println(dto.getCal_start());
		System.out.println(dto.getCal_end());
	   
		//CalendarDTO data = new CalendarDTO(title, realStart, realEnd);
		
		//if(data != null) {
			service.InsertEvent(dto);
			logger.info("post 동작");
		//}
	   
		return "module/cal";
	}
	
}
