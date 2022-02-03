package doongsil.com.web.paboard.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PabService {	
	
	@Autowired
	private PabDAO dao;
	
	
	public void insert(PabVO pabVO) throws Exception {
		dao.insert(pabVO);
	}
	
	
	public List<PabVO> list() throws Exception{
		return dao.list();
	}
	
	
	public PabVO view(int pab_id) throws Exception{
		return dao.view(pab_id);
	}
	

	public void update(PabVO pabVO) throws Exception{
		dao.update(pabVO);
	}
	

	public void delete(int pab_id) throws Exception{
		dao.delete(pab_id);
	}
	
}
