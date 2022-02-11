package doongsil.com.web.search.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import doongsil.com.web.paging.model.PagingVo;


@Repository
public class SearchDAO {
	private static final Logger logger = LoggerFactory.getLogger(SearchDAO.class);
	
	@Autowired
	private SqlSession sess;
	
	public List<SearchDTO> searchList(PagingVo vo){
		logger.info("SearchDAO - " + vo);
		List<SearchDTO> datas = this.sess.selectList("SearchMapper.searchList",vo);
		return datas;
	}
	public int CountSearch(String id) {
		return this.sess.selectOne("SearchMapper.countSearch",id);
	}
}
