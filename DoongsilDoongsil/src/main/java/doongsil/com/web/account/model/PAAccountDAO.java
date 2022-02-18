package doongsil.com.web.account.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PAAccountDAO {
	
	@Autowired
	private SqlSession sess;
	
	public List<PAAccountVO> findId2(PAAccountVO paVO) {
		return this.sess.selectList("AccountMapper.findId2", paVO);
	}
	
	public PAAccountVO findPassword2(PAAccountVO paVO) {
		return this.sess.selectOne("AccountMapper.findPassword2", paVO);
	}
	
	public PAAccountVO updatePassword2(PAAccountVO paVO) {
		return this.sess.selectOne("AccountMapper.updatePassword2", paVO);
	}
	
	public PAAccountVO idCheck2(PAAccountVO paVO) {
		return this.sess.selectOne("AccountMapper.idCheck2", paVO);
	}
	
	public int insertAccount2(PAJoinVO paVo) {
		return this.sess.insert("AccountMapper.insertAccount2", paVo);
	}
	
	public PAAccountVO login(LoginVO loginVo) {
		return this.sess.selectOne("AccountMapper.pLoginSelect",loginVo); 
	}
	
	public PAAccountVO parentUpdate(int id) {
		System.out.println("dao 도착 ! " + id);
		return this.sess.selectOne("AccountMapper.parentUpdate",id);
	}
	
	public int parentInfoUpdate(PAAccountVO vo) {
		return this.sess.update("AccountMapper.parentInfoUpdate",vo);
	}
	
}
