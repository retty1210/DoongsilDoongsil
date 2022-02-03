package doongsil.com.web.account.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class STAccountDAO {
	
	@Autowired
	private SqlSession sess;
	
	public STAccountVO login(LoginVO vo) {
		return this.sess.selectOne("AccountMapper.stLoginSelect",vo);
	}
	public List<STAccountVO> infoStudentList(STAccountVO staVo){
		return this.sess.selectList("AccountMapper.infoStudentList",staVo);
	}
	public STAccountVO studentUpdate(int id) {
		return this.sess.selectOne("AccountMapper.studentUpdate",id);
	}
	public boolean infoUpdate(STAccountVO vo) {
		int res =this.sess.update("AccountMapper.infoUpdate",vo);
		if(res == 1) {
			return true;
		} else {
			return false;
		}
	}
	public boolean allDelete(int id) {
		int res = this.sess.delete("AccountMapper.allDelete",id);
		if(res == 1) {
			return true;			
		}else {
			return false;
		}
	}
	public boolean selectDelete(int id) {
		int res = this.sess.delete("AccountMapper.selectDelete",id);
		
		if(res == 1) {
			return true;
		}else {
			return false;
		}
	}
}
