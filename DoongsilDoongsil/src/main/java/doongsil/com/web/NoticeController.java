package doongsil.com.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;


@Controller
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService service;

	//공지사항 글 작성 페이지
	@RequestMapping(value = "/notice/noticeWrite", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("noticeView");
		
	}
	
	//공지사항 글 작성
	@RequestMapping(value = "/notice/noticeWrite", method = RequestMethod.POST)
	public String write(NoticeVO noticeVO) throws Exception{
		logger.info("write");
				
		service.write(noticeVO);
				
		return "notice/noticeList";
	}

}
