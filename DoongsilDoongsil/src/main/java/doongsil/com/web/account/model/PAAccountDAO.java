package doongsil.com.web.account.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class PAAccountDAO {
	
	@Autowired
	private SqlSession sess;
	
	public int insertAccount2(PAJoinVO paVo) {
		return this.sess.insert("AccountMapper.insertAccount2", paVo);
	}
	
	public PAAccountVO login(LoginVO loginVo) {
		return this.sess.selectOne("AccountMapper.pLoginSelect",loginVo); 
	}
}
