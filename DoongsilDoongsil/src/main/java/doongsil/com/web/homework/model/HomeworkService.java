package doongsil.com.web.homework.model;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import doongsil.com.web.account.model.STAccountVO;

@Service
public class HomeworkService {
	
	@Autowired
	private HomeworkDAO dao;
	
	public List<T_HomeworkVO> selectHWList() {
		List<T_HomeworkVO> datas = dao.selectHWList();
		return datas;
	}
	
	public T_HomeworkVO selectOneHW(int id) {
		T_HomeworkVO data = dao.selectOneHW(id);
		return data;
	}
	
	public T_HomeworkVO selectOneHW(T_HomeworkVO vo) {
		T_HomeworkVO data = dao.selectOneHW(vo);
		return data;
	}
	
	public List<S_HomeworkVO> selectSHList(S_HomeworkVO vo) {
		List<S_HomeworkVO> datas = dao.selectSHList(vo);
		return datas;
	}
	
	public List<S_HomeworkVO> selectSHList(int id) {
		S_HomeworkVO vo = new S_HomeworkVO();
		vo.setSho_tid(id);
		List<S_HomeworkVO> datas = dao.selectSHList(vo);
		return datas;
	}
	
	public S_HomeworkVO selectOneSH(int id) {
		S_HomeworkVO data = dao.selectOneSH(id);
		return data;
	}
	
	public S_HomeworkVO selectOneSH(S_HomeworkVO vo) {
		S_HomeworkVO data = dao.selectOneSH(vo);
		return data;
	}
	
	public boolean insertHW(T_HomeworkVO vo) {
		//Date today = dao.getToday();
		//vo.setTho_writedate(today);
		boolean res = dao.insertHW(vo);
		if(res) { //select를 해봐서 실제 insert가 잘 들어갔는지 확인
			System.out.println("homeworkservice, insert 완료, vo: " + vo);
			boolean result = dao.TconfInsert(vo);
			System.out.println("homeworkservice, select 검증: " + result);
			return result;
		}
		return res;
	}
	
	public boolean insertSH(S_HomeworkVO vo) {
		//Date today = dao.getToday();
		//vo.setSho_date(today);
		boolean res = dao.insertSH(vo);
		if(res) {
			System.out.println("homeworkservice, insert 완료, vo: " + vo);
			boolean result = dao.SconfInsert(vo);
			System.out.println("homeworkservice, select 검증: " + result);
			return result;
		}
		return res;
	}
	
	public String[] updateSHGoodCom(S_HomeworkVO vo) {
		boolean goodbadres = dao.SHGoodbad(vo);
		boolean commentres = dao.SHComment(vo);
		String[] res = new String[2];
		res[0] = goodbadres + "";
		res[1] = commentres + "";
		return res;
	}
	
	public boolean updateSHGood(S_HomeworkVO vo) {
		return dao.SHGoodbad(vo);
	}
	
	public boolean deleteHW(T_HomeworkVO vo) {
		boolean res = dao.deleteHW(vo);
		if(res) {
			boolean result = dao.confDelete(vo);
			return result;
		}
		return res;
	}
	
	public boolean deleteSH(S_HomeworkVO vo) {
		boolean res = dao.deleteSH(vo);
		if(res) {
			boolean result = dao.confDelete(vo);
			return result;
		}
		return res;
	}
	
	public boolean updateTHCount(T_HomeworkVO vo) {
		return dao.updateTHCount(vo);
	}
	
	public List<THO_CategoryVO> selectTHOCategory() {
		return dao.selectTHOCategory();
	}
	
	public List<S_HomeworkVO> selectStudentHWs(S_HomeworkVO vo) {
		return dao.selectStudentHWs(vo);
	}
	
	public String[] getImgList(String filelink) {
		String[] slist = new String[1];
		if(filelink.isEmpty()) {
			slist[0] = "noimage"; //이미지가 없을 경우
		} else {
			if(filelink.contains("_")) {
				slist = filelink.split("_");
			} else {
				slist[0] = filelink;
			}
		}
		return slist;
	}
	
	public HashMap<Integer, String[]> makeType2Visible(String contents) {
		HashMap<Integer, String[]> type2contents = new HashMap<Integer, String[]>();
		String[] contentsarr = contents.split("||end||");
		String[] mcarr = new String[10];
		int mcindex = 0; //객관식 문제 수
		String[] scarr = new String[10];
		int scindex = 0; //주관식 문제 수
		for(String a: contentsarr) {//객관식, 주관식 배열에 각각 구분해서 담는다
			if(a.contains("||mc||")) {
				mcarr[mcindex] = a;
				mcindex++;
			} else {
				scarr[scindex] = a;
				scindex++;
			}
		}
		//객관식 처리
		for(int mc = 0; mc < mcindex; mc++) {
			String[] mcfor = mcarr[mc].split("||");
			int num = Integer.parseInt(mcfor[0]);
			int length = (mcfor.length - 3) / 2;
			String[] value = new String[length + 3];
			value[0] = "mc";
			value[1] = mcfor[1];
			value[2] = length + ""; 
			for(int valnum = 3; valnum < length + 3; valnum++) {
				value[valnum] = mcfor[(valnum * 2) + 3];
			}
			type2contents.put(num, value);
		}
		//주관식 처리
		for(int sc = 0; sc < scindex; sc++) {
			String[] scfor = scarr[sc].split("||");
			int num = Integer.parseInt(scfor[0]);
			boolean res = scfor.length == 4 ? true: false;
			String[] value = new String[scfor.length];
			value[0] = "sc";
			value[1] = scfor[1];
			value[2] = res + "";
			if(res) {
				value[3] = scfor[3];
			}
			type2contents.put(num, value);
		}
		//String r = type2contents.get(1)[0];
		return type2contents;
		
	}

}
