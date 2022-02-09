package doongsil.com.web.notice.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;


@Service
public class NoticeService {
	
	@Autowired
	private NoticeDAO dao;
	
	//공지사항 작성
	public void write(NoticeVO noticeVO) throws Exception {
		dao.write(noticeVO);
	}
	
	//공지사항 목록 조회
	public List<NoticeVO> list(Criteria cri) throws Exception{
		return dao.list(cri);
	}
	//내정보 페이지에 공지사항 목록 조회
	public List<NoticeVO> infoNoticeList(int writer) throws Exception{
		return dao.infoNoticeList(writer);
	}
	
	//게시물 총 갯수
	public int listCount() throws Exception{
		return dao.listCount();
	}
	
	//공지사항 상세 페이지, 조회수
	@Transactional(isolation = Isolation.READ_COMMITTED)
	public NoticeVO read(int not_id) throws Exception{
			   dao.noticeCount(not_id);
		return dao.read(not_id);
	}
	
	//공지사항 수정
	public void update(NoticeVO noticeVO) throws Exception{
		dao.update(noticeVO);
	}
	
	//공지사항 삭제
	public void delete(int not_id) throws Exception{
		dao.delete(not_id);
	}
	
	//댓글 수 표시
	public void updateReplyCount(int not_id) throws Exception{
		dao.updateReplyCount(not_id);
	}
	

}
