package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import vo.StoreInfoVO;
import vo.WishListVO;

public class StoreInfoDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	StringBuffer sb = new StringBuffer();

	public StoreInfoDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	

	public StoreInfoVO selectOne(int storeNum) {

		StoreInfoVO vo = null;
		
		sb.setLength(0);

		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME, ");
		sb.append("STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ FROM StoreInfo ");
		sb.append("WHERE STORE_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");

				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return vo;
	} // selectOne 종료

	public ArrayList<StoreInfoVO> recommend(int num, String simpleAddrs) {

		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		ArrayList<StoreInfoVO> flist = new ArrayList<StoreInfoVO>();

		sb.setLength(0);
		sb.append("SELECT * FROM StoreInfo WHERE SIMPLE_ADDRS = ? AND STORE_NUM != ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, simpleAddrs);
			pstmt.setInt(2, num);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");

				StoreInfoVO vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category,
						opentime, closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (list.size() > 3) {
			int a[] = new int[list.size()];
			Random rnd = new Random();

			for (int i = 0; i < 3; i++) {
				a[i] = rnd.nextInt(list.size());
				for (int j = 0; j < i; j++) {
					if (a[i] == a[j])
						i--;
				}
			}

			for (int x = 0; x < 3; x++) {
				flist.add(list.get(a[x]));
			}
		} else {
			for (int x = 0; x < list.size(); x++) {
				flist.add(list.get(x));
			}
		}
		return flist;
	}// recommend종료

	public void updateStore(StoreInfoVO vo) {
		sb.setLength(0);

		sb.append("UPDATE StoreInfo SET ");
		sb.append(" STORE_NAME = ? ");
		sb.append(", ADDRS = ? ");
		sb.append(", DISTRICT = ? ");
		sb.append(", SIMPLE_ADDRS = ? ");
		sb.append(", TEL = ? ");
		sb.append(", CATEGORY = ? ");
		sb.append(", OPENTIME = ? ");
		sb.append(", CLOSETIME = ? ");
		sb.append(", STORE_IMAGE = ? ");
		sb.append(", STORE_MENU = ? ");
		sb.append(", ACCEPT_REZ = ?  ");
		sb.append("WHERE STORE_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, vo.getStoreName());
			pstmt.setString(2, vo.getAddrs());
			pstmt.setString(3, vo.getDistrict());
			pstmt.setString(4, vo.getSimpleAddrs());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getCategory());
			pstmt.setString(7, vo.getOpentime());
			pstmt.setString(8, vo.getClosetime());
			pstmt.setString(9, vo.getStoreImage());
			pstmt.setString(10, vo.getStoreMenu());
			pstmt.setInt(11, vo.getAcceptRez());
			pstmt.setInt(12, vo.getStoreNum());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// update 종료

	public void deleteOne(int storeNum) {
		sb.setLength(0);
		sb.append("DELETE FROM StoreInfo WHERE STORE_NUM = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // delete 종료

	public void insertOne(StoreInfoVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO StoreInfo(STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, ");
		sb.append("OPENTIME, CLOSETIME, STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ) ");
		sb.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ? ) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getStoreName());
			pstmt.setString(2, vo.getAddrs());
			pstmt.setString(3, vo.getDistrict());
			pstmt.setString(4, vo.getSimpleAddrs());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getCategory());
			pstmt.setString(7, vo.getOpentime());
			pstmt.setString(8, vo.getClosetime());
			pstmt.setString(9, vo.getStoreImage());
			pstmt.setString(10, vo.getStoreMenu());
			pstmt.setInt(11, vo.getAcceptRez());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<StoreInfoVO> selectAll() {
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		sb.setLength(0);
		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME, ");
		sb.append("STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ FROM StoreInfo ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");

				StoreInfoVO vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category,
						opentime, closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	
	/* 가게정보추가 */
	public void insertInfo(String storeName, String addrs, String tel, String category, String opentime,
			String closetime, String storeImage) {
		sb.setLength(0);
		sb.append(
				"INSERT INTO StoreInfo (STORE_NAME, ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME, STORE_IMAGE) VALUES(?, ?, ?, ?, ?, ?, ? )");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, storeName);
			pstmt.setString(2, addrs);
			pstmt.setString(3, tel);
			pstmt.setString(4, category);
			pstmt.setString(5, opentime);
			pstmt.setString(6, closetime);
			pstmt.setString(7, storeImage);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	/* < 총게시물건 조회 > */
	public int getTotalCount() {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) CNT FROM StoreInfo");
		
		int count = 0;
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			rs.next();
			count = rs.getInt("CNT");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	
	/* 검색창에 가게명조회 */
	public ArrayList<StoreInfoVO> select(String search, String order, int startNo) {

		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		StoreInfoVO vo = null;

		sb.setLength(0);
		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME ");
		sb.append(", STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ, COUNT(REVIEW_NUM) AS REVIEW, IFNULL(ROUND(AVG(POINT),1),0) AS AVGSTAR ");
		sb.append(" FROM StoreInfo s LEFT OUTER JOIN review r USING(STORE_NUM) ");
		
		sb.append("WHERE STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ");
		sb.append("GROUP BY STORE_NUM ");
		
		//sb.append("LIMIT 12 OFFSET ? ");
		
		if (order.equals("AVGSTAR")) {
			sb.append("ORDER BY AVGSTAR DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("HITS")) {
			sb.append("ORDER BY HITS DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("REVIEW")) {
			sb.append("ORDER BY REVIEW DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");

			//*		
			if(order.equals("AVGSTAR")) {
				pstmt.setInt(4, startNo);
			}else if(order.equals("HITS")) {
				pstmt.setInt(4, startNo);
			}else if(order.equals("REVIEW")) {
				pstmt.setInt(4, startNo);
			}
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");
				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	
	/* 검색창에 가게명조회 */
	public int totalSelect(String search, String order) {
		int total = 0;
		sb.setLength(0);
		sb.append("SELECT COUNT(*) ");
		sb.append(" FROM StoreInfo ");
		
		sb.append("WHERE STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ");
		

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				total = rs.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return total;
	}

	
	/* 검색어 + 지역 필터 적용 */
	public ArrayList<StoreInfoVO> searchDistrict(String search, ArrayList<String> local, String order, int startNo){
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		StoreInfoVO vo = null;

		sb.setLength(0);
		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME ");
		sb.append(", STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ, COUNT(REVIEW_NUM) AS REVIEW, IFNULL(ROUND(AVG(POINT),1),0) AS AVGSTAR ");
		sb.append(" FROM StoreInfo s LEFT OUTER JOIN review r USING(STORE_NUM) ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		sb.append("DISTRICT IN ( ");
		for(int i=0; i<local.size(); i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		sb.append("GROUP BY STORE_NUM ");
		
		//sb.append("LIMIT 12 OFFSET ? ");
		
		if (order.equals("AVGSTAR")) {
			sb.append("ORDER BY AVGSTAR DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("HITS")) {
			sb.append("ORDER BY HITS DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("REVIEW")) {
			sb.append("ORDER BY REVIEW DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}
		
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			for(int i=0; i<local.size(); i++) {
				pstmt.setString(i+4, local.get(i));
			}
			
			//pstmt.setInt(local.size()+4, startNo);
			
			if(order.equals("AVGSTAR")) {
				pstmt.setInt(local.size()+4, startNo);
			}else if(order.equals("HITS")) {
				pstmt.setInt(local.size()+4, startNo);
			}else if(order.equals("REVIEW")) {
				pstmt.setInt(local.size()+4, startNo);
			}
					
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");
				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	/* 검색어 + 지역 필터 적용 */
	public int totalSearchDistrict(String search, ArrayList<String> local, String order){
		int total = 0;
		
		sb.setLength(0);
		sb.append("SELECT COUNT(*) FROM StoreInfo ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		sb.append("DISTRICT IN ( ");
		for(int i=0; i<local.size(); i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			for(int i=0; i<local.size(); i++) {
				pstmt.setString(i+4, local.get(i));
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				total = rs.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}
	
	
	/* 검색어 + 카테고리 필터 적용 */
	public ArrayList<StoreInfoVO> searchCategory(String search, String[] sector, String order, int startNo){
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		StoreInfoVO vo = null;

		sb.setLength(0);
		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME ");
		sb.append(", STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ, COUNT(REVIEW_NUM) AS REVIEW, IFNULL(ROUND(AVG(POINT),1),0) AS AVGSTAR ");
		sb.append(" FROM StoreInfo s LEFT OUTER JOIN review r USING(STORE_NUM) ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		sb.append("CATEGORY IN ( ");
		for(int i=0; i<sector.length; i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		sb.append("GROUP BY STORE_NUM ");
	
		//sb.append("LIMIT 12 OFFSET ? ");
		
		if (order.equals("AVGSTAR")) {
			sb.append("ORDER BY AVGSTAR DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("HITS")) {
			sb.append("ORDER BY HITS DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("REVIEW")) {
			sb.append("ORDER BY REVIEW DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			for(int i=0; i<sector.length; i++) {
				pstmt.setString(i+4, sector[i]);
			}
			
			//pstmt.setInt(sector.length+4, startNo);
			
			if(order.equals("AVGSTAR")) {
				pstmt.setInt(sector.length+4, startNo);
			}else if(order.equals("HITS")) {
				pstmt.setInt(sector.length+4, startNo);
			}else if(order.equals("REVIEW")) {
				pstmt.setInt(sector.length+4, startNo);
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");
				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	/* 검색어 + 카테고리 필터 적용 */
	public int totalSearchCategory(String search, String[] sector, String order){
		int total = 0;
		
		sb.setLength(0);
		sb.append("SELECT COUNT(*) FROM StoreInfo ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		sb.append("CATEGORY IN ( ");
		for(int i=0; i<sector.length; i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			for(int i=0; i<sector.length; i++) {
				pstmt.setString(i+4, sector[i]);
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				total = rs.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}
	
	/* 검색어 + 지역 + 카테고리 필터 적용 */
	public ArrayList<StoreInfoVO> searchFilter(String search, ArrayList<String> local, String[] sector, String order, int startNo){
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		StoreInfoVO vo = null;

		sb.setLength(0);
		sb.append("SELECT STORE_NUM, STORE_NAME, ADDRS, DISTRICT, SIMPLE_ADDRS, TEL, CATEGORY, OPENTIME, CLOSETIME ");
		sb.append(", STORE_IMAGE, HITS, STORE_MENU, ACCEPT_REZ, COUNT(REVIEW_NUM) AS REVIEW, IFNULL(ROUND(AVG(POINT),1),0) AS AVGSTAR ");
		sb.append(" FROM StoreInfo s LEFT OUTER JOIN review r USING(STORE_NUM) ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		
		sb.append("DISTRICT IN ( ");
		for(int i=0; i<local.size(); i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") AND ");
		
		sb.append("CATEGORY IN ( ");
		for(int i=0; i<sector.length; i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		sb.append("GROUP BY STORE_NUM ");
		
		 // sb.append("LIMIT 12 OFFSET ? "); 
		 		
		
		if (order.equals("AVGSTAR")) {
			sb.append("ORDER BY AVGSTAR DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("HITS")) {
			sb.append("ORDER BY HITS DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}else if(order.equals("REVIEW")) {
			sb.append("ORDER BY REVIEW DESC ");
			sb.append("LIMIT 12 OFFSET ? ");
		}
		
		try {
			
			int idx = 0;
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			
			for(int i=0; i<local.size(); i++) {
				pstmt.setString(i+4, local.get(i));
				idx = i+4;
			}
			idx++;
			for(int j=0; j<sector.length; j++) {
				pstmt.setString(idx, sector[j]);
				idx++;
			}
			
			 // pstmt.setInt(local.size()+sector.length+4, startNo);
			 			
			
			if(order.equals("AVGSTAR")) {
				pstmt.setInt(local.size()+sector.length+4, startNo);
			}else if(order.equals("HITS")) {
				pstmt.setInt(local.size()+sector.length+4, startNo);
			}else if(order.equals("REVIEW")) {
				pstmt.setInt(local.size()+sector.length+4, startNo);
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");
				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	} // filter 종료
	
	
	/* 검색어 + 지역 + 카테고리 필터 적용 */
	public int totalSearchFilter(String search, ArrayList<String> local, String[] sector, String order){
		int total = 0;
		
		sb.setLength(0);
		sb.append("SELECT COUNT(*) FROM StoreInfo ");
		
		sb.append("WHERE (STORE_NAME LIKE ? ");
		sb.append("OR DISTRICT LIKE ? ");
		sb.append("OR CATEGORY LIKE ? ) AND ");
		
		sb.append("DISTRICT IN ( ");
		for(int i=0; i<local.size(); i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") AND ");
		
		sb.append("CATEGORY IN ( ");
		for(int i=0; i<sector.length; i++) {
			if(i == 0) {
				sb.append("? ");
			} else {
				sb.append(", ? ");
			}
		}
		sb.append(") ");
		
		
		try {
			
			int idx = 0;
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			
			
			for(int i=0; i<local.size(); i++) {
				pstmt.setString(i+4, local.get(i));
				idx = i+4;
			}
			idx++;
			for(int j=0; j<sector.length; j++) {
				pstmt.setString(idx, sector[j]);
				idx++;
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				total = rs.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	} // filter 종료
	
	
	public void plusHits(int storeNum) {
		sb.setLength(0);
		sb.append("UPDATE StoreInfo SET HITS = HITS+1 WHERE STORE_NUM = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, storeNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/* 위시리스트 정보 조회 */
	public ArrayList<StoreInfoVO> findWish(int userNum){
		
		ArrayList<StoreInfoVO> list = new ArrayList<StoreInfoVO>();
		StoreInfoVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * FROM StoreInfo WHERE STORE_NUM IN ( ");
		sb.append("SELECT STORE_NUM FROM wishlist WHERE USER_NUM = ? ) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, userNum);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int storeNum = rs.getInt("STORE_NUM");
				String storeName = rs.getString("STORE_NAME");
				String addrs = rs.getString("ADDRS");
				String district = rs.getString("DISTRICT");
				String simpleAddrs = rs.getString("SIMPLE_ADDRS");
				String tel = rs.getString("TEL");
				String category = rs.getString("CATEGORY");
				String opentime = rs.getString("OPENTIME");
				String closetime = rs.getString("CLOSETIME");
				String storeImage = rs.getString("STORE_IMAGE");
				int hits = rs.getInt("HITS");
				String storeMenu = rs.getString("STORE_MENU");
				int acceptRez = rs.getInt("ACCEPT_REZ");
				vo = new StoreInfoVO(storeNum, storeName, addrs, district, simpleAddrs, tel, category, opentime,
						closetime, storeImage, hits, storeMenu, acceptRez);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
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
}