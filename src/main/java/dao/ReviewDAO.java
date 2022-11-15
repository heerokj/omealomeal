package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReviewVO;
import vo.StoreInfoVO;

public class ReviewDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();

	public ReviewDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}

	public void insertReview(ReviewVO vo) {
		sb.setLength(0);

		sb.append("INSERT INTO review(STORE_NUM, USER_NUM, REVIEW_DATE, POINT, REVIEW_COMMENT) ");
		sb.append("VALUES(?, ?, SYSDATE(), ?, ?) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getStoreNum());
			pstmt.setInt(2, vo.getUserNum());
			pstmt.setInt(3, vo.getPoint());
			pstmt.setString(4, vo.getReviewComment());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // maxNum 종료

	public int maxNum(int userNum) {

		int reviewNum = 0;

		sb.setLength(0);
		sb.append("SELECT MAX(REVIEW_NUM) AS NUM FROM review WHERE USER_NUM = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, userNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				reviewNum = rs.getInt("NUM");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return reviewNum;
	} // maxNum 종료

	public ArrayList<ReviewVO> selectAllReview(int storeNum) {

		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();

		sb.setLength(0);
		sb.append("SELECT * FROM review WHERE STORE_NUM = ? ORDER BY REVIEW_DATE DESC, REVIEW_NUM DESC ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int reviewNum = rs.getInt("REVIEW_NUM");
				int userNum = rs.getInt("USER_NUM");
				String reviewDate = rs.getString("REVIEW_DATE");
				int point = rs.getInt("POINT");
				String reviewComment = rs.getString("REVIEW_COMMENT");

				ReviewVO vo = new ReviewVO(reviewNum, storeNum, userNum, reviewDate, point, reviewComment);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	} // selectAllReview 종료

	public void deleteOne(int reviewNum) {
		sb.setLength(0);
		sb.append("DELETE FROM review WHERE REVIEW_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, reviewNum);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // deleteOne 종료

	public ReviewVO reviewOne(int reviewNum) {
		ReviewVO rvo = null;

		sb.setLength(0);
		sb.append("SELECT * FROM review WHERE REVIEW_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, reviewNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				int userNum = rs.getInt("USER_NUM");
				String date = rs.getString("REVIEW_DATE");
				int point = rs.getInt("POINT");
				String comment = rs.getString("REVIEW_COMMENT");

				rvo = new ReviewVO(reviewNum, storeNum, userNum, date, point, comment);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rvo;
	} // reviewOne 종료

	public void updateReview(ReviewVO vo) {

		sb.setLength(0);
		sb.append("UPDATE review SET REVIEW_DATE = SYSDATE(), POINT = ?, REVIEW_COMMENT = ? ");
		sb.append("WHERE REVIEW_NUM=?");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getPoint());
			pstmt.setString(2, vo.getReviewComment());
			pstmt.setInt(3, vo.getReviewNum());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public double averagePoint(int storeNum) {
		double average = 0;

		sb.setLength(0);
		sb.append("SELECT ROUND(AVG(POINT),1) AS AVG FROM review WHERE STORE_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, storeNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				average = rs.getDouble("AVG");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return average;
	}

	/* 리뷰수 */
	public int countReview(int storeNum) {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT COUNT(*) AS CNT FROM review WHERE STORE_NUM= ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("CNT");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return count;
	}
	
	public ArrayList<StoreInfoVO> recommend() {
		sb.setLength(0);
		sb.append("select pavg, store_num from( ");
		sb.append("select avg(point) pavg, store_num ");
		sb.append("from review group by store_num order by avg(point) desc) as A ");
		sb.append("where A.pavg >= 4 ");
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int storeNum = rs.getInt("store_num");
				StoreInfoVO vo = new StoreInfoVO(storeNum);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	public int totalRecommend() {
		int cnt = 0;
		sb.setLength(0);
		sb.append("select pavg, store_num from( ");
		sb.append("select avg(point) pavg, store_num ");
		sb.append("from review group by store_num order by avg(point) desc) as A ");
		sb.append("where A.pavg >= 4 ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cnt++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	/* 자원반납 */
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<ReviewVO> selectAllMemberReview(int user_num) {

		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();

		sb.setLength(0);
		sb.append("SELECT * FROM review WHERE user_num = ? ORDER BY REVIEW_DATE DESC, REVIEW_NUM DESC ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, user_num);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int reviewNum = rs.getInt("REVIEW_NUM");
				int store_num = rs.getInt("store_num");
				int userNum = rs.getInt("USER_NUM");
				String reviewDate = rs.getString("REVIEW_DATE");
				int point = rs.getInt("POINT");
				String reviewComment = rs.getString("REVIEW_COMMENT");

				ReviewVO vo = new ReviewVO(reviewNum, store_num, userNum, reviewDate, point, reviewComment);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	} // selectAllReview 종료
}
