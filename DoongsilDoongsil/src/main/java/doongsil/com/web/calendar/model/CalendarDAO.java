package doongsil.com.web.calendar.model;

import java.util.*;

import org.apache.ibatis.session.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import doongsil.com.web.homework.model.*;
import doongsil.com.web.notice.model.*;

@Repository
public class CalendarDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarDAO.class);
	
	@Autowired
	private SqlSession sess;

	public boolean insertEvents(CalendarDTO dto) {
		int data = this.sess.insert("mainPageMapper.addEvent", dto);
		if(data == 1) {
			return true;			
		}else {
			return false;
		}
	}
	
	public List<CalendarDTO> selectEvents() {
		return this.sess.selectList("mainPageMapper.selectEvents");
	}

	public List<NoticeVO> selectNotice() {
		return this.sess.selectList("mainPageMapper.selectNotice");
	}

	public List<T_HomeworkVO> selectHomework() {
		return this.sess.selectList("mainPageMapper.selectHomework");
	}

	public List<CalendarDTO> selectCalendar() {
		logger.info("DAO 동작");
		return this.sess.selectList("mainPageMapper.selectCalendar");
	}

	public boolean deleteEvent(CalendarDTO dto) {
		logger.info("dao 동작");
		int res = this.sess.delete("mainPageMapper.deleteEvent", dto);
		logger.info("dao 동작 = " + res);
		if(res == 1) {
			return true;
		}
		return false;
	}
	
}
