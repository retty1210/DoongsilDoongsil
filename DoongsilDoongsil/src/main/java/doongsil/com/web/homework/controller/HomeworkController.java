package doongsil.com.web.homework.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import doongsil.com.web.account.model.STAccountService;
import doongsil.com.web.account.model.STAccountVO;
import doongsil.com.web.homework.model.*;
import doongsil.com.web.paging.model.PagingVo;

@Controller
public class HomeworkController {

	@Autowired
	private HomeworkService service;
	
	@Autowired
	private STAccountService staService;
	
	@RequestMapping(value = "/homework", method = RequestMethod.GET)
	public ModelAndView homeworklist(HttpServletRequest request, HttpSession session, @RequestParam(value="pageNo", defaultValue="1") int pageNo) {
		ModelAndView mod = new ModelAndView();
		//int totalcount = service.selectListCount();
		//List<T_HomeworkVO> datas = service.selectHWList();
		if(session.getAttribute("logined") == null) {
			mod.setViewName("homework/empty");
		} else {
			STAccountVO loginUser = (STAccountVO) session.getAttribute("account");
			System.out.println(loginUser);
			T_HomeworkVO userdata = new T_HomeworkVO();
			int userClass = loginUser.getSta_class();
			int userGrade = loginUser.getSta_grade();
			userdata.setTho_class(userClass);
			userdata.setTho_grade(userGrade);
			System.out.println(userdata);
			
			int countList = 5; //한페이지에 들어갈 글 개수
			int pageListNum = 3; //페이지용 ul 리스트에 한번에 띄울 페이지 수
			HashMap<Integer, List<T_HomeworkVO>> datas = service.makeTHClassPage(userdata, countList);
			//페이지별로 가져오는 걸로 코드 고치기-여기선 1페이지 기준으로(RequestParam pageNo)
			System.out.println("pageNo: " + pageNo);
			
			int totalpage = datas.size() % countList == 0 ? (datas.size() / countList) : (datas.size() / countList + 1);
			if(pageNo > totalpage) {
				pageNo = totalpage;
			} else if(pageNo < 1) {
				pageNo = 1;
			}
			
			PagingVo pages = new PagingVo();
			pages.setNowPage(pageNo);
			pages.setCntPerPage(countList);
			pages.setTotal(totalpage);
			
			int pageCount = pageNo / pageListNum;
			pages.setStartPage((pageCount * pageListNum) + 1);
			pages.setEndPage((pageCount + 1) * pageListNum);
			System.out.println(pages);
			/* 
			 * 만약 총 7페이지, 한번에 3페이지씩 나오고 지금 2페이지
			 * 7/2 = 3, 나머지1: 마지막페이지는 지금 + 1, 시작페이지는 지금 - 1  2/3=0, 나머지2: 몫+1번째 페이지, 나머지번째에 현재페이지 있음
			 * 2번째 페이지의 시작페이지: 1*3 + 1 3번째: 2*3 + 1
			 * 만약 총 15페이지, 한번에 4페이지씩, 지금 5페이지
			 * 15/5=3, 나머지0: 15/4=3, 나머지3:  5/4=1, 나머지1: 몫+1번째 페이지, 나머지번째에 현재페이지가 있음
			 * */
			
			mod.addObject("pageNo", pageNo);
			mod.addObject("pages", pages);
//			mod.addObject("countList", countList);
//			mod.addObject("pageListNum", pageListNum);
			mod.addObject("datas", datas);
			mod.setViewName("homework/list");
		}
		
		return mod;
	}
	
	@RequestMapping(value="homework/write", method = RequestMethod.GET)
	public ModelAndView homeworkwrite() {
		ModelAndView mod = new ModelAndView();
		List<THO_CategoryVO> datas = service.selectTHOCategory();
		mod.addObject("datas", datas);
		mod.setViewName("homework/write");
		return mod;
	}
	
