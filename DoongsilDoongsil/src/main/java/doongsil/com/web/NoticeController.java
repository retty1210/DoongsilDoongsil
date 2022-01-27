package doongsil.com.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;


@Controller
@RequestMapping("/notice/*")
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
		
		//session에서 grade랑 class 비교해서...학년/반에 따라서 보여지는게 다르게..
				
		return "redirect:/notice/noticeList";
	}
	
	//공지사항 목록 조회
	@RequestMapping(value = "/notice/noticeList", method = RequestMethod.GET)
	public String list(Model model) throws Exception{
		logger.info("noticeList");
		
		model.addAttribute("list", service.list());
		
		return "notice/noticeList";
		
	}
	
	//공지사항 상세페이지
		@RequestMapping(value = "/notice/noticeView", method = RequestMethod.GET)
		public String read(NoticeVO noticeVO, Model model) throws Exception{
			logger.info("noticeView");
			
			model.addAttribute("read", service.read(noticeVO.getNot_id()));
			
			return "notice/noticeView";
			
		}

		//공지사항 수정페이지 GET
		@RequestMapping(value = "/updateView", method = RequestMethod.GET)
		public String updateView(NoticeVO noticeVO, Model model) throws Exception{
			logger.info("updateView");
		
			model.addAttribute("update", service.read(noticeVO.getNot_id()));
			
			return "notice/updateView";
		}
		
		
		//공지사항 수정페이지 POST
		@RequestMapping(value = "/update", method = RequestMethod.POST)
		public String update(NoticeVO noticeVO) throws Exception{
			logger.info("update");
					
			service.update(noticeVO);
					
			return "redirect:/notice/noticeList";
					
			}
		
		//공지사항 삭제 
		@RequestMapping(value = "/delete", method = RequestMethod.GET)
		public String delete(int not_id) throws Exception{
			logger.info("delete");

			service.delete(not_id);
			
			return "redirect:/notice/noticeList";
					
		}
}
