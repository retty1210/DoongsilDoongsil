package doongsil.com.web.calendar;

import java.sql.Date;
import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.simple.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import doongsil.com.web.calendar.model.*;

@Controller
public class CalendarController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	CalendarService service;
	
	@RequestMapping(value="/cal", method=RequestMethod.GET)
	public String calendar() {
		return "module/cal";
	}
	
	@RequestMapping(value="/cal", method=RequestMethod.POST)
	@ResponseBody
	public String calendar(Model model, HttpServletRequest req) throws Exception {
	   SimpleDateFormat start = new SimpleDateFormat("yyyy-MM-DD HH:mm:ss");
	   java.sql.Date realStart = new java.sql.Date(start.parse(req.getParameter("cal_start")).getTime());
	   
	   SimpleDateFormat end = new SimpleDateFormat("yyyy-MM-DD HH:mm:ss");
	   java.sql.Date realEnd = new java.sql.Date(end.parse(req.getParameter("cal_end")).getTime());
	   
	   
	   System.out.println(realStart);
	   System.out.println(realEnd);
		logger.info("post 동작");
		return "module/cal";
	}
}
