package test;

import dao.ReservationDAO;
import vo.ReservationVO;

public class TestMain {

	public static void main(String[] args) {
		
		ReservationDAO dao = new ReservationDAO();
		ReservationVO vo = dao.selectOne(8);
		
		System.out.println(vo.getPeople_num());
	}

}
