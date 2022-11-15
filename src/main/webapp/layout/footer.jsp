<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
@import 
url('https://fonts.googleapis.com/css2?family=Inter&display=swap');

	*{
		margin : 0;
		padding : 0;
	}
	#footer{
		background: #003049;
		color: #FCBF49;
		width: 1440px;
		margin: auto;
		font-size: 15px;
		line-height: 18px;
	}
	#menu_ul{
		max-width: 1100px;
		margin : auto;
	}
	#footer_menu{
 		border-bottom:  1px solid #224E65;
		background: #003049;
		width : 1100px;
		margin : auto;
	}
	#footer_menu li{
		padding: 15px 0 13px 0;
	}
	#footer_menu li:after{
		float : right;
		display : block;
		content : "|";		
	}
	#footer_menu li.admin:after{
		content: "";
	}
	.fmenu{
		display : inline-block;
		float : none;
		font-weight: 400;	
	}
	.fmenu.privacy a, #company{
		font-weight: 700;
	}
	.fmenu a {
		padding : 0 10px;
		text-decoration: none;
		color: #FCBF49;
	}
	#footer_cmpinfo{
		width : 1100px;
		margin : auto;
		background: #003049;
	}
	#logo{
		width: 220px;
		height: 200px;
	}
	#footer_cmpinfo > p, #divimg{
		float: none;
		display : inline-block;
	}
	#divimg{
		margin: 0 10px;
	}
	.bar{
		display: inline-block;
    	vertical-align: middle;
    	content: " | ";
    	padding: 0 3px;
	}
	#footer_cmpinfo > p{
		vertical-align: top;
		padding : 10px 10px;
		padding-top : 30px;
		line-height: 25px;
		width : 820px;
		font-family: 'Inter';
		font-weight: 400;
	font-size: 15px;
	}
</style>
</head>
<body>
<%MemberVO mvo = new MemberVO();
int grade = 10;
Object mobj = session.getAttribute("vo");
if(mobj != null){
	mvo = (MemberVO) mobj;
	grade = mvo.getGrade();
}
%>
	<div id="footer">
		<div id="footer_menu">
			<ul id="menu_ul">
				<li class="fmenu">
					<a href="" onclick="window.open('../layout/tos.jsp','이용약관','width=900, height=900'); return false;">이용약관</a>
				</li>
				<li class="fmenu privacy">
					<a href="" onclick="window.open('../layout/policy.jsp','개인정보처리방침','width=900, height=900'); return false;">개인정보처리방침</a>
				</li >
				<li class="fmenu">
					<a href="" onclick="window.open('../layout/cmp.jsp','회사소개','width=900, height=900'); return false;">회사소개</a>
				</li>
				<li class="fmenu">
					<a href="" onclick="window.open('../layout/notice.jsp','공지사항','width=900, height=900'); return false;">공지사항</a>
				</li>
				<li class="fmenu admin">
				<%if(grade == 0) {%>
					<a href="../login/logoutOk.jsp">관리자용</a>
					<%} else { %>
					<a href="../login/loginAdmin.jsp">관리자용</a>
					<%} %>
				</li>
			</ul>
			
		</div>
	
		<div id="footer_cmpinfo">
			<div id="divimg"><img src="../logoimg/logo.png" alt="lofo" id="logo"/></div>
			<p>
				<span id="company">주식회사 오밀오밀</span><br /><br />
				서을시 종로구 율곡로 10길 105 디아망 4층
				<span class="bar">|</span>
				대표이사 : 조승목
				<span class="bar">|</span>
				사업자등록번호 : 211-11-11111
				<span class="bar">|</span>
				통신판매업체신고 : 제 2022-서울-종료-7777호
				<span class="bar">|</span>
				개인정보담당자 : privacy@omealomeal.com
				<span class="bar">|</span>
				제휴문의 : partnership@omealomeal.com
				<span class="bar">|</span>
				고객만족센터 : support@omealomeal.com
				<span class="bar">|</span>
				호스팅 제공자 : 카페24주식회사  
				©2022 omealomeal. All rights reserved.
			</p>
		</div>
	
	</div>	
</body>
</html>