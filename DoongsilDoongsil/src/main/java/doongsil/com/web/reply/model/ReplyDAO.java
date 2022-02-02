package doongsil.com.web.reply.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {
	
	@Autowired
	private SqlSession sess;
	
	//댓글 조회
	public List<ReplyVO> readReply(int n_id) throws Exception{
		return sess.selectList("replyMapper.readReply", n_id);
	}
	
	//댓글작성
	public void writeReply(ReplyVO vo) throws Exception{
		sess.insert("replyMapper.writeReply", vo);
	}
	
	//댓글 수정
	public void updateReply(ReplyVO vo) throws Exception{
		sess.update("replyMapper.updateReply", vo);
	}
	
	//댓글 삭제
	public void deleteReply(ReplyVO vo) throws Exception{
		sess.update("replyMapper.deleteReply", vo);
	}
	
	//선택된 댓글 조회
	public ReplyVO selectReply(int reply_id) throws Exception{
		return sess.selectOne("replyMapper.selectReply", reply_id);
	}
	

}
