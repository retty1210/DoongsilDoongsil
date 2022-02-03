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
}
