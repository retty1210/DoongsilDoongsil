package doongsil.com.web.search.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import doongsil.com.web.search.model.SearchDTO;
import doongsil.com.web.search.model.SearchService;

@Controller
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	private SearchService searchSer;
	
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String SearchList(@RequestParam("search")String searchText,HttpServletRequest request,Model model,SearchDTO dto) {
		String searchTitle = searchText;
		logger.info(searchTitle);
		
		List<SearchDTO> search = this.searchSer.searchList(searchTitle);
		if(search.size() != 0) {
			model.addAttribute("searchList",search);
		}else {
			model.addAttribute("searchError","해당하는 검색 결과가 없습니다.");
		}
		return "search/search";
	}
}
