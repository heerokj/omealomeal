package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.MemberVO;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();

	public MemberDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}

	public MemberVO isExists(String id, String pw) {

		MemberVO vo = null;

		sb.setLength(0);
		sb.append("SELECT * FROM OmealMember WHERE USER_ID = ? AND USER_PW = ? AND GRADE = 0 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int userNum = rs.getInt("USER_NUM");
				String userName = rs.getString("USER_NAME");
				String nickName = rs.getString("NICKNAME");
				String email = rs.getString("EMAIL");
				String pwQ = rs.getString("PW_Q");
				String pwA = rs.getString("PW_A");
				String userImage = rs.getString("USER_IMAGE");
				int grade = rs.getInt("GRADE");

				vo = new MemberVO(userNum, id, pw, userName, nickName, email, pwQ, pwA, userImage, grade);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	public MemberVO isExistsAdmin(String id, String pw) {

		MemberVO vo = null;

		sb.setLength(0);
		sb.append("SELECT * FROM OmealMember WHERE USER_ID = ? AND USER_PW = ? AND GRADE = 1 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int userNum = rs.getInt("USER_NUM");
				String userName = rs.getString("USER_NAME");
				String nickName = rs.getString("NICKNAME");
				String email = rs.getString("EMAIL");
				String pwQ = rs.getString("PW_Q");
				String pwA = rs.getString("PW_A");
				String userImage = rs.getString("USER_IMAGE");
				int grade = rs.getInt("GRADE");

				vo = new MemberVO(userNum, id, pw, userName, nickName, email, pwQ, pwA, userImage, grade);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return vo;
	}

	public MemberVO isExistsNum(int userNum) {

		MemberVO vo = null;

		sb.setLength(0);
		sb.append("SELECT * FROM OmealMember WHERE USER_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, userNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				String userId = rs.getString("USER_ID");
				String userPw = rs.getString("USER_PW");
				String userName = rs.getString("USER_NAME");
				String nickName = rs.getString("NICKNAME");
				String email = rs.getString("EMAIL");
				String pwQ = rs.getString("PW_Q");
				String pwA = rs.getString("PW_A");
				String userImage = rs.getString("USER_IMAGE");
				int grade = rs.getInt("GRADE");

				vo = new MemberVO(userNum, userId, userPw, userName, nickName, email, pwQ, pwA, userImage, grade);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	public String findNickname(int userNum) {

		sb.setLength(0);
		sb.append("SELECT NICKNAME FROM OmealMember WHERE USER_NUM= ? ");

		String nickName = "";

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, userNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nickName = rs.getString("NICKNAME");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return nickName;
	}
	
	public void updateUserImage(MemberVO vo) {
		sb.setLength(0);
		sb.append("UPDATE OmealMember SET USER_IMG = ? ");
		sb.append("WHERE USER_ID = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, vo.getUserImage());
			pstmt.setString(2, vo.getUserId());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
