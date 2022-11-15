package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	int reviewNum;
	int storeNum;
	int userNum;
	String reviewDate;
	int point;
	String reviewComment;

}
