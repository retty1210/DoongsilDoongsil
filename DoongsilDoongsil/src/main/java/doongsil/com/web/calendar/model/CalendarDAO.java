package doongsil.com.web.calendar.model;

import org.apache.ibatis.session.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import doongsil.com.web.calendar.*;

@Repository
public class CalendarDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarDAO.class);
	
	@Autowired
	private SqlSession sess;

	public boolean insertEvents(CalendarDTO dto) {

		logger.info("dao 동작");
		int data = this.sess.insert("CalendarMapper.addEvent", dto);
		logger.info("dao 동작 = " + data);
		if(data == 1) {
			return true;			
		}else {
			return false;
		}
	}
}
