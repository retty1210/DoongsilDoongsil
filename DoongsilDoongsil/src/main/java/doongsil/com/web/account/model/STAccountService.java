package doongsil.com.web.account.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class STAccountService {
	
	@Autowired
	private STAccountDAO stDao;
	
	public STAccountVO staLogin(LoginVO loginVo) {
		
		STAccountVO stData = this.stDao.login(loginVo);
		if(stData == null) {
			return null;
		}else {
			stData.setSta_password("");
			return stData;
		}
		
	}
}
