package doongsil.com.web.account.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class STAccountService {
	
	@Autowired
	private STAccountDAO stDao;
	
	public STAccountVO findId(STAccountVO stVo) {
		return this.stDao.findId(stVo);
	}
	
	public STAccountVO findPassword(STAccountVO stVo) {
		return this.stDao.findPassword(stVo);
	}
	
	public STAccountVO updatePassword(STAccountVO stVo) {
		return this.stDao.updatePassword(stVo);
	}
	
//	public int idCheck(String sta_username) throws Exception {
//		int result = stDao.idCheck(sta_username);
//		return result;
//	}
	
	public boolean join(STJoinVO stVo) throws Exception {
		int result = stDao.insertAccount(stVo);
		if(result == 1) {
			return true;
		}
		return false;
	}
	
	public STAccountVO staLogin(LoginVO loginVo) {
		STAccountVO stData = this.stDao.login(loginVo);
		if(stData == null) {
			return null;
		} else {
			stData.setSta_password("");
			return stData;
		}
	}
	
	public List<STAccountVO> infoStudentList(STAccountVO staVo) {
		return this.stDao.infoStudentList(staVo);
	}
	
	public STAccountVO studentUpdate(int id) {
		return this.stDao.studentUpdate(id);
	}
	
	public boolean infoUpdate(STAccountVO vo) {
		return this.stDao.infoUpdate(vo);
	}
	
	public boolean allDelete(int id) {
		return this.stDao.allDelete(id);
	}
	
	public boolean selectDelete(int id) {
		return this.stDao.selectDelete(id);	
	}
}
