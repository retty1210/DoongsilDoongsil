package doongsil.com.web.account.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.TransientDataAccessResourceException;
import org.springframework.stereotype.Repository;

import doongsil.com.web.account.AccountController;

@Repository
public class STAccountDAO {
	
	@Autowired
	private SqlSession sess;
	
	public List<STAccountVO> findId(STAccountVO stVo) {
		return this.sess.selectList("AccountMapper.findId", stVo);
	}
	
	public STAccountVO findPassword(STAccountVO stVo) {
		return this.sess.selectOne("AccountMapper.findPassword", stVo);
	}
	
	public STAccountVO updatePassword(STAccountVO stVo) {
		return this.sess.selectOne("AccountMapper.updatePassword", stVo);
	}

	public STAccountVO idCheck(STAccountVO stVo) {
		return this.sess.selectOne("AccountMapper.idCheck", stVo);
	}
	
	public STAccountVO selectAccount(STAccountVO vo) {
		return this.sess.selectOne("AccountMapper.selectAccount", vo);
	}
	
	public int insertAccount(STJoinVO stVo) {
		return this.sess.insert("AccountMapper.insertAccount", stVo);
	}
	
	public STAccountVO login(LoginVO vo) {
		return this.sess.selectOne("AccountMapper.stLoginSelect", vo);
	}
	
	public List<STAccountVO> findChild(STAccountVO stVo){
		return this.sess.selectList("AccountMapper.findChild", stVo);
	}
	
	public STAccountVO snsLoginCheck(STAccountVO stVo) {
		return this.sess.selectOne("AccountMapper.snsLoginCheck", stVo);
	}
	
//	public int insertSns(STJoinVO stVo) {
//		return this.sess.insert("AccountMapper.insertSns", stVo);
//	}
	
	public List<STAccountVO> infoStudentList(STAccountVO staVo){
		return this.sess.selectList("AccountMapper.infoStudentList", staVo);
	}
	
	public STAccountVO studentUpdate(int id) {
		return this.sess.selectOne("AccountMapper.studentUpdate", id);
	}
	
	public List<STAccountVO> selectNameFromID(List<Integer> idArr){
		return this.sess.selectList("AccountMapper.selectNameFromID", idArr);
	}
	
	public boolean infoUpdate(STAccountVO vo) {
		int res = this.sess.update("AccountMapper.infoUpdate", vo);
		if(res == 1) {
			return true;
		} else {
			return false;
		}
	}
	public boolean studentInfoUpdate(STAccountVO vo) {
		int res = this.sess.update("AccountMapper.studentInfoUpdate", vo);
		if(res == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean allDelete(int id) {
		int res = this.sess.delete("AccountMapper.allDelete", id);
		if(res == 1) {
			return true;			
		}else {
			return false;
		}
	}
	
	public boolean selectDelete(int id) {
		int res = this.sess.delete("AccountMapper.selectDelete", id);
		if(res == 1) {
			return true;
		}else {
			return false;
		}
	}
	
}
