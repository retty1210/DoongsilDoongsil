package doongsil.com.web.search.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import doongsil.com.web.paging.model.PagingVo;

@Service
public class SearchService {
	
	@Autowired
	private SearchDAO searchDao;
	
	public List<SearchDTO> searchList(PagingVo vo){
		return this.searchDao.searchList(vo);
	}
	public int CountSearch(String id) {
		return this.searchDao.CountSearch(id);
	}
}
