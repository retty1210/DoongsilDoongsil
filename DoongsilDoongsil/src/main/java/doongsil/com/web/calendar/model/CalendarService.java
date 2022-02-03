package doongsil.com.web.calendar.model;

import java.util.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import doongsil.com.web.homework.model.*;
import doongsil.com.web.notice.model.*;


@Service
public class CalendarService {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarService.class);
	
	@Autowired
	private CalendarDAO dao;
	
	
	public boolean InsertEvent(CalendarDTO dto) {
		boolean data = dao.insertEvents(dto);
		return data;
	}
	
	public List<CalendarDTO> selectEvent() {
		return dao.selectEvents();
	}
	
	public List<NoticeVO> selectNotice_two() {
		return dao.selectNotice();
	}

	public List<T_HomeworkVO> selectHomework() {
		return dao.selectHomework();
	}

	public List<CalendarDTO> selectCalendar() {
		return dao.selectCalendar();
	}

	public boolean DeleteEvent(CalendarDTO dto) {
		logger.info("Service 동작");
		boolean res = dao.deleteEvent(dto);
		return res;
	}

}