	@RequestMapping(value="/homework/write/up", method = RequestMethod.POST)
	public String upHomework(T_HomeworkVO vo) {
		boolean res = service.insertHW(vo);
		if(res) {
			System.out.println("homework form 업로드 성공");
			return "redirect:/homework";
		} else {
			System.out.println("homework form 업로드 실패");
			return "homework/error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/homework/write/up/file")
	public String upHomeworkFile(MultipartFile[] uploadFile, HttpServletRequest request) {
		String r = request.getServletContext().getRealPath("/resources/upload/");
		String uploadFolder = "C:\\Users\\retty\\git\\DoongsilDoongsil\\DoongsilDoongsil\\src\\main\\webapp\\resources\\upload";
		String tho_filelink = "";
		for(MultipartFile file: uploadFile) {
			if(!tho_filelink.isEmpty()) {
				tho_filelink += "_";
			}
			//파일명 정하기
			String originalFileName = file.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
			
			String rand = UUID.randomUUID() + "";//랜덤한 문자열
			String randomstr = rand.substring(rand.lastIndexOf("-") + 1);
			
			SimpleDateFormat sdf = new SimpleDateFormat("YYMMDDHHmm"); //업로드날짜와 시간
			java.util.Date date = new java.util.Date();
			String datetostr = sdf.format(date);
			
			String savedFileName = datetostr + randomstr + extension;	//저장될 파일명
			System.out.println("HomeworkController, filename: " + savedFileName);
			tho_filelink += savedFileName;
			
			File saveFile = new File(r, savedFileName); //uploadFolder
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return tho_filelink;
	}
	
	@RequestMapping(value="/homework/detail", method=RequestMethod.GET)
	public ModelAndView homeworkDetail(T_HomeworkVO vo, HttpServletRequest request, HttpSession session) {
		ModelAndView mod = new ModelAndView();
		
		T_HomeworkVO data = service.selectOneHW(vo);
		
		//조회수
		int count = data.getTho_count() + 1;
		data.setTho_count(count);
		boolean countres = service.updateTHCount(data);
		if(!countres) {
			mod.setViewName("homework/error");
			return mod;
		}
		System.out.println("count결과: " + data.getTho_count());
		
		//글쓴이 이름
		STAccountVO writerData = staService.studentUpdate(data.getTho_writer());
		mod.addObject("writerName", writerData.getSta_name());
		
		//이미지
		String[] imgarr = new String[1];
		if(data.getTho_filelink()== null) {
			imgarr[0] = "noimage";
		} else {
			imgarr = service.getImgList(data.getTho_filelink());
		}
		
		int durDate = 0;
		
		//type별 처리
		if(data.getTho_homeworktype() == 2) {
			System.out.println(data.getTho_contents());
			HashMap<Integer, String[]> type2contents = service.makeType2Visible(data.getTho_contents());
			System.out.println(type2contents);
			mod.addObject("type2contents", type2contents);
		} else if(data.getTho_homeworktype() == 3) {
			LocalDate[] type3DayArr = service.maketype3DayArr(data);
			mod.addObject("type3DayArr", type3DayArr);
		}
		
		//글 값 넣기
		if(data != null) {
			mod.addObject("data", data);
			System.out.println("data: " + data);
		} 
		
		if(session.getAttribute("accountType").equals("T")) { //선생님일 때
			List<S_HomeworkVO> sdatas = service.selectSHList(data.getTho_id());
			System.out.println("teacher, sdatas size: " + sdatas.size());
			if(sdatas != null) {
				mod.addObject("sdatas", sdatas);
				HashMap<Integer, String[]> studentImages = new HashMap<Integer, String[]>();
				for(S_HomeworkVO simg: sdatas) {
					String[] simgarrs = new String[1];
					if(simg.getSho_fileurl() != null) {
						simgarrs = service.getImgList(simg.getSho_fileurl());
						studentImages.put(simg.getSho_id(), simgarrs);
					}
				}
				if(data.getTho_homeworktype() == 2) {
					HashMap<Integer, String[]> type2answers = new HashMap<Integer, String[]>();
					HashMap<Integer, String[]> type2teacGBs = new HashMap<Integer, String[]>();
					for(S_HomeworkVO s: sdatas) {
						String[] tempsdatas = service.makeType2Answer(s);
						type2answers.put(s.getSho_id(), tempsdatas);
						if(s.getSho_goodbad() != null) {
							String[] teacGBarr = s.getSho_goodbad().split("");
							type2teacGBs.put(s.getSho_id(), teacGBarr);
						}
					}
					mod.addObject("studentImages", studentImages);
					mod.addObject("type2answers", type2answers);
					mod.addObject("type2GBforTeacher", type2teacGBs);
				} else if(data.getTho_homeworktype() == 3) {
					LocalDate[] type3DayArr = service.maketype3DayArr(data);
					int[] sizeArr = new int[type3DayArr.length];
					HashMap<Integer, List<S_HomeworkVO>> sArrforTeacher = new HashMap<Integer, List<S_HomeworkVO>>();
					for(int i = 0; i < type3DayArr.length; i++) {
						java.sql.Date newDate = Date.valueOf(type3DayArr[i]);
						List<S_HomeworkVO> sArrforT = new ArrayList<S_HomeworkVO>();
						System.out.println("newDate: " + newDate + ", Arr: " + type3DayArr[i]);
						System.out.println("sdatas.size: " + sdatas.size());
						for(int j = 0; j < sdatas.size(); j++) {
							System.out.println("inner for문 진입 : " + sdatas.get(j).getSho_date());
							if(sdatas.get(j).getSho_date().equals(newDate)) {
								sArrforT.add(sdatas.get(j));
							}
						}
						System.out.println("i: " + sArrforT);
						sArrforTeacher.put(i, sArrforT);
						sizeArr[i] = sArrforT.size();
					}
					mod.addObject("sArrforT", sArrforTeacher);
					mod.addObject("sizeArr", sizeArr);
				}
			}
			if(!imgarr[0].equals("noimage")) {
				mod.addObject("img", imgarr);
			}
		} else if(session.getAttribute("accountType").equals("S")) { //학생일 때
			S_HomeworkVO shwVO = new S_HomeworkVO();
			shwVO.setSho_tid(data.getTho_id()); 
			String writers = session.getAttribute("accountNumber").toString();
			shwVO.setSho_writer(Integer.parseInt(writers));
			System.out.println("student writer: " + shwVO.getSho_writer());
			List<S_HomeworkVO> sworks = service.selectStudentHWs(shwVO);
			if(sworks == null || sworks.size() == 0) {
				mod.addObject("sworksnull", true);
				System.out.println("학생 숙제값 없음");
			} else {
				mod.addObject("sworksnull", false);
				System.out.println("학생 숙제값 있음");
				if(data.getTho_homeworktype() != 3) {
					mod.addObject("sworks", sworks);
				}
				
				HashMap<Integer, String[]> studentImagesForS = new HashMap<Integer, String[]>();
				for(S_HomeworkVO simgForS: sworks) {
					String[] simgarrsForS = new String[1];
					if(simgForS.getSho_fileurl() != null) {
						simgarrsForS = service.getImgList(simgForS.getSho_fileurl());
						studentImagesForS.put(simgForS.getSho_id(), simgarrsForS);
					}
				}
				mod.addObject("studentImagesForS", studentImagesForS);
				
				if(data.getTho_homeworktype() == 2) {
					String[] ansarr = service.makeType2Answer(sworks.get(0));
					mod.addObject("sanswer", ansarr);
					//교사가 채점을 끝냈을때
					if(sworks.get(0).getSho_goodbad() != null) {
						String[] GBarr = sworks.get(0).getSho_goodbad().split("");
						mod.addObject("type2GBforStudent", GBarr);
					}
				} else if(data.getTho_homeworktype() == 3) {
					LocalDate[] type3DateArr = service.maketype3DayArr(data);
					durDate = type3DateArr.length;
					System.out.println("durDate: " + durDate);
					
					S_HomeworkVO[] type3sWorks = new S_HomeworkVO[durDate];
					String[] type3sWeather = new String[durDate];
					String[] type3sContent = new String[durDate];
					String[] type3sComment = new String[durDate];
					for(int i = 0; i < durDate; i++) {
						System.out.println("i: " + i);
						for(S_HomeworkVO stype3: sworks) {
							java.sql.Date newDate = Date.valueOf(type3DateArr[i]);
							System.out.println("LocalDate: " + type3DateArr[i] + " | SQLDate: " + newDate);
							if(stype3.getSho_date().equals(newDate)) {
								String[] temps3arr = stype3.getSho_contents().split("\\|\\|");
//								java.sql.Date temp3sdate = sworks.get(i).getSho_date();
								type3sWorks[i] = stype3;
								type3sWeather[i] = temps3arr[0];
								type3sContent[i] = temps3arr[1];
								type3sComment[i] = stype3.getSho_comment() != null ? "true" : "false";
								System.out.println("i: " + i + ", works: " + type3sWorks[i] + ", weather: " + type3sWeather[i] +",content: " + type3sContent[i] + ", comment: " + type3sComment[i] );
							}
						}
					}
					System.out.println("for문 종료");
					mod.addObject("type3sWorks", type3sWorks);
					mod.addObject("type3sWeather", type3sWeather);
					mod.addObject("type3sContent", type3sContent);
					mod.addObject("type3sComment", type3sComment);
				}
			}
		} else {
			System.out.println("HController, session값 읽기 에러");
		}
		
		mod.setViewName("homework/detail/detail");
		return mod;
		
	}
	
	@RequestMapping(value="/studentup", method=RequestMethod.POST)
	public String studentHomeworkUp(S_HomeworkVO vo) {
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form 업로드 성공");
			return "redirect:/homework/detail?tho_id=" + vo.getSho_tid();
		} else {
			System.out.println("homework form 업로드 실패");
			return "homework/error";
		}
	}
	
	@RequestMapping(value="/studentupdate1", method=RequestMethod.POST)
	public String studentHomeworkUpdate1(S_HomeworkVO vo) {
		System.out.println(vo);
		boolean res = service.updateSHContents(vo);
		if(res) {
			System.out.println("homework form 수정 성공");
			return "redirect:/homework/detail?tho_id=" + vo.getSho_tid();
		} else {
			System.out.println("homework form 수정 실패");
			return "homework/error";
		}
	}
	
	@RequestMapping(value="/studentup2", method=RequestMethod.POST)
	public String studentHomeworkUp2(S_HomeworkVO vo) {
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form 업로드 성공");
			return "redirect:/homework/detail?tho_id=" + vo.getSho_tid();
		} else {
			System.out.println("homework form 업로드 실패");
			return "homework/error";
		}
	}
	
