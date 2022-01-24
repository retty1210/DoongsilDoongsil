package doongsil.com.web.calendar;

import org.mybatis.logging.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class CalendarController {
	
	@RequestMapping(value="/cal", method=RequestMethod.GET)
	public String calendar() {
		return "module/cal";
	}
}
