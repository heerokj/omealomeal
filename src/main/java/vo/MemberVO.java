package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	int userNum;
	String userId;
	String userPw;
	String userName;
	String nickName;
	String email;
	String pwQ;
	String pwA;
	String userImage;
	int grade;

}
