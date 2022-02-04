package doongsil.com.web.account.model;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.SessionAttribute;

@Repository
public class AccountDAO {
	
	@Autowired
	private SqlSession sess;
	
	public STAccountVO selectLoginAccount(LoginVO vo) {
		return this.sess.selectOne("AccountMapper.selectLoginAccount", vo);
	}
	
	
}
