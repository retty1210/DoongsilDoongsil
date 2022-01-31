package doongsil.com.web.homework.model;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import doongsil.com.web.account.model.STAccountVO;
import doongsil.com.web.paging.model.PagingVo;

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
		String[] contentsarr = contents.split("\\|\\|end\\|\\|");
		String[] mcarr = new String[10];
		int mcindex = 0; //객관식 문제 수
		String[] scarr = new String[10];
		int scindex = 0; //주관식 문제 수
		for(String a: contentsarr) {//객관식, 주관식 배열에 각각 구분해서 담는다
			System.out.println("contentsarr: " + a);
			if(a.contains("||mc||") || a.indexOf("||mc||") > 0) {
				mcarr[mcindex] = a;
				mcindex++;
			} else if(a.contains("||sc||") || a.indexOf("||sc||") > 0) {
				scarr[scindex] = a;
				scindex++;
			}
		}
		System.out.println("객관식 문제수: " + mcindex + "|주관식 문제수: " + scindex);
		//객관식 처리
		for(int mc = 0; mc < mcindex; mc++) {
			String[] mcfor = mcarr[mc].split("\\|\\|");
			for(String m : mcfor) {
				System.out.println("mcfor: " + m);
			}
			int num = Integer.parseInt(mcfor[0]);
			int length = (mcfor.length - 4) / 2;
			String[] value = new String[length + 4];
			value[0] = "mc";
			value[1] = mcfor[1];
			value[2] = length + ""; 
			for(int valnum = 3; valnum < length + 3; valnum++) {
				int index = (valnum * 2) - 2;
				value[valnum] = mcfor[index];
				System.out.println(mc + "번| " + index + " index| " + value[valnum]);
			}
			value[length + 3] = mcfor[mcfor.length - 1];
			
			type2contents.put(num, value);
		}
		//주관식 처리
		for(int sc = 0; sc < scindex; sc++) {
			String[] scfor = scarr[sc].split("\\|\\|");
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
	
	public int selectListCount() {
		int totalCount = dao.selectListCount();
		return totalCount;
	}
	
	public int getTotalPage(int countList) { //구하는값: 총 페이지 수 /변수: 한 페이지에 들어갈 글 개수
		int totalCount = dao.selectListCount();
		int totalPage = totalCount / countList;
		if(totalCount % countList > 0) {
			totalPage++;
		}//총 페이지 수를 구함: 수가 countList로 딱 나눠 떨어지지 않을 경우 1을 더해줌
		return totalPage;
	}
	
	public PagingVo getPageList(int pageNo, int pageListNum) {//현재 보고있는 페이지, 페이지용 ul에 한번에 띄울 페이지수
		int startdata = (pageNo - 1) / pageListNum;
		PagingVo page = new PagingVo();
		page.setLastPage(pageListNum * (startdata + 1));//리스트의 마지막 페이지
		page.setStartPage(page.getLastPage() - pageListNum + 1); //리스트의 첫번째 페이지
		return page;
	}
	
	public PagingVo getRNList(int pageNo, int countList, int pageListNum) {
		PagingVo page = this.getPageList(pageNo, pageListNum);
		int start = (page.getStartPage() - 1) * countList + 1;
		int end = (page.getLastPage()) * countList;
		page.setStart(start);
		page.setEnd(end);
		return page;
	}
	
	public List<T_HomeworkVO> getPage(int pageNo, int countList, int pageListNum) {
		//변수: 지금 보고있는 페이지, 한페이지에 들어갈 글 개수, 페이지용 ul 리스트에 한번에 띄울 페이지 수
		int totalCount = this.getTotalPage(countList);
		PagingVo page = this.getRNList(pageNo, countList, pageListNum);
		System.out.println("시작 줄 수: " + page.getStart() + "마지막 줄 수: " + page.getEnd());
		//현재페이지가 앞쪽에 가까울때/뒤쪽에 가까울때 쿼리 다르게 함
//		if((totalCount / pageNo) > 2) {
			List<T_HomeworkVO> datas = dao.selectHWListFromFront(page);
			return datas;
//		} else {
//			List<T_HomeworkVO> datas = dao.selectHWListFromBack(page);
//			return datas;
//		}
	}

}
