package doongsil.com.web.paboard.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import doongsil.com.web.paging.model.PagingVo;

@Service
public class PabService {	
	
	@Autowired
	private PabDAO dao;
	
	
	public boolean insert(PabVO pabVO) throws Exception {
		int res = dao.insert(pabVO);
		
		if(res == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public int countBoard() {
		return this.dao.countBoard();
	}
	public List<PabVO> list(PagingVo pagingVo) throws Exception{
		return dao.list(pagingVo);
	}
	
	
	public PabVO view(int pab_id) throws Exception{
		return dao.view(pab_id);
	}
	public void countUpdate(PabVO pabVO) {
		this.dao.countUpdate(pabVO);
	}
	public void update(PabVO pabVO) throws Exception{
		dao.update(pabVO);
	}
	

	public void delete(int pab_id) throws Exception{
		dao.delete(pab_id);
	}
	public List<PabVO> pab_Category(){
		return this.dao.pab_Category();
	}
	public List<PabVO> infoPaBoardList(int id){
		return this.dao.infoPaBoardList(id);
	}
	
}
