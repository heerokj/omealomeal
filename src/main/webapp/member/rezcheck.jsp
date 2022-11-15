<%@page import="vo.ReservationVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@page import="dao.ReservationDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberVO mvo = new MemberVO();
Object obj = session.getAttribute("vo");

if (obj != null) {
	mvo = (MemberVO) obj;
}

StoreInfoDAO storeDAO = new StoreInfoDAO();

ReservationDAO rezDAO = new ReservationDAO();
ArrayList<ReservationVO> rezList = rezDAO.findRez(mvo.getUserNum());

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rezcheck</title>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@500&display=swap');
body {
	position: relative;
	background: #fff;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	color: #003049;
	margin: 0 auto;
}

.rezcheck {
	 position: relative; 
	background: #e8e8e8;
	width: 1180px;
	/* height: 210px; */
	display: flex;
	margin-top: 15px;
}

#rezstore {
	object-fit: cover;
	left: 0%;
	right: 69.34%;
	top: -4.24%;
	bottom: 15.25%;
	width: 210px;
	height: 210px;
}

#storename {
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 20px;
	line-height: 24px;
	display: flex;
	align-items: center;
	color: #003049;
	width: 300px;
}

#rezinfo {
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 16px;
	line-height: 30px;
	color: #000000;
	margin: auto 0px;
	margin-left: 30px;
}

#rezedit {
	border: 0;
	outline: 0;
	background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	color: #FFFFFF;
	position: absolute;
	top: 10px;
	right : 130px;
	width: 80px;
	height:40px;
}

#rezcancel {
	position: absolute;
    top: 10px;
    right: 30px;
    width: 80px;
    height: 40px;
	border: 0;
	outline: 0;
	background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	color: #FFFFFF;
}
.plus {
	position: relative;
	left: 1115px;
	
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	$(".rezcheck").hide();
	$(".rezcheck").slice(0,1).show();
	if($(".rezcheck:hidden").length == 0){
		$("#moreRez").hide();
	}
	$("#moreRez").click(function(e){
		if($(".rezcheck:hidden").length == 0){
			alert("더이상 예약내역이 존재하지 않습니다.");
		} else {
			e.preventDefault();
			$(".rezcheck:hidden").slice(0,1).show();
			console.log($(".rezcheck:hidden").length);
		}
	});
})

function updateForm(rezNum){
	document.location = "../member/rezUpdateForm.jsp?rezNum="+rezNum;
}

function deleteForm(rezNum){
	document.location = "../member/rezDeleteOk.jsp?rezNum="+rezNum;
}
</script>
<body>
	<div class="plus" id="moreRez">
	<img src="../images/more.png" alt="" />
	<span style="color:#DB1E1E;font-family: 'Inter';font-style: normal;font-weight: 500;font-size: 15px;">더 보기</span>
	</div>
	<%
	for (ReservationVO rezVo : rezList) {
		StoreInfoVO storeVo = storeDAO.selectOne(rezVo.getStore_num());
	%>
	<div class="rezcheck">
		<img id="rezstore" src="<%=storeVo.getStoreImage() %>" /> 
		<div id="rezinfo">
		<p id="storename"><%=storeVo.getStoreName() %></p>
			주소 : <%=storeVo.getAddrs() %></br> 
			인원수 : <%=rezVo.getPeople_num() %></br> 
			날짜 : <%=rezVo.getRez_date() %></br> 
			시간 : <%=rezVo.getTime() %></br> 
			요청사항 : <%=rezVo.getMemo() %>
		</div>
		<input type="button" value="수정" id="rezedit" onclick="updateForm(<%=rezVo.getRez_num()%>);"/> 
		<input type="button" value="취소" id="rezcancel" onclick="deleteForm(<%=rezVo.getRez_num()%>)" />
	</div>

	<%
	}
	%>
</body>
</html>