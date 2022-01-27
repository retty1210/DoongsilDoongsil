package doongsil.com.web.Board.model;

import java.util.List;

public class PabBoardService {	
	
	public boolean insert(PabBoardVO pvo) {
		PabBoardDAO dao = new PabBoardDAO();
		boolean res = dao.insert(pvo);
		if(res) {
			dao.commit();
		} else {
			dao.rollback();
		}
		dao.close();
		return res;
	}
	
	public List<PabBoardVO> select(String id){
		PabBoardDAO dao = new PabBoardDAO();
	
		List<PabBoardVO> datas = dao.select(id);

		if(datas.size() != 0) {
			dao.close();
			return datas;
		}else {
			dao.close();
			return dao.select(id);
		}
	}
	
	public boolean delete(PabBoardVO pvo) {
		PabBoardDAO dao = new PabBoardDAO();
		boolean res = dao.delete(pvo);
		if(res) {
			dao.commit();
		} else {
			dao.rollback();
		}
		dao.close();
		return res;
	}
	
	public List<PabBoardVO> selectAll(){
		PabBoardDAO dao = new PabBoardDAO();
	
		List<PabBoardVO> datas = dao.selectAll();
		
		if(datas.size() != 0) {
			dao.close();
			return datas;
		}else {
			dao.close();
			return dao.selectAll();
		}
		
	}
	public boolean updateContent(PabBoardVO pvo) {
		PabBoardDAO dao = new PabBoardDAO();
		
		boolean res = dao.update(pvo);
		
		if(res) {
			dao.commit();
			dao.close();
		}else {
			dao.rollback();
			dao.close();
		}
		return res;
	}
	
}
