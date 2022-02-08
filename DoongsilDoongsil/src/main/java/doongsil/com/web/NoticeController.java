package doongsil.com.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import doongsil.com.web.notice.model.Criteria;
import doongsil.com.web.notice.model.NoticeService;
import doongsil.com.web.notice.model.NoticeVO;
import doongsil.com.web.notice.model.PageMaker;
import doongsil.com.web.reply.model.ReplyService;
import doongsil.com.web.reply.model.ReplyVO;


@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService service;
	
	@Autowired
	private ReplyService replyService;
	
	//지도 view
	@RequestMapping(value = "/notice/map", method = RequestMethod.GET)
	public void map() throws Exception{
		logger.info("map");
		
	}

	//공지사항 글 작성 페이지
	@RequestMapping(value = "/notice/noticeWrite", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("noticeView");
		
	}
	
	//공지사항 글 작성
	@RequestMapping(value = "/notice/noticeWrite", method = RequestMethod.POST)
	public String write(NoticeVO noticeVO, HttpSession session) throws Exception{
		logger.info("write");
				
		service.write(noticeVO);
		
		//session에서 grade랑 class 비교해서...학년/반에 따라서 보여지는게 다르게..
				
		return "redirect:/notice/noticeList?page="+ session.getAttribute("nowPage");
	}
	
	//공지사항 목록 조회
	@RequestMapping(value = "/notice/noticeList", method = RequestMethod.GET)
	public String list(@RequestParam("page") Integer page,Model model, Criteria cri, HttpSession session,HttpServletRequest request) throws Exception{
		logger.info("noticeList");
		String s = request.getParameter("not_permit");
		System.out.println("11111 => " + s);
		model.addAttribute("list", service.list(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		//현재페이지 저장
		session.setAttribute("nowPage",page);
		
		return "notice/noticeList";
		
	}
//	@RequestMapping(value = "/notice/noticeList", method = RequestMethod.POST)
//	public String listPost(@RequestParam("not_permit") String permit,Model model) throws Exception{
//		System.out.println("permit => " + permit);
//		
//		//NoticeVO permit2 = new NoticeVO(permit);
//		
////		if(permit.equals("S")|| permit.equals("P") || permit.equals("A")) {
////			
////		}
//		 
//		//List<NoticeVO> voList = service.permitlist(permit2);
//		//model.addAttribute("voList",voList);
//		
//		
//
//		
//		return "notice/noticeList";
//		
//	}
	
	//공지사항 상세페이지
		@RequestMapping(value = "/notice/noticeView", method = RequestMethod.GET)
		public String read(NoticeVO noticeVO, @RequestParam("not_id") Integer not_id, @ModelAttribute("cri") Criteria cri,Model model) throws Exception{
			logger.info("noticeView");
			
			model.addAttribute("read", service.read(noticeVO.getNot_id()));
			
			//댓글조회
			List<ReplyVO> replyList = replyService.readReply(noticeVO.getNot_id());
			model.addAttribute("replyList", replyList);
			
			service.updateReplyCount(not_id);

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
		public String update(NoticeVO noticeVO, HttpSession session) throws Exception{
			logger.info("update");
					
			service.update(noticeVO);
					
			return "redirect:/notice/noticeList?page="+ session.getAttribute("nowPage");
					
			}
		
		//공지사항 삭제 
		@RequestMapping(value = "/delete", method = RequestMethod.GET)
		public String delete(int not_id, HttpSession session) throws Exception{
			logger.info("delete");

			service.delete(not_id);
			
			return "redirect:/notice/noticeList?page=" + session.getAttribute("nowPage");				
		}
		
		//댓글 작성
		@RequestMapping(value = "/replyWrite", method = RequestMethod.POST)
		public String replyWrite(ReplyVO vo, RedirectAttributes rttr) throws Exception {
			logger.info("reply write");
			
			replyService.writeReply(vo);
				
			rttr.addAttribute("n_id", vo.getN_id());
			
			return "redirect:/notice/noticeView?not_id=" + vo.getN_id();
		}
		
		//댓글 수정 GET
		@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET)
		public String replyUpdateView(ReplyVO vo, Model model) throws Exception {
			logger.info("reply write");
						
			model.addAttribute("replyUpdate", replyService.selectReply(vo.getReply_id()));

			return "notice/replyUpdateView";
		}
		
		//댓글수정 POST
		@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
		public String replyUpdate(ReplyVO vo, RedirectAttributes rttr) throws Exception {
			logger.info("reply Write");
			
			replyService.updateReply(vo);
				
			rttr.addAttribute("n_id", vo.getN_id());
	
			return "redirect:/notice/noticeView?not_id=" + vo.getN_id();
		}
		
		//댓글 삭제 GET
		@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
		public String replyDeleteView(ReplyVO vo, Model model) throws Exception {
			logger.info("reply Delete");
				
			model.addAttribute("replyDelete", replyService.selectReply(vo.getReply_id()));
				
			return "notice/replyDeleteView";
		}
			
		//댓글 삭제 POST
		@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
		public String replyDelete(ReplyVO vo, RedirectAttributes rttr) throws Exception {
			logger.info("reply delete");
				
			replyService.deleteReply(vo);
				
			rttr.addAttribute("n_id", vo.getN_id());
		
				
			return "redirect:/notice/noticeView?not_id=" + vo.getN_id();
		}
}

