package doongsil.com.web.account.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class STAccountService {
	
	private static final Logger logger = (Logger) LoggerFactory.getLogger(STAccountService.class);
	
	@Autowired
	private STAccountDAO stDao;
	
	public STAccountVO findId(STAccountVO stVo) {
		logger.info("아이디 데이터 받아옴");
		return this.stDao.findId(stVo);
	}
	
	public STAccountVO findPassword(STAccountVO stVo) {
		return this.stDao.findPassword(stVo);
	}
	
	public STAccountVO updatePassword(STAccountVO stVo) {
		return this.stDao.updatePassword(stVo);
	}
	
	public boolean idCheck(STAccountVO stVo) throws Exception {
		STAccountVO stDatas = stDao.idCheck(stVo);
		if(stDatas == null) {
			return false;
		} else {
			return true;
		}
	}
	
//	public boolean insertSns(STJoinVO stVo) throws Exception {
//		int result = stDao.insertSns(stVo);
//		if(result == 1) {
//			return true;
//		}
//		return false;
//	}
	
	public List<STAccountVO> findChild(STAccountVO stVo) {
		return this.stDao.findChild(stVo);
	}
	
	public STAccountVO snsLoginCheck(STAccountVO stVo) {
		STAccountVO stdatas = stDao.snsLoginCheck(stVo);
		if(stdatas == null) {
			return null;
		} else {
			return stdatas;
		}
	}
	
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
