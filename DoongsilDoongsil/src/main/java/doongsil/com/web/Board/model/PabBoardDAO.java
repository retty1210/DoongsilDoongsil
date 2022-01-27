package doongsil.com.web.Board.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import doongsil.com.db.conn.OracleConnect;


public class PabBoardDAO {
		OracleConnect oc = null;
		String query = "";
		ResultSet res = null;
		int rs = 0;
		
		public PabBoardDAO() {
			this.oc = new OracleConnect(true);
		}

		public boolean insert(PabBoardVO pvo) {
				this.query = "INSERT INTO PARENTS_BOARD VALUES("
					+ "PARENTS_BOARD_SEQ.NEXTVAL, "
					+ "'" + pvo.getPab_writer() + "', "
					+ "'" + pvo.getPab_title() + "', "
					+ "'" + pvo.getPab_contents() + "', "
					+ "'" + pvo.getPab_category() + "', "
					+ "'" + pvo.getPab_grade() + "', "
					+ "'" + pvo.getPab_class() + "', "
					+ "SYSDATE)";

		this.rs = oc.insert(query);
		return this.rs == 1 ? true : false;
		}

		public List<PabBoardVO> select(String pab_id){
			this.query = "SELECT * FROM PARENTS_BOARD WHERE PAB_ID = '" + pab_id + "'";	
			List<PabBoardVO> datas = new ArrayList<PabBoardVO>();
			this.res = oc.select(query);

			
			try {
			while(res.next()) {
				PabBoardVO pvo = new PabBoardVO();
				pvo.setPab_id(res.getInt("PAB_ID"));
				pvo.setPab_writer(res.getInt("PAB_WIRTER"));
				pvo.setPab_title(res.getString("PAB_TITLE"));
				pvo.setPab_contents(res.getString("PAB_CONTETNTS"));
				pvo.setPab_category(res.getString("PAB_CATEGORY"));
				pvo.setPab_grade(res.getString("PAB_GRADE"));
				pvo.setPab_class(res.getString("PAB_CLASS"));
				pvo.setPab_date(res.getString("PAB_DATE"));
					datas.add(pvo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return datas;
		}
		
		public boolean delete(PabBoardVO pvo) {
			this.query = "DELETE FROM PARENTS_BOARD"
					+ "WHERE PAB_ID = '" + pvo.getPab_id() + "'";
			
			this.rs = oc.delete(query);
			
			return this.rs == 1 ? true : false;
		}

		public List<PabBoardVO> selectAll(){
			this.query = "SELECT * FROM PARENTS_BOARD";
			List<PabBoardVO> datas = new ArrayList<PabBoardVO>();
			this.res = oc.select(query);
			
			try {
				while(res.next()) {
					PabBoardVO pvo = new PabBoardVO();
					pvo.setPab_id(res.getInt("PAB_ID"));
					pvo.setPab_writer(res.getInt("PAB_WIRTER"));
					pvo.setPab_title(res.getString("PAB_TITLE"));
					pvo.setPab_contents(res.getString("PAB_CONTETNTS"));
					pvo.setPab_category(res.getString("PAB_CATEGORY"));
					pvo.setPab_grade(res.getString("PAB_GRADE"));
					pvo.setPab_class(res.getString("PAB_CLASS"));
					pvo.setPab_date(res.getString("PAB_DATE"));
					datas.add(pvo);
				}
				res.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return datas;
		}
		
		public boolean update(PabBoardVO pvo) {
			this.query = "UPDATE PARENTS_BOARD SET PAB_TITLE = '" + pvo.getPab_title() + "', PAB_CONTENTS ='" + pvo.getPab_contents() + "', PAB_CATEGORY = '" + pvo.getPab_category() +"',"
					+"PAB_GRADE = '" + pvo.getPab_grade() + "' WHERE PAB_ID ='" + pvo.getPab_id() +"'";
			
			this.rs = oc.update(query);
			if(rs == 1) {
				return true;
			}else {
				return false;
			}
		}
		
	
		public void commit() {
			oc.commit();
		}
		
		public void rollback() {
			oc.rollback();
		}
		
		public void close() {
			oc.close();
		}
	}