	@RequestMapping(value="/studentupdate2", method=RequestMethod.POST)
	public String studentHomeworkUpdate2(S_HomeworkVO vo) {
		boolean res = service.updateSHContents(vo);
		if(res) {
			System.out.println("homework form 수정 성공");
			return "redirect:/homework/detail?tho_id=" + vo.getSho_tid();
		} else {
			System.out.println("homework form 수정 실패");
			return "homework/error";
		}
	}
	
	@RequestMapping(value="/studentup3", method=RequestMethod.POST)
	public String studentHomeworkUp3(S_HomeworkVO vo, @RequestParam("sho_fileurl") String sho_fileurl) {
		System.out.println("vo 안에 fileurl: " + vo.getSho_fileurl());
		System.out.println(vo);
		System.out.println("RequestParam fileurl: " + sho_fileurl);
		vo.setSho_fileurl(sho_fileurl);
		System.out.println(vo);
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form 업로드 성공");
			return "redirect:/homework/detail?tho_id=" + vo.getSho_tid();
		} else {
			System.out.println("homework form 업로드 실패");
			return "homework/error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/ajaxComment", method=RequestMethod.POST)
	public HashMap<String, String> ajaxComment(S_HomeworkVO vo) {
		System.out.println("ajaxComment: " + vo);
		HashMap<String, String> resultmap = new HashMap();
		if(vo.getSho_comment() == null) {
			boolean res = service.updateSHGood(vo);
			resultmap.put("result", res + "");
		} else {
			String[] resarr = service.updateSHGoodCom(vo);
			resultmap.put("GBresult", resarr[0]);
			resultmap.put("Comresult", resarr[1]);
		}
		resultmap.put("GoodBad", vo.getSho_goodbad() + "");
		return resultmap;
	}
	
