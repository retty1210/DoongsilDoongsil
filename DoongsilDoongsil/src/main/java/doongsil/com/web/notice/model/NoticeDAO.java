package doongsil.com.web.notice.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSession sess;
	
	//공지사항 작성
	public void write(NoticeVO noticeVO) throws Exception {
		sess.insert("noticeMapper.insert", noticeVO);		
	}

}
