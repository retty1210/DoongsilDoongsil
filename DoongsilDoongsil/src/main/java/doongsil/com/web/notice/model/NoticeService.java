package doongsil.com.web.notice.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class NoticeService {
	
	@Autowired
	private NoticeDAO dao;
	
	//공지사항 작성
	public void write(NoticeVO noticeVO) throws Exception {
		dao.write(noticeVO);
	}

}
