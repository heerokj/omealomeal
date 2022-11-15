package test;

import java.util.ArrayList;

import dao.ReservationDAO;
import dao.StoreInfoDAO;
import vo.ReservationVO;
import vo.StoreInfoVO;

public class Test {
	public static void main(String[] args) {
		
		StoreInfoDAO storeDao = new StoreInfoDAO();
//		ArrayList<StoreInfoVO> storeList = storeDao.findWish(1);
		int total = storeDao.totalSelect("아", null);
		/*
		 * for(StoreInfoVO vo : storeList) {
		 * 
		 * System.out.println(vo.getStoreName()); }
		 */
		
		System.out.println(total);
		
		
//		ReservationDAO dao = new ReservationDAO();
//		ArrayList<ReservationVO> rezlist = dao.findRez(1);
//		
//		for(ReservationVO vo : rezlist) {
//			
//			System.out.println(vo.getStore_num());
//		}
	}

}
