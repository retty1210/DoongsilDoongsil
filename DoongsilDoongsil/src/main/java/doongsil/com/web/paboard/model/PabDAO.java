package doongsil.com.web.paboard.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import doongsil.com.web.paging.model.PagingVo;

@Repository
public class PabDAO {
	
	@Autowired
	private SqlSession sess;
		
	public int insert(PabVO pabVO) throws Exception {
		return this.sess.insert("PabMapper.insert", pabVO);		
	}
	
	public void update(PabVO pabVO) throws Exception{
		sess.update("PabMapper.update", pabVO);
	}
	
	
	public void delete(int pab_id) throws Exception{
		sess.delete("PabMapper.delete", pab_id);
	}
	
	public int countBoard() {
		return this.sess.selectOne("PabMapper.countBoard");
	}
	public List<PabVO> list(PagingVo pagingVo) throws Exception {
		return sess.selectList("PabMapper.list",pagingVo);
	}
	

	public PabVO view(int pab_id) throws Exception{
		return sess.selectOne("PabMapper.view", pab_id);
	}
	public void countUpdate(PabVO pabVO) {
		this.sess.update("PabMapper.CountUpdate",pabVO);
	}
	public List<PabVO> pab_Category(){
		return this.sess.selectList("PabMapper.pab_Category");
	}
	public List<PabVO> infoPaBoardList(int id){
		return this.sess.selectList("PabMapper.infoPaBoardList",id);
	}
}
	