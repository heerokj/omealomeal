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
	#findId{
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
		/* letter-spacing: 0.03em; */
		
	}
	.btn1{
		margin: 20px 0;
		width : 360px;
		height : 35px;
		
		font-family: 'Inter';
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
	#findId>h1{
		padding-bottom: 20px;
		color: #003049;
		font-family: 'Inter';
	}
	#gologin > p > a {
		padding : 20px 0;
		text-decoration: none;
		color: #D62828;
	}
	#gologin{
		text-align: center;
	}
	.txt-2{
		font-size: 12px;
		line-height: 18px;
		font-family: 'Poppins';
		color: #003049;
		font-weight: 500;
	}
	.txt-1{
		font-size: 15px;
		font-family: 'Poppins';
		line-height: 22px;
		letter-spacing: 0.03em;
		margin-top: 20px;
		color: #003049;
	}
	#name:focus, #email:focus {
        outline: 2px solid #FCBF49;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/httpRequest.js"></script>
<script>
	$(function(){
		$("#findbtn").on("click", function(){
			if($("#name").val() == ""){
				alert("이름을 입력해주세요.");
				return;
			}else if($("#email").val() == ""){
				alert("이메일을 입력해주세요.");
				return;
			}else if($("#email").val().indexOf("@") == -1){
				alert("이메일 양식을 확인해주세요.")
				return;
			}	
			var name = $("#name").val().trim();
			var email = $("#email").val().trim();
			var params = "name="+name+"&email="+email;
			sendRequest("idFind.jsp", params, callback, "get",)
		});
	});
	function callback(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var msg = xhr.responseText.trim();	
			if(msg == ""){
				alert("아이디 찾기에 실패하였습니다.")
			}else{
				alert("아이디는 " + msg + " 입니다.")
			}
			
		}
		
	}

</script>


<div id="findId">
	<h1>ID찾기</h1>
	<p class="txt-2">회원가입시 입력했던 이름과 이메일을 입력해주세요.</p>
	<p class="txt-1">이름</p>
	<input type="text" name="" id="name" placeholder="이름을 입력해주세요." class="infobox"/>
	<p class="txt-1">이메일</p>
	<input type="text" name="" id="email" placeholder="example@example.com" class="infobox"/>	
	<input type="button" value="ID 찾기" class="btn1" id="findbtn"/>
	<div id="gologin">
		<p class="txt-2">ID를 찾으셨나요? <a href="../login/login.jsp">로그인창으로 갈게요!</a></p>
	</div>					
</div>