package doongsil.com.web.calendar.model;

import java.util.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import doongsil.com.web.notice.model.*;


@Service
public class CalendarService {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarService.class);
	
	@Autowired
	private CalendarDAO dao;
	
	
	public boolean InsertEvent(CalendarDTO dto) {
		
		logger.info("service 동작");
		boolean data = dao.insertEvents(dto);
		return data;
	}
	
	public List<CalendarDTO> selectEvent() {
		return dao.selectEvents();
	}
	
	public List<NoticeVO> selectNotice_two() {
		logger.info("Service 동작");
		return dao.selectNotice();
	}

}
