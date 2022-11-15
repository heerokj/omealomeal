<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    *{
        margin: 0%;
        paddng : 0;
    }
    #regheader {
/*         position: fixed;
        z-index: 100; */
        max-width: 1440px;
        height: 60px;
        background-color: #003049;
 		text-align: center;
    }
    #icon {
        width: 45px;
        height: 45px;
        position: relative;
        top: 7px;
        left: 20px;
        float : left;
    }
    .idpwbtn{
    	position: relative;
    	top: 15px;

        width: 110px;
        height: 30px;
        margin: 0px 10px;
        border-radius: 12px;
        background-color: #224E65;
        color: #FCBF49;
        font-weight: 600;
        size: 15px;
        line-height: 18px;
        border: none;
    }
    .idpwbtn:hover {
        background-color: #1f465b;
    }
  	#regHeadertxt{
		position: relative;
		top: 20px;
		right: 15px;
		font-weight: 600;
		font-size: 15px;
		line-height: 18px;
		float: right;
		color: #FCBF49;
  	}
</style>



<div id="regheader">  
	<a href="../layout/main.jsp"><img src="../logoimg/icon.png" alt="icon" id="icon"></a>
	<a href="../register/findIdPw.jsp?find=findId"><input type="button" value="ID 찾기" class="idpwbtn"/></a>
	<a href="../register/findIdPw.jsp?find=findPw"><input type="button" value="PW 찾기" class="idpwbtn"/></a>
	<span id="regHeadertxt">회원가입</span>
</div>
