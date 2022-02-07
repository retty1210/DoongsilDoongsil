package doongsil.com.web.paboard;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import doongsil.com.web.paboard.model.PabService;
import doongsil.com.web.paboard.model.PabVO;

@Controller
@RequestMapping("/paboard/*")
public class pabController {
	
	private static final Logger logger = LoggerFactory.getLogger(pabController.class);
	
	@Autowired
	private PabService service;
	

	// 글쓰기페이지
	@RequestMapping(value = "/paboard/paboardWrite", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("paboardView");
		
	}
	
	// 글쓰기
	@RequestMapping(value = "/paboard/paboardWrite", method = RequestMethod.POST)
	public String write(PabVO pabVO) throws Exception{
		logger.info("insert" + pabVO);
			
		service.insert(pabVO);
		
		return "redirect:paboard/paboardList";
	}
	
	// 목록 조회
	@RequestMapping(value = "/paboardList", method = RequestMethod.GET)
	public String list(Model model) throws Exception{
		logger.info("paboardList");
		
		model.addAttribute("list", service.list());
		
		return "paboard/paboardList";
		
	}
	
	// 상세페이지
		@RequestMapping(value = "/paboard/paboardView", method = RequestMethod.GET)
		public String view(PabVO pabVO, Model model) throws Exception{
			logger.info("paboardView");
			
			model.addAttribute("view", service.view(pabVO.getPab_id()));
			
			return "paboard/paboardView";
			
		}

		// 수정페이지 GET
		@RequestMapping(value = "/pabupdate", method = RequestMethod.GET)
		public String updateView(PabVO pabVO, Model model) throws Exception{
			logger.info("pabupdate");
		
			model.addAttribute("update", service.view(pabVO.getPab_id()));
			
			return "paboard/pabupdate";
		}
		
		
		// 수정페이지 POST
		@RequestMapping(value = "/update", method = RequestMethod.POST)
		public String update(PabVO pabVO) throws Exception{
			logger.info("update");
					
			service.update(pabVO);
					
			return "redirect:/paboard/paboardList";
					
			}
		
		// 삭제 
		@RequestMapping(value = "/delete", method = RequestMethod.GET)
		public String delete(int pab_id) throws Exception{
			logger.info("delete");

			service.delete(pab_id);
			
			return "redirect:/paboard/paboardList";
					
		}
}