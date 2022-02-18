package doongsil.com.web.account.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PAAccountService {
	
	private static final Logger logger = (Logger) LoggerFactory.getLogger(PAAccountService.class);
	
	@Autowired
	private PAAccountDAO paaDao;
	
	public List<PAAccountVO> findId2(PAAccountVO paVO) {
		logger.info("아이디 데이터 받아옴");
		return this.paaDao.findId2(paVO);
	}
	
	public PAAccountVO findPassword2(PAAccountVO paVO) {
		logger.info("패스워드 데이터 받아옴");
		return this.paaDao.findPassword2(paVO);
	}
	
	public PAAccountVO updatePassword2(PAAccountVO paVO) {
		return this.paaDao.updatePassword2(paVO);
	}
	
	public boolean idCheck2(PAAccountVO paVO) throws Exception {
		PAAccountVO paDatas = paaDao.idCheck2(paVO);
		if(paDatas == null) {
			return false;
		} else {
			return true;
		}
	}

	public PAAccountVO paaLogin(LoginVO loginVo) {
		PAAccountVO paData = this.paaDao.login(loginVo);
		if(paData == null) {
			return null;
		}else {
			return paData;
		}
	}
	
	public PAAccountVO parentUpdate(int id) {
		System.out.println("service on " + id);
		PAAccountVO paData = this.paaDao.parentUpdate(id);
		
		return paData;
	}
	
	public boolean parentInfoUpdate(PAAccountVO vo) {
		int res = this.paaDao.parentInfoUpdate(vo);
		
		if(res == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean join(PAJoinVO paVo) throws Exception {
		int result = paaDao.insertAccount2(paVo);
		if(result == 1) {
			return true;
		}
		return false;
	}

}
