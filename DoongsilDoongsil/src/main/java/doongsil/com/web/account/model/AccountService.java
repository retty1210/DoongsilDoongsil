package doongsil.com.web.account.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.TransientDataAccessResourceException;
import org.springframework.transaction.annotation.Transactional;

import doongsil.com.web.account.model.AccountService;

public class AccountService {
	
//	private static final Logger logger = (Logger) LoggerFactory.getLogger(AccountService.class);
//	
//	@Autowired
//	private AccountDAO dao;
//	
//	@Transactional(rollbackFor = Exception.class)
//	public STAccountVO login(STLoginVO vo) {
//		STAccountVO data = dao.selectLoginAccount(vo);
//		data.setSta_password("");
//		return data;
//	}
//
//	public STAccountVO getBySns(STAccountVO snsUser) {
//		return null;
//	}
	
//	@Transactional(rollbackFor = Exception.class)
//	public boolean join(STJoinVO stVO) throws Exception {
//		if(!stVO.getSta_password().equals(stVO.getSta_password_chk())) {
//			logger.error("패스워드 불일치");
//			throw new TransientDataAccessResourceException(null);
//		}
//		
//		STAccountVO vo = new STAccountVO();
//		vo.setSta_username(stVO.getSta_username());
//		vo.setSta_password(stVO.getSta_password());
//		
//		if(vo.countingAccount(vo) != 0) {
//			logger.error("중복 아이디 발견!");
//			throw new Exception("중복 아이디가 존재 합니다.");
//		}
//		
//		vo.setId(vo.getAutoSequence()); // 자동증가 번호 획득 후 DTO 객체에 설정
//		
//		if(vo.insertAccount(vo) == 1) {
//			AccountInfoDTO dto2 = new AccountInfoDTO();
//			dto2.setId(dto.getId());
//			dto2.setFristName("");
//		}
//		
//	}
	
//	public List<STAccountVO> getAllAccount() {
//		return dao.selectLoginAccount();
//	}
//	
//	public STAccountVO login(STLoginVO vo) {
//		STAccountVO data = dao.selectLoginAccount(vo);
//		data.setSta_password("");
//		return data;
//	}
}
