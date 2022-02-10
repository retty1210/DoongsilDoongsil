package doongsil.com.web.paboard;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import doongsil.com.web.paboard.model.PabService;
import doongsil.com.web.paboard.model.PabVO;
import doongsil.com.web.paging.model.PagingVo;

@Controller
//@RequestMapping("/paboard/*")
public class pabController {
	
	private static final Logger logger = LoggerFactory.getLogger(pabController.class);
	
	@Autowired
	private PabService service;
	

	// 글쓰기페이지
	@RequestMapping(value = "/paboardWrite", method = RequestMethod.GET)
	public String writeView(Model model) throws Exception{
		logger.info("paboardView");
		
		List<PabVO> category = this.service.pab_Category();
		
		if(category.size() != 0) {
			model.addAttribute("category", category);
		}
		return "paboard/paboardWrite";
	}
	
	// 글쓰기
	@RequestMapping(value = "/paboardWrite", method = RequestMethod.POST)
	public String write(PabVO pabVO,HttpServletRequest request) throws Exception{
		logger.info("insert" + pabVO);
		service.insert(pabVO);
		
		return "redirect:/paboardList";
	}
	
	// 목록 조회
	@RequestMapping(value = "/paboardList", method = RequestMethod.GET)
	public String list(Model model, PagingVo pagingVo,
						@RequestParam(value="nowPage", required=false)String nowPage,
						@RequestParam(value="cntPerPage",required=false)String cntPerPage) throws Exception{
		logger.info("paboardList");
		int total = this.service.countBoard();
		
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null){
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage = "5";
		}
		
		pagingVo = new PagingVo(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		
		model.addAttribute("paging",pagingVo);
		model.addAttribute("total",total);
		model.addAttribute("list",this.service.list(pagingVo));
	
		
		return "paboard/paboardList";
		
	}
	
	// 상세페이지
		@RequestMapping(value = "/paboardView", method = RequestMethod.GET)
		public String view(PabVO pabVO, Model model,HttpSession session) throws Exception{
			logger.info("paboardView");
			pabVO = service.view(pabVO.getPab_id());
			
			List<Integer> viewCountList;
			if(session.getAttribute("viewCount") == null) {
				viewCountList = new ArrayList<Integer>();
			} else {
				viewCountList = (List<Integer>) session.getAttribute("viewCount");
			}
			
			if(!viewCountList.contains(pabVO.getPab_id())) {
				this.service.countUpdate(pabVO);
				viewCountList.add(pabVO.getPab_id());
			}
			
			session.setAttribute("viewCount", viewCountList);
			
			model.addAttribute("view",pabVO);
			
			return "paboard/paboardView";
			
		}
		
		// 수정페이지 POST
		@RequestMapping(value = "/paboardUpdate", method = RequestMethod.POST)
		public String update(PabVO pabVO) throws Exception{
			logger.info("update");
			
			service.update(pabVO);
			return "redirect:/paboardView?pab_id="+pabVO.getPab_id();
					
			}
		
		// 삭제 
		@RequestMapping(value = "/paboardDelete", method = RequestMethod.GET)
		public String delete(int pab_id) throws Exception{
			logger.info("delete");

			service.delete(pab_id);
			
			return "redirect:/paboardList";
					
		}
}