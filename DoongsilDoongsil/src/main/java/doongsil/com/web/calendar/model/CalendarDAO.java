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
		logger.info("dao 동작");
		int data = this.sess.insert("mainPageMapper.addEvent", dto);
		logger.info("dao 동작 = " + data);
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
		logger.info("Notice관련 DAO 동작");
		List<NoticeVO> a = this.sess.selectList("mainPageMapper.selectNotice");
		System.out.println(a);
		return this.sess.selectList("mainPageMapper.selectNotice");
	}

	public List<T_HomeworkVO> selectHomework() {
		return this.sess.selectList("mainPageMapper.selectHomework");
	}
	
}
