<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
* {
	margin: 0px;
	padding: 0px;
}

html, body {
	width: 100%;
	height: 100%;
}
#contain {
    position: relative;
    top: 120px;
	width: 1440px;
	margin: 0 auto;
	background-color: #FFFFFF;
}
.user{
	margin: 0px auto;
	width:500px;
	text-align: center;
}
#nickname {
	width: 124px;
	height: 132px;
	margin: 0px auto;
	
}

#nicklabel {
	width: 89px;
	height: 55.56px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	color: #003049;
	text-align: center;
    margin: 0px auto;
    display: inline-block;
}

#infoedit {
	display: flex;
	position: relative;
    left: 690px;
}

#editlabel {
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 20px;
	line-height: 30px;
	align-items: center;
	letter-spacing: 0.03em;
	color: #003049;
	position: relative;
    top: -8px;
    display: inline;
    margin-left: 5px
}

#line1 {
	width: 1187px;
	height: 0px;
	border: 1px solid #737070;
	margin: 0px auto;
}

.wish{
	width: 1187px;
	margin: 0px auto;
	margin-top: 30px;
    margin-bottom: 30px;
}
#wishlabel {
	width: 173px;
	height: 50px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	color: #003049;
	margin-bottom: 30px;
}

.wishlist {
	width: 1187px;
	height: 200px;
}

#line2 {
	width: 1187px;
	height: 0px;
	margin: 0px auto;
	border: 1px solid #737070;
}

.rezcheckOk{
	width: 1187px;
	margin: 0px auto;
	margin-top: 30px;
    margin-bottom: 30px;
}

#rezlabel {
	width: 147px;
	height: 55.56px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	color: #003049;
	margin-bottom: 30px;	
}

.rezlist {
	width: 1180px;
	position: relative;
    top: -25px;
}

#line3 {
	width: 1187px;
	height: 0px;
	margin: 0px auto;
	border: 1px solid #737070;
}

.myrevOk{
	width: 1187px;
	margin: 0px auto;
	margin-top: 30px;
    margin-bottom: 30px;
}

#myrevlabel {
	width: 147px;
	height: 55.56px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	margin-bottom: 30px;
	color: #003049;
}

.myreviews {
	width: 1180px;
}
</style>
</head>
<%MemberVO mvo = new MemberVO();
Object mobj = session.getAttribute("vo");
if(mobj != null){
	mvo = (MemberVO) mobj;
}
MemberDAO dao = new MemberDAO();
MemberVO mvo2 = dao.isExistsNum(mvo.getUserNum());
%>
<body>
	<jsp:include page="../layout/header.jsp" />
	<div id="contain">
	 
		<div class="user">
		<%if(mvo2.getUserImage() != null){ %>
			 <img id="nickname" src="<%=mvo2.getUserImage() %>" /><br>
		<%} else{ %>
			 <img id="nickname" src="../etcimg/profile.png" /><br>
		<%} %>
			<label id="nicklabel"><%=mvo2.getNickName() %></label>
			<form id="infoedit">
				<a href="myinfoedit.jsp" style="text-decoration:none;"><img id="editicon" src="../etcimg/setting.png" /><p id="editlabel">회원정보수정</p></a>
			</form>
		</div>
	<hr id="line1" />
		<div class="wish">
		<label id="wishlabel">위시리스트</label>
		<div class="wishlist">
			<jsp:include page="wishlist.jsp" />
		</div>
		</div>
	<hr id="line2" />
		<div class="rezcheckOk">
		<label id="rezlabel">예약확인</label>
		<div class="rezlist">
			<jsp:include page="../member/rezcheck.jsp" />
		</div>
		</div>
	<hr id="line3" />
		<div class="myrevOk">
		<label id="myrevlabel">내 리뷰</label>
		<div class="myreviews">
			<jsp:include page="myreview.jsp" />
		</div>
		</div>
		<jsp:include page="../layout/footer.jsp" />
	</div>
</body>
</html>