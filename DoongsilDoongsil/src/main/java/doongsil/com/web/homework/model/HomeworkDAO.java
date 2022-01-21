package doongsil.com.web.homework.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import doongsil.com.web.account.model.STAccountVO;

@Repository
public class HomeworkDAO {
	
	@Autowired
	private SqlSession sess;
	
	public List<T_HomeworkVO> selectHWList() {
		List<T_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectHWList");
		return datas;
	}
	
	public T_HomeworkVO selectOneHW(int id) {
		T_HomeworkVO vo = new T_HomeworkVO(id);
		T_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneHW", vo);
		return data;
	}
	
	public List<S_HomeworkVO> selectSHList() {
		List<S_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectSHList");
		return datas;
	}
	
	public S_HomeworkVO selectOneSH(STAccountVO sta) {
		S_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneSH", sta);
		return data;
	}
	
	public boolean insertHW(T_HomeworkVO vo) {
		int res = this.sess.insert("HomeworkMapper.insertHW", vo);
		return res == 1 ? true : false;
	}
	
	public boolean insertSH(S_HomeworkVO vo) {
		int res = this.sess.insert("HomeworkMapper.insertSH", vo);
		return res == 1 ? true : false;
	}
	
	public boolean deleteHW(T_HomeworkVO vo) {
		int res = this.sess.delete("HomeworkMapper.deleteHW", vo);
		return res == 1 ? true : false;
	}
	
	public boolean deleteSH(S_HomeworkVO vo) {
		int res = this.sess.delete("HomeworkMapper.deleteSH", vo);
		return res == 1 ? true : false;
	}
	
	

}
