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
			mod.setViewName("redirect:/login");
		} else {
			STAccountVO loginUser = (STAccountVO) session.getAttribute("account");
			System.out.println(loginUser);
			T_HomeworkVO userdata = new T_HomeworkVO();
			int userClass = loginUser.getSta_class();
			int userGrade = loginUser.getSta_grade();
			userdata.setTho_class(userClass);
			userdata.setTho_grade(userGrade);
			System.out.println(userdata);
			
			int countList = 5; //??????????????? ????????? ??? ??????
			int pageListNum = 3; //???????????? ul ???????????? ????????? ?????? ????????? ???
			HashMap<Integer, List<T_HomeworkVO>> datas = service.makeTHClassPage(userdata, countList);
			//??????????????? ???????????? ?????? ?????? ?????????-????????? 1????????? ????????????(RequestParam pageNo)
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
			 * ?????? ??? 7?????????, ????????? 3???????????? ????????? ?????? 2?????????
			 * 7/2 = 3, ?????????1: ????????????????????? ?????? + 1, ?????????????????? ?????? - 1  2/3=0, ?????????2: ???+1?????? ?????????, ?????????????????? ??????????????? ??????
			 * 2?????? ???????????? ???????????????: 1*3 + 1 3??????: 2*3 + 1
			 * ?????? ??? 15?????????, ????????? 4????????????, ?????? 5?????????
			 * 15/5=3, ?????????0: 15/4=3, ?????????3:  5/4=1, ?????????1: ???+1?????? ?????????, ?????????????????? ?????????????????? ??????
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
	public ModelAndView homeworkwrite(ModelAndView mod) {
		List<THO_CategoryVO> datas = service.selectTHOCategory();
		mod.addObject("datas", datas);
		mod.setViewName("homework/write");
		return mod;
	}
	
	@RequestMapping(value="/homework/write/up", method = RequestMethod.POST)
	public ModelAndView upHomework(T_HomeworkVO vo, ModelAndView mod) {
		boolean res = service.insertHW(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
			
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework");
		return mod;
	}
	
	@ResponseBody
	@RequestMapping(value="/homework/write/up/file")
	public String upHomeworkFile(MultipartFile[] uploadFile, HttpServletRequest request) {
		String r = request.getServletContext().getRealPath("/resources/upload/");
		//String uploadFolder = "C:\\Users\\retty\\git\\DoongsilDoongsil\\DoongsilDoongsil\\src\\main\\webapp\\resources\\upload";
		String tho_filelink = "";
		for(MultipartFile file: uploadFile) {
			if(!tho_filelink.isEmpty()) {
				tho_filelink += "_";
			}
			//????????? ?????????
			String originalFileName = file.getOriginalFilename();	//???????????? ?????????
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//?????? ?????????
			
			String rand = UUID.randomUUID() + "";//????????? ?????????
			String randomstr = rand.substring(rand.lastIndexOf("-") + 1);
			
			SimpleDateFormat sdf = new SimpleDateFormat("YYMMDDHHmm"); //?????????????????? ??????
			java.util.Date date = new java.util.Date();
			String datetostr = sdf.format(date);
			
			String savedFileName = datetostr + randomstr + extension;	//????????? ?????????
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
	public ModelAndView homeworkDetail(T_HomeworkVO vo, HttpServletRequest request, HttpSession session, ModelAndView mod) {
		T_HomeworkVO data = service.selectOneHW(vo);
		
		//?????????
		if(session.getAttribute("count"+data.getTho_id()) == null) {
			int count = data.getTho_count() + 1;
			data.setTho_count(count);
			boolean countres = service.updateTHCount(data);
			if(!countres) {
				mod.addObject("error", true);
				mod.addObject("error_msg", "????????? ?????? ???????????? ????????? ??????????????????.");
				mod.setViewName("redirect:/homework");
				return mod;
			} else {
				session.setAttribute("count"+data.getTho_id(), true);
			}
			System.out.println("count??????: " + data.getTho_count());
		}
		
		
		//????????? ??????
		STAccountVO writerData = staService.studentUpdate(data.getTho_writer());
		mod.addObject("writerName", writerData.getSta_name());
		
		//?????????
		String[] imgarr = new String[1];
		if(data.getTho_filelink()== null) {
			imgarr[0] = "noimage";
		} else {
			imgarr = service.getImgList(data.getTho_filelink());
		}
		if(!imgarr[0].equals("noimage")) {
			mod.addObject("img", imgarr);
		}
		
		int durDate = 0;
		
		//type??? ??????
		if(data.getTho_homeworktype() == 2) {
			System.out.println(data.getTho_contents());
			HashMap<Integer, String[]> type2contents = service.makeType2Visible(data.getTho_contents());
			System.out.println(type2contents);
			mod.addObject("type2contents", type2contents);
		} else if(data.getTho_homeworktype() == 3) {
			LocalDate[] type3DayArr = service.maketype3DayArr(data);
			mod.addObject("type3DayArr", type3DayArr);
		}
		
		//??? ??? ??????
		if(data != null) {
			mod.addObject("data", data);
			System.out.println("data: " + data);
		} 
		
		if(session.getAttribute("accountType").equals("T")) { //???????????? ???
			List<S_HomeworkVO> sdatas = service.selectSHList(data.getTho_id());
			System.out.println("teacher, sdatas size: " + sdatas.size());
			if(sdatas != null) {
				mod.addObject("sdatas", sdatas);
				HashMap<Integer, String[]> studentImages = new HashMap<Integer, String[]>();
				List<Integer> idForNameArr = new ArrayList<Integer>();
				for(S_HomeworkVO simg: sdatas) {
					idForNameArr.add(simg.getSho_writer());
					
					String[] simgarrs = new String[1];
					if(simg.getSho_fileurl() != null) {
						System.out.println("simg input: " + simg.getSho_id());
						simgarrs = service.getImgList(simg.getSho_fileurl());
						studentImages.put(simg.getSho_id(), simgarrs);
					}
				}
				if(data.getTho_homeworktype() != 3) {
					List<STAccountVO> studentNameArr = service.selectNameWithID(idForNameArr);
					mod.addObject("studentNameArr", studentNameArr);
					mod.addObject("studentImages", studentImages);
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
					
					mod.addObject("type2answers", type2answers);
					mod.addObject("type2GBforTeacher", type2teacGBs);
				} else if(data.getTho_homeworktype() == 3) {
					LocalDate[] type3DayArr = service.maketype3DayArr(data);
					int[] sizeArr = new int[type3DayArr.length];
					HashMap<Integer, List<S_HomeworkVO>> sArrforTeacher = new HashMap<Integer, List<S_HomeworkVO>>();
					HashMap<Integer, List<STAccountVO>> nameArr = new HashMap<Integer, List<STAccountVO>>();
					HashMap<Integer, List<String>> weatherArr = new HashMap<Integer, List<String>>();
					HashMap<Integer, List<String>> contentArr = new HashMap<Integer, List<String>>();
					
					for(int i = 0; i < type3DayArr.length; i++) { //???????????? ???????????? for???
						List<Integer> idArr = new ArrayList<Integer>();
						java.sql.Date newDate = Date.valueOf(type3DayArr[i]);
						List<S_HomeworkVO> sArrforT = new ArrayList<S_HomeworkVO>();
						List<String> tempWeather = new ArrayList<String>();
						List<String> tempContent = new ArrayList<String>();
						System.out.println("newDate: " + newDate + ", Arr: " + type3DayArr[i]);
						System.out.println("sdatas.size: " + sdatas.size());
						
						for(int j = 0; j < sdatas.size(); j++) { //sdata?????? ???????????? for???
							System.out.println("inner for??? ?????? : " + sdatas.get(j).getSho_date());
							if(sdatas.get(j).getSho_date().equals(newDate)) {
								String[] tempwcArr = sdatas.get(j).getSho_contents().split("\\|\\|");
								sArrforT.add(sdatas.get(j));
								tempWeather.add(tempwcArr[0]);
								tempContent.add(tempwcArr[1]);
								if(!idArr.contains(sdatas.get(j).getSho_writer())) {
									idArr.add(sdatas.get(j).getSho_writer());
								}
							}
						}
						
						System.out.println("i: " + sArrforT);
						System.out.println("idArr: " + idArr);
						sArrforTeacher.put(i, sArrforT);
						sizeArr[i] = sArrforT.size();
						List<STAccountVO> nameInnerArr = new ArrayList<STAccountVO>();
						if(idArr.size() > 0) {
							List<STAccountVO> nametemparr = service.selectNameWithID(idArr);
							for(int k = 0; k < idArr.size(); k++) {
								for(int l = 0; l < nametemparr.size(); l++) {
									if(idArr.get(k) == nametemparr.get(l).getSta_id()) {
										nameInnerArr.add(nametemparr.get(l));
									}
								}
							}
						}
						nameArr.put(i, nameInnerArr);
						weatherArr.put(i, tempWeather);
						contentArr.put(i, tempContent);
					}
					mod.addObject("sArrforT", sArrforTeacher);
					mod.addObject("sizeArr", sizeArr);
					mod.addObject("nameArr", nameArr);
					mod.addObject("weatherArr", weatherArr);
					mod.addObject("contentArr", contentArr);
					
				}
			}
		} else if(session.getAttribute("accountType").equals("S")) { //????????? ???
			S_HomeworkVO shwVO = new S_HomeworkVO();
			shwVO.setSho_tid(data.getTho_id()); 
			String writers = session.getAttribute("accountNumber").toString();
			shwVO.setSho_writer(Integer.parseInt(writers));
			System.out.println("student writer: " + shwVO.getSho_writer());
			List<S_HomeworkVO> sworks = service.selectStudentHWs(shwVO);
			if(sworks == null || sworks.size() == 0) {
				mod.addObject("sworksnull", true);
				System.out.println("?????? ????????? ??????");
			} else {
				mod.addObject("sworksnull", false);
				System.out.println("?????? ????????? ??????");
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
					//????????? ????????? ????????????
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
								type3sComment[i] = stype3.getSho_comment() != null ? stype3.getSho_comment() : "";
								System.out.println("i: " + i + ", works: " + type3sWorks[i] + ", weather: " + type3sWeather[i] +",content: " + type3sContent[i] + ", comment: " + type3sComment[i] );
							}
						}
					}
					System.out.println("for??? ??????");
					mod.addObject("type3sWorks", type3sWorks);
					mod.addObject("type3sWeather", type3sWeather);
					mod.addObject("type3sContent", type3sContent);
					mod.addObject("type3sComment", type3sComment);
				}
			}
		} else {
			System.out.println("HController, session??? ?????? ??????");
		}
		
		mod.setViewName("homework/detail/detail");
		return mod;
		
	}
	
	@RequestMapping(value="/studentup", method=RequestMethod.POST)
	public ModelAndView studentHomeworkUp(S_HomeworkVO vo, ModelAndView mod) {
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework/detail?tho_id=" + vo.getSho_tid());
		return mod;
	}
	
	@RequestMapping(value="/studentupdate1", method=RequestMethod.POST)
	public ModelAndView studentHomeworkUpdate1(S_HomeworkVO vo, ModelAndView mod) {
		System.out.println(vo);
		boolean res = service.updateSHContents(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework/detail?tho_id=" + vo.getSho_tid());
		return mod;
	}
	
	@RequestMapping(value="/studentup2", method=RequestMethod.POST)
	public ModelAndView studentHomeworkUp2(S_HomeworkVO vo, ModelAndView mod) {
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework/detail?tho_id=" + vo.getSho_tid());
		return mod;
	}
	
	@RequestMapping(value="/studentupdate2", method=RequestMethod.POST)
	public ModelAndView studentHomeworkUpdate2(S_HomeworkVO vo, ModelAndView mod) {
		boolean res = service.updateSHContents(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework/detail?tho_id=" + vo.getSho_tid());
		return mod;
	}
	
	@RequestMapping(value="/studentup3", method=RequestMethod.POST)
	public ModelAndView studentHomeworkUp3(S_HomeworkVO vo, MultipartFile uploadFile, HttpServletRequest request, ModelAndView mod) {
		System.out.println("studentup3" + vo);
		String r = request.getServletContext().getRealPath("/resources/upload/");
		
		//????????? ?????????
		String originalFileName = uploadFile.getOriginalFilename();	//???????????? ?????????
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//?????? ?????????
		
		String rand = UUID.randomUUID() + "";//????????? ?????????
		String randomstr = rand.substring(rand.lastIndexOf("-") + 1);
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYMMDDHHmm"); //?????????????????? ??????
		java.util.Date date = new java.util.Date();
		String datetostr = sdf.format(date);
		
		String savedFileName = datetostr + randomstr + extension;	//????????? ?????????
		System.out.println("HomeworkController, filename: " + savedFileName);
		
		File saveFile = new File(r, savedFileName); //uploadFolder
		
		try {
			uploadFile.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vo.setSho_fileurl(savedFileName);
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form ????????? ??????");
		} else {
			System.out.println("homework form ????????? ??????");
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ?????????????????????.");
		}
		mod.setViewName("redirect:/homework/detail?tho_id=" + vo.getSho_tid());
		return mod;
	}
	
	@ResponseBody
	@RequestMapping(value="/ajaxComment", method=RequestMethod.POST)
	public HashMap<String, String> ajaxComment(S_HomeworkVO vo) {
		System.out.println("ajaxComment: " + vo);
		HashMap<String, String> resultmap = new HashMap<String, String>();
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
	
	@ResponseBody
	@RequestMapping(value="/type3comment", method=RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String type3comment(S_HomeworkVO vo) {
		boolean res = service.updateSHComment(vo);
		String result = "";
		if(res) {
			result = "????????? ?????????????????????.";
		} else {
			result = "????????? ?????????????????????.";
		}
		return result;
	}
	
	@RequestMapping(value="/homework/test", method=RequestMethod.GET)
	public String homeworktest(S_HomeworkVO vo) {
		return "homework/empty";
	}
	
	@RequestMapping(value="/deleteSH", method=RequestMethod.GET)
	public ModelAndView deleteSH(ModelAndView mod, @RequestParam("sho_id") int sho_id) {
		boolean res = false;
		
		//????????? vo?????? ??????
		S_HomeworkVO vo = new S_HomeworkVO();
		vo.setSho_id(sho_id);
		
		//????????? ??????????????? ??????
		S_HomeworkVO data = service.selectOneSH(sho_id);
		if(data != null) {
			if(data.getSho_comment() == null && data.getSho_goodbad() == null) {
				res = service.deleteSH(vo);
			}
			
			if(!res) {
				mod.addObject("error", true);
				mod.addObject("error_msg", "?????? ???????????? ????????? ??????????????????.");
			}
		} else {
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ????????? ???????????? ????????? ??? ??? ????????????.");
		}
		mod.setViewName("redirect:/homework");
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
		
		if(!res) {
			mod.addObject("error", true);
			mod.addObject("error_msg", "?????? ???????????? ????????? ??????????????????.");
		} 
		mod.setViewName("redirect:/homework");
		return mod;
	}
}