	@RequestMapping(value="/homework/test", method=RequestMethod.GET)
	public String homeworktest(S_HomeworkVO vo) {
		return "homework/empty";
	}
	
	@RequestMapping(value="/homework/type3", method=RequestMethod.GET)
	public String homeworktest3(@RequestParam("date") java.sql.Date sho_date) {
		
		return "homework/detail/type3";
	}
	
	@RequestMapping(value="/deleteSH", method=RequestMethod.GET)
	public ModelAndView deleteSH(ModelAndView mod, @RequestParam("sho_id") int sho_id) {
		boolean res = false;
		
		//삭제할 vo객체 생성
		S_HomeworkVO vo = new S_HomeworkVO();
		vo.setSho_id(sho_id);
		
		//채점이 되어있는지 확인
		S_HomeworkVO data = service.selectOneSH(sho_id);
		if(data != null) {
			if(data.getSho_comment() == null && data.getSho_goodbad() == null) {
				res = service.deleteSH(vo);
			}
			
			if(res) {
				mod.setViewName("redirect:/homework");
			} else {
				mod.setViewName("homework/error");
			}
		} else {
			mod.setViewName("homework/error");
		}
		return mod;
	}
	
	@RequestMapping(value="/deleteHW", method=RequestMethod.GET)
	public ModelAndView deleteHW(ModelAndView mod, @RequestParam("tho_id") int tho_id) {
		boolean res = false;
		
		T_HomeworkVO vo = new T_HomeworkVO();
		vo.setTho_id(tho_id);
		
		List<S_HomeworkVO> datas = service.selectSHList(tho_id);
		if(datas.size() <= 0) {
			res = service.deleteHW(vo);
		}
		
		if(res) {
			mod.setViewName("redirect:/homework");
		} else {
			mod.setViewName("homework/error");
		}
		return mod;
	}
}