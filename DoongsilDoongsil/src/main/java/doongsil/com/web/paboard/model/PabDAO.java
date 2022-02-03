package doongsil.com.web.paboard.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import doongsil.com.db.conn.MybatisConnect;


@Repository
public class PabDAO {
	
	@Autowired
	private SqlSession sess;
		
	public void insert(PabVO pabVO) throws Exception {
		sess.insert("PabMapper.insert", pabVO);		
	}
	
	public void update(PabVO pabVO) throws Exception{
		sess.update("PabMapper.update", pabVO);
	}
	
	
	public void delete(int pab_id) throws Exception{
		sess.delete("PabMapper.delete", pab_id);
	}
	

	public List<PabVO> list() throws Exception {
		return sess.selectList("PabMapper.list");
	}
	

	public PabVO view(int pab_id) throws Exception{
		return sess.selectOne("PabMapper.view", pab_id);
	}
	

}
	