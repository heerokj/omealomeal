package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.MemberVO;
import vo.OmealMemberVO;

public class OmealMemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	public OmealMemberDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	public String isExistsId(String id){
		sb.setLength(0);
		sb.append("select user_id from OmealMember ");
		sb.append("where user_id = ? ");
		boolean result= false;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return result?"true":"false";
	}
	public String isExistsNickname(String nickname){
		sb.setLength(0);
		sb.append("select nickname from OmealMember ");
		sb.append("where nickname = ? ");
		boolean result= false;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return result?"true":"false";
	}
	public String isExistsEmail(String email){
		sb.setLength(0);
		sb.append("select email from OmealMember ");
		sb.append("where email = ? ");
		boolean result= false;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return result?"true":"false";
	}
	public String findId(String name, String email) {
		sb.setLength(0);
		sb.append("select user_id from OmealMember " );
		sb.append("where user_name = ? and email = ? ");
		String id = "";
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return id;
	}
	public String findPw(String id, String question, String answer) {
		sb.setLength(0);
		sb.append("select user_pw from OmealMember ");
		sb.append("where user_id = ? and pw_q = ? and pw_a = ? ");
		String pw = "";
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, question);
			pstmt.setString(3, answer);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("user_pw");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pw;
	}
	public void insertOne(OmealMemberVO vo) {
		sb.setLength(0);
		sb.append("insert into OmealMember(user_id, user_pw, user_name, nickname, email, pw_q, pw_a, grade) ");
		sb.append("values(?, ?, ?, ?, ?, ?, ?, 0) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1,vo.getUser_id());
			pstmt.setString(2,vo.getUser_pw());
			pstmt.setString(3,vo.getUser_name());
			pstmt.setString(4,vo.getNickname());
			pstmt.setString(5,vo.getEmail());
			pstmt.setString(6,vo.getPw_q());
			pstmt.setString(7,vo.getPw_a());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteOne(int user_num) {
		sb.setLength(0);
		sb.append("DELETE FROM OmealMember WHERE USER_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, user_num);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	} // deleteOne 종료
	
	public void updatePw(OmealMemberVO vo) {
		sb.setLength(0);
		sb.append("UPDATE OmealMember SET user_pw = ?, user_image = ?, nickname = ? ");
		sb.append("WHERE user_num = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getUser_pw());
			pstmt.setString(2, vo.getUser_image());
			pstmt.setString(3, vo.getNickname());
			pstmt.setInt(4, vo.getUser_num());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public String isExistsPw(String user_pw){
		sb.setLength(0);
		sb.append("select user_pw from OmealMember ");
		sb.append("where user_pw = ? ");
		boolean result= false;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, user_pw);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return result?"true":"false";
	}
	
	public void close() {
			try {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
