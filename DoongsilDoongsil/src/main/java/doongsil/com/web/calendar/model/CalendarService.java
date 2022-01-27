package doongsil.com.web.calendar.model;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;


@Service
public class CalendarService {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarService.class);
	
	@Autowired
	CalendarDAO dao;
	
	
	public CalendarDTO InsertEvent(CalendarDTO dto) {
		
		logger.info("service 동작");
		CalendarDTO data = dao.insertEvents(dto);
		return data;
	}

}
