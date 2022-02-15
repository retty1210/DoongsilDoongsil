package doongsil.com.web.homework.model;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import doongsil.com.web.account.model.STAccountVO;
import doongsil.com.web.paging.model.PagingVo;

@Repository
public class HomeworkDAO {
	
	@Autowired
	private SqlSession sess;
	
	public List<T_HomeworkVO> selectHWList() {
		List<T_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectHWList");
		return datas;
	}
	//앞에서부터 해당 페이지배열의 값만 읽어오는 쿼리
	public List<T_HomeworkVO> selectHWListFromFront(PagingVo res) {
		List<T_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectHWListFromFront", res);
		return datas;
	}
	//뒤에서부터 해당 페이지배열의 값만 읽어오는 쿼리
	public List<T_HomeworkVO> selectHWListFromBack(PagingVo res) {
		List<T_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectHWListFromBack", res);
		return datas;
	}
	
	public T_HomeworkVO selectOneHW(int id) {
		T_HomeworkVO vo = new T_HomeworkVO(id);
		T_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneHW", vo);
		return data;
	}
	
	public T_HomeworkVO selectOneHW(T_HomeworkVO vo) {
		T_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneHW", vo);
		return data;
	}
	
	public List<S_HomeworkVO> selectSHList(S_HomeworkVO vo) {
		List<S_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectSHList", vo);
		return datas;
	}
	
	public List<S_HomeworkVO> selectSHListWithName(S_HomeworkVO vo) {
		List<S_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectSHListWithName", vo);
		return datas;
	}
	
	public S_HomeworkVO selectOneSH(int id) {
		S_HomeworkVO vo = new S_HomeworkVO(id);
		S_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneSH", vo);
		return data;
	}
	
	public S_HomeworkVO selectOneSH(S_HomeworkVO vo) {
		S_HomeworkVO data = this.sess.selectOne("HomeworkMapper.selectOneSH", vo);
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
	
	public boolean SHGoodbad(S_HomeworkVO vo) {
		int res = this.sess.update("HomeworkMapper.updateSHGoodbad", vo);
		return res == 1 ? true : false;
	}
	
	public boolean SHComment(S_HomeworkVO vo) {
		int res = this.sess.update("HomeworkMapper.updateSHComment", vo);
		return res == 1 ? true : false;
	}
	
	public boolean updateSHContents(S_HomeworkVO vo) {
		int res = this.sess.update("HomeworkMapper.updateSHContents", vo);
		return res == 1 ? true : false;
	}
	
	public boolean updateTHCount(T_HomeworkVO vo) {
		int res = this.sess.update("HomeworkMapper.updateTHCount", vo);
		return res == 1 ? true : false;
	}
	
	public List<THO_CategoryVO> selectTHOCategory() {
		List<THO_CategoryVO> data = this.sess.selectList("HomeworkMapper.selectTHOCategory");
		return data;
	}
	
	public List<S_HomeworkVO> selectStudentHWs(S_HomeworkVO vo) {
		List<S_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectStudentHWs", vo);
		return datas;
	}
	
	public int selectListCount() {
		int pageCount = this.sess.selectOne("HomeworkMapper.selectListCount");
		return pageCount;
	}
	
	public List<T_HomeworkVO> selectTHwithClass(T_HomeworkVO vo) {
		List<T_HomeworkVO> datas = this.sess.selectList("HomeworkMapper.selectTHwithClass", vo);
		return datas;
	}
	
	//TODAY 날짜값 구하는 로직(이걸 안쓰길 바랬는데..)
//	public Date getToday() {
//		java.util.Date today = new java.util.Date();
//		long timeinMilli = today.getTime();
//		java.sql.Date day = new java.sql.Date(timeinMilli);
//		return day;
//	}
	
	//검증 로직
	public boolean TconfInsert(T_HomeworkVO vo) {
		T_HomeworkVO data = this.selectOneHW(vo);
		if(data != null) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean SconfInsert(S_HomeworkVO vo) {
		S_HomeworkVO data = this.selectOneSH(vo);
		return data != null ? true : false;
	}
	
	public boolean confDelete(T_HomeworkVO vo) {
		T_HomeworkVO data = this.selectOneHW(vo.getTho_id());
		return data == null ? true : false;
	}
	
	public boolean confDelete(S_HomeworkVO vo) {
		S_HomeworkVO data = this.selectOneSH(vo.getSho_id());
		return data == null ? true : false;
	}
	//학생용 내정보 페이지에 채점안된 숙제 불러오기
	public List<S_HomeworkVO> noCheckHomework(int id){
		return this.sess.selectList("HomeworkMapper.noCheckHomework",id);
	}

}
