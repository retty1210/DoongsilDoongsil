package doongsil.com.web.account.model;

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
}
