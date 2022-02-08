package doongsil.com.web.account.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PAAccountService {
	
	@Autowired
	private PAAccountDAO paaDao;
	
	public PAAccountVO paaLogin(LoginVO loginVo) {
		PAAccountVO paData = this.paaDao.login(loginVo);
		if(paData == null) {
			return null;
		}else {
			paData.setSta_password("");
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
