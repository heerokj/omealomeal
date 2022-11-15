package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OmealMemberVO {
	int user_num;
	String user_id;
	String user_pw;
	String user_name;
	String nickname;
	String email;
	String pw_q;
	String pw_a;
	String user_image;
	int grade;
	
	public OmealMemberVO(int user_num, String user_pw) {
		super();
		this.user_pw = user_pw;
		this.user_num = user_num;
	}
	
	public OmealMemberVO(String user_id, String user_pw, String user_name, String nickname, String email, String pw_q,
			String pw_a) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.nickname = nickname;
		this.email = email;
		this.pw_q = pw_q;
		this.pw_a = pw_a;
	}
}
