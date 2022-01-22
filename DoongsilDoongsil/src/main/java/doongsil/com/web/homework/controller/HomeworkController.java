package doongsil.com.web.homework.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;

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
	
	@RequestMapping(value = "/file-upload", method = RequestMethod.POST)
	public String fileUpload(
			@RequestParam("article_file") List<MultipartFile> multipartFile
			, T_HomeworkVO vo, HttpServletRequest request) {
		
		String strResult = "{ \"result\":\"FAIL\" }";
		String contextRoot = "C:\\Users\\retty\\Documents\\up";
		//String contextRoot = request.getSession().getServletContext().getRealPath("/");
		String fileRoot;
		try {
			// 파일이 있을때 탄다.
			if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				
				for(MultipartFile file:multipartFile) {
					fileRoot = contextRoot;
					System.out.println(fileRoot);
					
					String originalFileName = file.getOriginalFilename();	//오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
					String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
					
					File targetFile = new File(fileRoot + savedFileName);	
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
						
					} catch (Exception e) {
						//파일삭제
						FileUtils.deleteQuietly(targetFile);	//저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
				//vo를 insert해주는 로직
				strResult = "{ \"result\":\"OK\" }";
			}
			// 파일 아무것도 첨부 안했을때 탄다.(게시판일때, 업로드 없이 글을 등록하는경우)
			else
				//vo insert로직
				strResult = "{ \"result\":\"OK\" }";
		}catch(Exception e){
			e.printStackTrace();
		}
		return strResult;
	}
}
