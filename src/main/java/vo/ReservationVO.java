package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ReservationVO {
	int rez_num;
	int user_num;
	int store_num;
	int people_num;
	String rez_date;
	String time;
	String memo;
	int status;
	
	public ReservationVO(int user_num, int people_num, int store_num, String rez_date, String time, String memo) {
		super();
		this.user_num = user_num;
		this.people_num = people_num;
		this.store_num = store_num;
		this.rez_date = rez_date;
		this.time = time;
		this.memo = memo;
	}
	
}