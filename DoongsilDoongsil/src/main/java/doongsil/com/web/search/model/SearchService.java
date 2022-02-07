package doongsil.com.web.search.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchService {
	
	@Autowired
	private SearchDAO searchDao;
	
	public List<SearchDTO> searchList(String searchTitle){
		return this.searchDao.searchList(searchTitle);
	}
}
