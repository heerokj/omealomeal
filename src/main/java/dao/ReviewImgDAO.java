package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReviewImgVO;

public class ReviewImgDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();

	public ReviewImgDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	public void insertReviewImg(ReviewImgVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO review_img(REVIEW_NUM, REVIEW_IMG) VALUES(?, ?) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getRevieNum());
			pstmt.setString(2, vo.getReviewImg());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // reviewimg insert 종료
	
	public ArrayList<ReviewImgVO> selectAll(int reviewNum){
		
		ArrayList<ReviewImgVO> rlist = new ArrayList<ReviewImgVO>();
		
		sb.setLength(0);
		sb.append("SELECT * FROM review_img WHERE REVIEW_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, reviewNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int imgNum = rs.getInt("IMG_NUM");
				String reviewImg = rs.getString("REVIEW_IMG");
				
				ReviewImgVO vo = new ReviewImgVO(imgNum, reviewNum, reviewImg);
				
				rlist.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rlist;
	} // reviewimg select 종료
	
	public void updateImg(ReviewImgVO vo) {
		sb.setLength(0);
		sb.append("UPDATE review_img SET REVIEW_IMG = ? WHERE IMG_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getReviewImg());
			pstmt.setInt(2, vo.getImgNum());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// update 종료
	
	public void deleteImg(int imgNum) {
		sb.setLength(0);
		sb.append("DELETE FROM review_img WHERE IMG_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, imgNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // delete 종료
	
	public ArrayList<ReviewImgVO> selectStore(int storeNum){
		ArrayList<ReviewImgVO> list = new ArrayList<ReviewImgVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM review_img WHERE REVIEW_NUM IN ( ");
		sb.append("		SELECT REVIEW_NUM FROM review WHERE STORE_NUM = ?) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int imgNum = rs.getInt("IMG_NUM");
				int reviewNum = rs.getInt("REVIEW_NUM");
				String reviewImg = rs.getString("REVIEW_IMG");
				
				ReviewImgVO vo = new ReviewImgVO(imgNum, reviewNum, reviewImg);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
