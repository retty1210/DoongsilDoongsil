package doongsil.com.web.search.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import doongsil.com.web.paging.model.PagingVo;
import doongsil.com.web.search.model.SearchDTO;
import doongsil.com.web.search.model.SearchService;

@Controller
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	private SearchService searchSer;
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String SearchList(@RequestParam("search")String searchText,
			HttpServletRequest request,Model model,SearchDTO dto,
			PagingVo pagingVo,
				@RequestParam(value="nowPage", required=false)String nowPage,
				@RequestParam(value="cntPerPage",required=false)String cntPerPage) {
		List<String> textArr = new ArrayList<String>();
		textArr.add(searchText);
		
		String text = textArr.get(0);
		int total = this.searchSer.CountSearch(text);
		
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null){
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage = "5";
		}
		
		logger.info(" search List = > " + total + " " + nowPage,cntPerPage );
		
		pagingVo = new PagingVo(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage),text);
		
		List<SearchDTO> search = this.searchSer.searchList(pagingVo);
		if(search.size() != 0) {
			model.addAttribute("searchList",search);
			model.addAttribute("paging",pagingVo);
			model.addAttribute("total",total);
		}else {
			model.addAttribute("searchError","해당하는 검색 결과가 없습니다.");
		}
		for(SearchDTO s: search) {
			System.out.println(s);
		}
		return "search/search";
	}
}
