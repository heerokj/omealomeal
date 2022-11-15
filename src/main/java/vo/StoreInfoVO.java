package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoreInfoVO {
	
	int storeNum;
	String storeName;
	String addrs;
	String district;
	String simpleAddrs;
	String tel;
	String category;
	String opentime;
	String closetime;
	String storeImage;
	int hits;
	String storeMenu;
	int acceptRez;
	public StoreInfoVO(int storeNum) {
		this.storeNum = storeNum;
	}
	
	
}