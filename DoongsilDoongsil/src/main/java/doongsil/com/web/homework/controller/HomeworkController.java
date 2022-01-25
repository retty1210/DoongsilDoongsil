package doongsil.com.web.homework.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

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

import doongsil.com.web.homework.model.*;

@Controller
public class HomeworkController {

	@Autowired
	private HomeworkService service;
	
	@RequestMapping(value = "/homework", method = RequestMethod.GET)
	public String homeworklist(HttpServletRequest request, HttpSession session) {
		List<T_HomeworkVO> datas = service.selectHWList();
		if(datas.size() == 0) {
			return "homework/empty";
		} else {
			session.setAttribute("datas", datas);
		}
		
		
		return "homework/list";
	}
	
	@RequestMapping(value="homework/write", method = RequestMethod.GET)
	public String homeworkwrite() {
		return "homework/write";
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
	public String upHomeworkFile(MultipartFile[] uploadFile) {
		String uploadFolder = "C:\\Users\\retty\\git\\DoongsilDoongsil\\DoongsilDoongsil\\src\\main\\webapp\\resources\\upload";
		String tho_filelink = "";
		for(MultipartFile file: uploadFile) {
			if(!tho_filelink.isEmpty()) {
				tho_filelink += "_";
			}
			String originalFileName = file.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
			String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
			System.out.println("HomeworkController, filename: " + savedFileName);
			tho_filelink += savedFileName;
			
			File saveFile = new File(uploadFolder, savedFileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return tho_filelink;
	}
	
	@RequestMapping(value="/homework/detail", method=RequestMethod.GET)
	public String homeworkDetail(T_HomeworkVO vo, HttpServletRequest request) {
		T_HomeworkVO data = service.selectOneHW(vo);
		String[] imgarr = new String[1];
		if(data.getTho_filelink().isEmpty()) {
			imgarr[0] = "noimage";
		} else {
			imgarr = service.getImgList(data.getTho_filelink());
		}
		
		//만약 선생님일 경우
		List<S_HomeworkVO> sdatas = service.selectSHList(vo.getTho_id());
		if(sdatas != null) {
			request.setAttribute("sdatas", sdatas);
		}
		if(!imgarr[0].equals("noimage")) {
			request.setAttribute("img", imgarr);
		}
		if(data != null) {
			request.setAttribute("data", data);
			return "homework/detail";
		} 
		return "homework/error";
		
	}
	
	@RequestMapping(value="/studentup", method=RequestMethod.POST)
	public String studentHomeworkUp(S_HomeworkVO vo) {
		boolean res = service.insertSH(vo);
		if(res) {
			System.out.println("homework form 업로드 성공");
			return "redirect:/homework";
		} else {
			System.out.println("homework form 업로드 실패");
			return "homework/error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/ajaxComment", method=RequestMethod.POST)
	public String ajaxComment(S_HomeworkVO vo) {
		if(vo.getSho_comment().isEmpty()) {
			boolean res = service.updateSHGood(vo);
			String ret = "{ result: " + res + ", GoodBad: " + vo.getSho_goodbad() + "}";
			return ret;
		} else {
			String res = service.updateSHGoodCom(vo);
			String ret = "{ result: " + res + ", GoodBad: " + vo.getSho_goodbad() + "}";
			return ret;
		}
	}
	
	//S_HOMEWORK 선생님용 로직
	/*
	 * detail에 들어갈 때 id값을 받음
	 * 해당 id값을 sho_tid에 넣어서 list 받음
	 * 
	 */
}
