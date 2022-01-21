package doongsil.com.web.homework.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeworkService {
	
	@Autowired
	private HomeworkDAO dao;
	
	public List<T_HomeworkVO> selectHWList() {
		List<T_HomeworkVO> datas = dao.selectHWList();
		return datas;
	}

}
