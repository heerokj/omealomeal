package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReservationVO;

public class ReservationDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();

	public ReservationDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}

	// 예약 추가
	public void insertReservation(ReservationVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO Reservation(USER_NUM, STORE_NUM, PEOPLE_NUM, REZ_DATE, TIME, MEMO, STATUS) ");
		sb.append("VALUES(?, ?, ?, ?, ?, ?, 1) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getUser_num());
			pstmt.setInt(2, vo.getStore_num());
			pstmt.setInt(3, vo.getPeople_num());
			pstmt.setString(4, vo.getRez_date());
			pstmt.setString(5, vo.getTime());
			pstmt.setString(6, vo.getMemo());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<ReservationVO> findRez(int userNum) {
		ArrayList<ReservationVO> list = new ArrayList<ReservationVO>();
		ReservationVO vo = null;

		sb.setLength(0);
		sb.append("SELECT * FROM Reservation WHERE USER_NUM = ? AND STATUS = 1 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, userNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int rezNum = rs.getInt("REZ_NUM");
				int storeNum = rs.getInt("STORE_NUM");
				int peopleNum = rs.getInt("PEOPLE_NUM");
				String rezDate = rs.getString("REZ_DATE");
				String time = rs.getString("TIME");
				String memo = rs.getString("MEMO");
				int status = rs.getInt("STATUS");

				vo = new ReservationVO(rezNum, userNum, storeNum, peopleNum, rezDate, time, memo, status);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	public ReservationVO selectOne(int rezNum) {
		sb.setLength(0);
		sb.append("SELECT * FROM Reservation WHERE REZ_NUM = ? ");

		ReservationVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, rezNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				int userNum = rs.getInt("USER_NUM");
				int peopleNum = rs.getInt("PEOPLE_NUM");
				String rezDate = rs.getString("REZ_DATE");
				String time = rs.getString("TIME");
				String memo = rs.getString("MEMO");
				int status = rs.getInt("STATUS");

				vo = new ReservationVO(rezNum, userNum, storeNum, peopleNum, rezDate, time, memo, status);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return vo;

	}
	
	public void updateRez(ReservationVO vo) {
		sb.setLength(0);
		sb.append("UPDATE Reservation SET ");
		sb.append("PEOPLE_NUM = ?, ");
		sb.append("REZ_DATE = ?, ");
		sb.append("TIME = ?, ");
		sb.append("MEMO = ?  WHERE REZ_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, vo.getPeople_num());
			pstmt.setString(2, vo.getRez_date());
			pstmt.setString(3, vo.getTime());
			pstmt.setString(4, vo.getMemo());
			pstmt.setInt(5, vo.getRez_num());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteRez(int rezNum) {
		sb.setLength(0);
		sb.append("UPDATE Reservation SET STATUS = 0 WHERE REZ_NUM = ? ");
		
		try {
			pstmt= conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rezNum);
			
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
			e.printStackTrace();
		}
	}
}