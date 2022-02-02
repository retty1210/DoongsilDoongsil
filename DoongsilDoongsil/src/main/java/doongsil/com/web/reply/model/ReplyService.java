package doongsil.com.web.reply.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

	@Autowired
	ReplyDAO replyDAO;
	
	//댓글 조회
	public List<ReplyVO> readReply(int n_id) throws Exception{
		return replyDAO.readReply(n_id);
	}
	
	//댓글 작성
	public void writeReply(ReplyVO vo) throws Exception{
		replyDAO.writeReply(vo);
	}
	
	//댓글 수정
	public void updateReply(ReplyVO vo) throws Exception{
		replyDAO.updateReply(vo);
	}
	
	//댓글 삭제
	public void deleteReply(ReplyVO vo) throws Exception{
		replyDAO.deleteReply(vo);
	}
	//댓글 선택
	public ReplyVO selectReply(int reply_id) throws Exception{
		return replyDAO.selectReply(reply_id);
	}
	
}
