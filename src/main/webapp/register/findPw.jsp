<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
@import 
url('https://fonts.googleapis.com/css2?family=Inter&display=swap');
url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
	*{
		margin: 0;
		padding: 0;
	}
	
	#findPw{
		width : 360px;
		margin: auto;
		font-weight: 500;
		padding: 100px 0;
	}
	.infobox{
		width : 350px;
		height : 35px;
		padding-left : 10px;
		margin : 5px 0 10px 0;
		border: 1px solid rgba(0, 0, 0, 0.25);
		filter: drop-shadow(0px 4px 2px rgba(0, 0, 0, 0.25));
		border-radius: 12px;
		font-weight: 300;
		font-size: 14px;
		line-height: 21px;
		letter-spacing: 0.03em;	
	}
	
	.btn1{
		margin: 20px 0;
		width : 360px;
		height : 35px;
		
		font-family: 'Poppins';
		font-size: 15px;
		line-height: 22px;
		
		background: #F77F00;
		box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
		border-radius: 12px;
		border:none;
		color : white;
		
	}
	.btn1:active{
		background : #de7403;
		border: 1px solid rgba(0, 0, 0, 0.5);
	}
	.btn1:hover {
		background: #de7403;
	}
	#findPw>h1{
		padding-bottom: 20px;
		color: #003049;
	}
	#gologin > p > a {
		padding : 20px 0;
		text-decoration: none;
		color: #D62828;
	}
	#gologin{
		text-align: center;
	}
	#question>option[value=""]{
		display : none;
	}
	#question{
		width : 360px;
	}
	.txt-2{
		font-family: 'Poppins';
		font-size: 12px;
		line-height: 18px;
		color: #003049;
		font-weight: 500;
	}
	.txt-1{
		font-family: 'Poppins';
		font-size: 15px;
		line-height: 22px;
		letter-spacing: 0.03em;
		margin-top: 20px;
		color: #003049;
	}
	#id:focus, #question:focus, #answer:focus {
        outline: 2px solid #FCBF49;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/httpRequest.js"></script>
<script>
	$(function(){
		$("#findpwbtn").on("click", function(){
			if($("#id").val() == ""){
				alert("id를 입력해주세요.");
				return;
			}else if($("#question").val() == null){
				alert("질문을 선택해주세요.");
				return;
			}else if($("#answer").val() == ""){
				alert("PW찾기 답을 입력해주세요.");
				return;
			}
			var id = $("#id").val().trim();
			var question = $("#question").val();
			var answer = $("#answer").val().trim();
			var params = "id=" + id +"&question=" + question + "&answer=" + answer;

			sendRequest("pwFind.jsp", params, callback, "get");
		});
	});
	function callback(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var msg = xhr.responseText.trim();
			if(msg == ""){
				alert("pw를 찾을 수 없습니다.");
			}else{
				alert("pw는 " + msg + " 입니다.");
			}
		}
	}
</script>
<div id="findPw">
	<h1>PW 찾기</h1>
	<p class="txt-2">회원가입시 입력했던 정보와 일치하게 입력해주세요.</p>
	<p class="txt-1">아이디</p>
	<input type="text" name="" id="id" placeholder="아이디를 입력해주세요." class="infobox"/>		
	<p class="txt-1">PW 찾기 질문</p>
	<select name="question" id="question" class="infobox">
		<option value="" disabled selected>질문을 선택해주세요.</option>
		<option value="좋아하는 색깔은?">좋아하는 색깔은?</option>
		<option value="보물 1호는?">보물 1호는?</option>
		<option value="다녔던 초등학교는?">다녔던 초등학교는?</option>
		<option value="태어난 곳은?">태어난 곳은?</option>
		<option value="아버님의 성함은?">아버님의 성함은?</option>
		<option value="당신의 생일은?">당신의 생일은?</option>
	</select>	
	<p class="txt-1">PW 찾기답</p>
	<input type="text" name="" id="answer" placeholder="답을 입력해주세요." class="infobox"/>	
	<input type="button" value="PW 찾기" class="btn1" id="findpwbtn"/>
	<div id="gologin">
		<p class="txt-2">PW를 찾으셨나요? <a href="../login/login.jsp">로그인창으로 갈게요!</a></p>
	</div>					
</div>