package doongsil.com.web.notice.model;

import java.util.List;

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
	
	//공지사항 목록 조회
	public List<NoticeVO> list(Criteria cri) throws Exception {
		return sess.selectList("noticeMapper.listPage", cri);
	}
	
	//게시물 총 갯수
	public int listCount() throws Exception{
		return sess.selectOne("noticeMapper.listCount");
	}
	//내정보 페이지에서 공지사항 목록 조회
	public List<NoticeVO> infoNoticeList(int writer) throws Exception {
		return sess.selectList("noticeMapper.infoNoticeList",writer);
	}
	
	//공지사항 상세 페이지
	public NoticeVO read(int not_id) throws Exception{
		System.out.println("id = "+not_id);
		return sess.selectOne("noticeMapper.read", not_id);
	}
	
	//공지사항 수정
	public void update(NoticeVO noticeVO) throws Exception{
		sess.update("noticeMapper.update", noticeVO);
	}
	
	//공지사항 삭제
	public void delete(int not_id) throws Exception{
		sess.delete("noticeMapper.delete", not_id);
	}
	
	//공지사항 조회수
	public void noticeCount(int not_id) throws Exception {	
		sess.update("noticeMapper.noticeCount", not_id);
	}
	
}
