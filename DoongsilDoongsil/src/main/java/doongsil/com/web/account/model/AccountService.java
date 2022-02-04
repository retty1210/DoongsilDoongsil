package doongsil.com.web.account.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import doongsil.com.web.account.model.AccountService;

@Service
public class AccountService {
	
	private static final Logger logger = (Logger) LoggerFactory.getLogger(AccountService.class);
	
	@Autowired
	private AccountDAO dao;
	
	@Transactional(rollbackFor = Exception.class)
	public STAccountVO login(LoginVO vo) {
		STAccountVO data = this.dao.selectLoginAccount(vo);
		if(data == null) {
			return null;
		} else {
			data.setSta_password("");
			return data;
		}
	}

//	public STAccountVO getBySns(STAccountVO snsUser) {
//		return null;
//	}
	
//	public List<STAccountVO> getAllAccount() {
//		return dao.selectLoginAccount();
//	}

}
