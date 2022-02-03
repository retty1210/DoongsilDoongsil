package doongsil.com.web.account.model;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.SessionAttribute;

@Repository
public class AccountDAO {
	
//	@Autowired
//	private SqlSession sess;
//	
//	public STAccountVO selectLoginAccount(STLoginVO vo) {
//		STAccountVO data = this.sess.selectOne("AccountMapper.selectLoginAccount", vo);
//		return data;
//	}
	
//	public STAccountVO getBySns(STAccountVO snsUser) {
//		if(StringUtils.isNotEmpty((snsUser.getSocial_type("n"))) {
//			return session.selectOne(GET_BY_SNS_NAVER, snsUser.getSocial_type())
//		}
//		return null;
//	}
	
//	public List<STAccountVO> selectLoginAccount() {
//		List<STAccountVO> datas = this.sess.selectList("AccountMapper.selectLoginAccount");
//		return datas;
//	}
	
}
