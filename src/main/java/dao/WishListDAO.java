package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.WishListVO;

public class WishListDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();
	
	public WishListDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	public boolean isWish(int storeNum, int userNum) {
		
		boolean flag = false;
		
		sb.setLength(0);
		sb.append("SELECT * FROM wishlist WHERE USER_NUM = ? AND STORE_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, userNum);
			pstmt.setInt(2, storeNum);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public void insertWish(int storeNum, int userNum) {
		sb.setLength(0);
		sb.append("INSERT INTO wishlist(STORE_NUM, USER_NUM) VALUES (?, ?) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);
			pstmt.setInt(2, userNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteWish(int storeNum, int userNum) {
		sb.setLength(0);
		sb.append("DELETE FROM wishlist WHERE USER_NUM = ? AND STORE_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, storeNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
