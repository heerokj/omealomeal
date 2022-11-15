<%@page import="dao.MemberDAO"%>
<%@page import="vo.ReviewImgVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewImgDAO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	$("input[name='reviewStar']:checked").prevAll().css('color', 'gold');
	$("input[name='reviewStar']:checked").next().css('color', 'gold');
});

function score(t) {
    var a = ".scorestar:nth-child(-n+" + t * 2 + ")";
    var b = ".scorestar:nth-child(n+" + (t + 1) * 2 + ")";
    $(a).css("color", "gold");
    $(b).css("color", "#003049");
}

function readURL(input, th) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var t = e.target.result;
            $("label[for='file" + th + "']").css('background-image', 'url(' + t + ')').css('background-size', '100% 100%');
            $("label[for='file" + th + "']"+"> .minus").show();
            $("input[name='status" + th + "']").val("upload");
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";
    }
}

function remove(th) {
    console.log("test");
    var t = $("#file"+th).val();
    console.log(t);
    $("#file"+th).val('');
    $("label[for='file" + th + "']").css('background-image', 'url("../images/add-image.png")');
    $("label[for='file" + th + "']"+"> .minus").hide();
    $("input[name='status" + th + "']").val("delete");
    
}
</script>
<%
request.setCharacterEncoding("UTF-8");
String review = request.getParameter("reviewNum");
int rno = 0;
if (review != null) {
	rno = Integer.parseInt(review);
}

ReviewDAO rdao = new ReviewDAO();
ReviewVO rvo = rdao.reviewOne(rno);
%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap');

* {
	margin: 0px;
	padding: 0px;
}

html, body {
	margin: 0px;
	padding: 0px
}

#container {
	margin: 0px auto;
	width: 100%;
}

.top {
	width: 100%;
	height: 60px;
	background-color: #003049;
	margin-bottom: 50px;
}

.top>img {
	width: 45px;
	height: 45px;
	margin-top: 8px;
	margin-left: 15px;
}

.top>p {
	font-size: 15px;
	position: absolute;
	right: 22px;
	top: 16px;
	font-family: '고딕';
	font-weight: bolder;
	color: #FCBF49;
}
.update {
	display: flex;
	width: 750px;
	margin: 0px auto;
}

.update>.user {
	width: 200px;
	text-align: center;
}
.nick{
	font-family: 'Poppins';
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	align-items: center;
	text-align: center;
	letter-spacing: 0.03em;
	color: #003049;
}
.update>.comment {
	margin-left: 30px;
}
.update>.comment>textarea {
	width: 490px;
	height: 300px;
	padding: 10px;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.25));
	border-radius: 12px;
	font-family: 'Poppins';
	font-weight: 300;
	font-size: 14px;
	line-height: 21px;
	letter-spacing: 0.03em;
	/* outline-color: #003049; */
	outline-color: #F77F00;
}

input[type='radio'] {
	display: none;
}

.scorestar {
	font-size: 2em;
	color: #003049;
}
.sendfile {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 125px;
	height: 125px;
	background-color: beige;
	position: relative;
	margin-right:10px;
	margin-left:10px;
	background-image: url('../images/add-image.png');
	background-size: 100% 100%;    
}
.minus {
    width: 20px;
    height: 20px;
    border: none;
    background: transparent;
    background-image: url('../images/minus.png');
    background-size: 20px;
    position: absolute;
    right: -5px;
    top: -5px;
}
.file{
	display : flex;
	margin-top: 20px;
}
input[type='submit']{
    width: 100px;
    height: 40px;
    position:absolute;
    right:30px;
    bottom:50px;
    color: white;
    border: none;
    font-family: 'Poppins';
	font-weight: 500;
	font-size: 12px;
    border-radius: 12px;
    background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
}


</style>
</head>

<body>
	<div id="container">
		<div class="top">
			<img src="../logoimg/icon.png" alt="" />
			<p>리뷰수정</p>
		</div>

		<form action="reviewUpdateOk.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="rNum" value="<%=rvo.getReviewNum() %>" />
			<div class="update">
				<div class="user">
				<%MemberDAO mDao = new MemberDAO(); %>
					<p class="nick"><%=mDao.findNickname(rvo.getUserNum())%></p>
					<div>
						<%
						for (int i = 1; i <= 5; i++) {
							if (i != rvo.getPoint()) {
						%>
						<input type="radio" name="reviewStar" value="<%=i%>"
							id="rate<%=i%>"> <label class="scorestar"
							for="rate<%=i%>" onclick="score(<%=i%>)">★</label>
						<%
						} else if (i == rvo.getPoint()) {
						%>
						<input type="radio" name="reviewStar" value="<%=i%>"
							id="rate<%=i%>" checked="true"> <label class="scorestar"
							for="rate<%=i%>" onclick="score(<%=i%>)">★</label>
						<%
						}
						%>
						<%
						}
						%>
					</div>

				</div>
				<div class="comment">
					<textarea placeholder="리뷰를 입력해주세요." name="comment" id=""><%=rvo.getReviewComment()%></textarea>
					
					<div class="file">
					<%
					int number = 1;

					ReviewImgDAO dao = new ReviewImgDAO();
					ArrayList<ReviewImgVO> list = dao.selectAll(rvo.getReviewNum());

					if (list != null) {
						for (ReviewImgVO vo : list) {
					%>
					<input id="file<%=number%>" type="file" style="display: none;"
						onchange="readURL(this, <%=number%>);" name="file<%=number%>" />
					<label class="sendfile" for="file<%=number%>"
						style="background-image:url(<%=vo.getReviewImg()%>);background-size:100% 100%;">
						<input class="minus" type="button" value="-"
						onclick="remove(<%=number%>);">
					</label> <input type="hidden" name="imgNum<%=number%>"
						value="<%=vo.getImgNum()%>" /> <input type="hidden"
						name="status<%=number%>" value="stop" />
					<%
					number++;
					}

					for (int i = 1; i <= 3 - list.size(); i++) {
					%>
					<input id="file<%=number%>" type="file" style="display: none;"
						onchange="readURL(this, <%=number%>);" name="file<%=number%>" />
					<label class="sendfile" for="file<%=number%>"> <input class="minus"
						type="button" value="-" onclick="remove(<%=number%>);"
						style="display: none;"> <input type="hidden"
						name="status<%=number%>" value="stop" />
					</label>
					<%
					number++;
					}
					}
					%>
					</div>
				</div>
			</div>
			<input type="submit" value="리뷰 수정하기" />
		</form>
	</div>
</body>
</html>