package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.ProductDTO;
import dto.ReviewDTO;

public class ReviewService {
	String url = "jdbc:mysql://db1.c8obnk8nkf9s.ap-northeast-2.rds.amazonaws.com:3306/yomozomo";
	String user ="admin";
	String passWord = "yomozomo";

	public boolean getCheckProduct(int mnum , int id) {
		boolean check = false;
		try {
				String sql = "SELECT * FROM UserOrder_detail UO WHERE UO.O_NUM IN( "
						+ "    SELECT O_NUM FROM UserOrder WHERE M_NUM = ?) "
						+ " AND  P_NUM = ? ";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con =DriverManager.getConnection(url,user,passWord);
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,mnum);
			st.setInt(2, id);
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) {
				check = true;
			}
			rs.close();
			st.close();
			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		return check;
		
	}

	public int reviewInsert(int mnum,int reviewstar,String image,String contents,int pnum,String test) {
		int result = 0;
		try {
			String sql = "INSERT INTO REVIEW(M_NUM, OD_NUM, R_REGDATE, R_SCOPE, R_IMAGE, R_CONTENTS,P_NUM,test)"
					+ " VALUES(?,NULL,now(),?,?,?,?,? ) ";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con =DriverManager.getConnection(url,user,passWord);
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1,mnum);
		st.setInt(2, reviewstar);
		st.setString(3, image);
		st.setString(4, contents);
		st.setInt(5,pnum);
		st.setString(6, test);
		result = st.executeUpdate();

		st.close();
		con.close();
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
	
	return result;
	}
	public List<ReviewDTO> getReview(int id){
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		ReviewDTO p = null;
		try {
			String sql = "SELECT * FROM REVIEW WHERE P_NUM=? ";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con =DriverManager.getConnection(url,user,passWord);
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, id);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Date regdate = rs.getDate("R_REGDATE");
				int scope = rs.getInt("R_SCOPE");
				String image = rs.getString("test");
				String contents = rs.getString("R_CONTENTS");
				p = new ReviewDTO(regdate, scope, image, contents);
				list.add(p);
			}
			rs.close();
			st.close();
			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}