<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Inter&display=swap');
    *{
        margin: 0%;
    }
    .container {
        width: 1440px;
        margin: auto;
    }
    /* 상단바 */
    .header {
        position: fixed;
        z-index: 100;
        width: 1440px;
        height: 60px;
        background-color: #003049;
        font-family: 'Inter', sans-serif;
    }
    /* 로그인버튼 */
    #btnLogin {
        border-radius: 12px;
        width: 110px;
        height: 30px;
        background-color: #224E65;
        color: #FCBF49;
        font-weight: 600;
        size: 15px;
        line-height: 18px;
        position: relative;
        left: 1140px;
        bottom: 10px;
        border: 0;
    }
    #btnLogin:hover {
        background-color: #1f465b;
    }
    /* 회원가입버튼 */
    #btnRegister {
        border-radius: 12px;
        width: 110px;
        height: 30px;
        background-color: #224E65;
        color: #FCBF49;
        font-weight: 600;
        size: 15px;
        line-height: 18px;
        position: relative;
        left: 1145px;
        bottom: 10px;
        border: 0;
    }
    #btnRegister:hover {
        background-color: #1f465b;
    }
    /* 로그아웃버튼 */
    #btnLogout {
        border-radius: 12px;
        width: 110px;
        height: 30px;
        background-color: #224E65;
        color: #FCBF49;
        font-weight: 600;
        size: 15px;
        line-height: 18px;
        position: relative;
        left: 1140px;
        bottom: 10px;
        border: 0;
    }
    /* 내정보 버튼 */
    #btnMyInfo {
        border-radius: 12px;
        width: 110px;
        height: 30px;
        background-color: #224E65;
        color: #FCBF49;
        font-weight: 600;
        size: 15px;
        line-height: 18px;
        position: relative;
        left: 1145px;
        bottom: 10px;
        border: 0;
    }
    /* 로고이미지 */
    #icon {
        width: 45px;
        height: 45px;
        position: relative;
        top: 7px;
        left: 20px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">   
            <a href="../layout/main.jsp"><img src="../logoimg/icon.png" alt="icon" id="icon"></a>
	<%
		Object obj = session.getAttribute("vo");
	
		if(obj!=null){
			// 로그인이 되어 있을 때
			MemberVO vo = (MemberVO)obj;
	%>
			<a href="../login/logoutOk.jsp"><input type="button" value="로그아웃" id="btnLogout"></a>
            <a href="../myInfo/myinfo.jsp"><input type="button" value="내 정보" id="btnMyInfo"></a>
	<%
		}else{
			// 로그인이 안되어 있을 때
			%>
			<a href="../login/login.jsp">
			<input class="log"  type="button" value="로그인" id="btnLogin"></a> 
			<a href="../register/register.jsp">
			<input type="button" class="info" value="회원가입" id="btnRegister"></a>
	<%
		}
	%>
		</div>
	</div>
</body>
</html>