<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<style>
@import 
url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

	.container1 {
		height: 765px;
		width: 1440px;
		margin: auto;
	}
	/* 왼쪽 음식 사진 */
	.foodImg {
		position: relative;
		top: 60px;
		width: 740px;
		height: 705px;
	}
	.foodImg>img {
		width: 740px;
		height: 705px;
	}
	.login {
		width: 370px;
		height: 400px;
		position: relative;
		left: 940px;
		bottom: 490px;
		font-family: 'Poppins', sans-serif;
		
	}
	/* 아이디,비밀번호 입력 */
	#userId, #userPw {
		padding-left: 10px;
		width: 358px;
		height: 41px;
		border-radius: 12px;
		border: 1px solid rgba(0, 0, 0, 0.25);
		filter: drop-shadow(0px 4px 2px rgba(0, 0, 0, 0.25));
	}
	#userId:focus, #userPw:focus {
        outline: 2px solid #FCBF49;
    }
	#textId, #textPw {
		font-size: 20px;
		font-weight: bold;
		color: #003049;
		position: relative;
		top: 10px;
	}
	.inputPw {
		position: relative;
		top: 40px;
	}
	/* 아이디,비번 찾기 */
	.find {
		position: relative;
		top: 63px;
		left: 0px;
	}
	.find>a {
		text-decoration: none;
		font-weight: 500;
		font-size: 12px;
		line-height: 18px;
		text-align: right;
		color: #f76700;
		position: relative;
		left: 70px;
	}
	/* 정보 기억 */
	#checkId {
		border: 1px solid rgba(0, 0, 0, 0.25);
		border-radius: 4px;
		box-sizing: border-box;
		position: relative;
		top: 2px;
		accent-color: #F77F00;
	}
	/* 로그인버튼 */
	.btn {
		position: relative;
		top: 80px;
	}
	#loginBtn {
		width: 360px;
		height: 41px;
		color: #FFFFFF;
		background: #F77F00;
		filter: drop-shadow(0px 4px 2px rgba(0, 0, 0, 0.25));
		border-radius: 12px;
		border: 0;
	}
	#loginBtn:hover {
		background: #de7403;
	}
	/* 회원가입 */
	.register {
		position: relative;
		top: 110px;
		left: 50px;
		width: 270px;
		height: 15px;
		font-weight: 500;
		font-size: 12px;
		line-height: 18px;
		text-align: center;
		color: #003049;		
	}
	.register>a {
		text-decoration: none;
		font-weight: 500;
		font-size: 12px;
		text-align: right;
		color: #f76700;
	}
	.errMsg {
		position: relative;
		top: 55px;
		left: 40px;
		color: #ed0000;
		font-size: 15px;
	}
	.footer {
		position: relative;
		bottom: 340px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	/* 로그인 유효성 검사 후 전달*/
	window.onload = function(){
		var loginBtn = document.getElementById("loginBtn");
		loginBtn.onclick = function(){
			//console.log("test");
			
			var frm = document.frm;
			var userId = document.getElementById("userId").value;
			var userPw = document.getElementById("userPw").value;
			
			if(userId == ""){
				alert("아이디를 입력해주세요.");
				form.userId.focus();
				return false;
			}
			
			if(userPw == ""){
				alert("비밀번호를 입력해주세요.");
				form.userId.focus();
				return false;
			}
			
			frm.action = "loginOk.jsp";
			frm.submit();
		}
		
	}
	
	$(function(){		
		$("#userPw").keyup(function(e){
			if(e.keyCode == 13){				
				var frm = document.frm;
				var userId = document.getElementById("userId").value;
				var userPw = document.getElementById("userPw").value;
				
				if(userId == ""){
					alert("아이디를 입력해주세요.");
					form.userId.focus();
					return false;
				}
				
				if(userPw == ""){
					alert("비밀번호를 입력해주세요.");
					form.userId.focus();
					return false;
				}
				
				frm.action = "loginOk.jsp";
				frm.submit();
			}
		})
	})
	
 	/* 음식이미지 출력 */
	$(function(){
    	var rnd = Math.floor(Math.random()*2);
    	$(".foodImg>img").attr("src","../images/foodImg"+(rnd+1)+".jpg");
	})
	
	/* 아이디 저장하기 */
    $(document).ready(function(){
        var key = getCookie("key");
        $("#userId").val(key);

        if($("#userId").val() != ""){
            $("#checkId").attr("checked", true);
        }

        $("#checkId").change(function(){
            if($("#checkId").is(":checked")){
                setCookie("key", $("#userId").val(), 7);
            }else{
                deleteCookie("key");
            }
        })
    })
		
	// 쿠키 저장하기 
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}
     
	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
                //console.log("end위치  : " + end);
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>
</head>
<body>
	<% 
		Object obj = session.getAttribute("vo");
		String errMsg = (String)session.getAttribute("errMsg");
		
		if(errMsg == null) errMsg = "";
		session.invalidate();
		
		if(obj!=null){
			MemberVO vo = (MemberVO)obj;
		}else{
			// 로그인 안되어 있을 때 -> 로그인 창 보여주기
	%>
	<form action = "./loginOk.jsp" name = "frm" method = "post" style= "width:1440px; margin:auto;" >	
	<jsp:include page="../layout/header.jsp"></jsp:include>
		<div class="container1">		
			<div class="foodImg">
				<img src="" alt="foodImg">
			</div>
			<div class="login">
				<div class="inputId">
					<p id="textId">아이디</p><br>
					<input type="text" name="id" placeholder=" 아이디를 입력해주세요." id="userId"><br>
				</div>
				<div class="inputPw">
					<p id="textPw">비밀번호</p><br>
					<input type="password" name="pw" placeholder=" 비밀번호를 입력해주세요." id="userPw">
				</div>
				<div class="errMsg"><%=errMsg %></div>
				<div class="find">
					<input type="checkbox" name="" id="checkId"><span style= "font-size: 12px; color: #003049;">&ensp;아이디 저장하기</span>
					<a href="../register/findIdPw.jsp">아이디, 비밀번호를 잊어버렸어요.</a>
				</div>
				<div class="btn">
					<input type="button" value="로그인" id="loginBtn">
				</div>
				<div class="register">
					계정이 없으신가요? <a href="../register/register.jsp">지금 무료로 회원가입하세요!</a>
				</div>
			</div>
		</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	</form>
	<%
		}
	%>
	
</body>
</html>