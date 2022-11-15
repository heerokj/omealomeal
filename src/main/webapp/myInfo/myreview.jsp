<%@page import="dao.MemberDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@page import="dao.ReviewImgDAO"%>
<%@page import="vo.ReviewImgVO"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myreview</title>
</head>
<%
	MemberVO mvo = new MemberVO();
	Object obj = session.getAttribute("vo");
	
	if(obj != null){
		mvo = (MemberVO)obj;
	}
	MemberDAO dao = new MemberDAO();
	MemberVO mvo2 = dao.isExistsNum(mvo.getUserNum());
	ReviewImgDAO rimgdao = new ReviewImgDAO();
%>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap')
	;

body {
	position: relative;
	background: #fff;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	color: #003049;
	margin: 0 auto;
}

.myReview {
	width: 1180px;
	padding-botton: 50px;
}

.reviewDelete {
	position : relative;
	width: 19px;
	height: 19px;
	left: 70px;
	
	margin-bottom: 10px;
}

.insertDate {
	text-align: center;
	letter-spacing: 0.03em;
	color: #003049;
	display: inline-block
}

.reviewText {
	letter-spacing: 0.03em;
	color: #003049;
	width: 650px;
	white-space: pre-wrap;
}

.reviewUpdate {
	border: 0;
	outline: 0;
	background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	color: #FFFFFF;
	font-weight: 500;
	font-size: 12px;
	line-height: 22px;
	text-align: center;
	letter-spacing: 0.03em;
	width: 100px;
	height: 40px;
	filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
}
.reviewUpdate:hover {
	background: #de7403;
}


/*=================================================  */
/* 리뷰보기 style */

.list {
	display: flex;
	margin-top: 30px;
	margin-bottom: 10px;
	position: relative;
	padding: 10px 0;
}

.image {
	margin-top: 20px;
}

.image>img {
	width: 100px;
	height: 100px;
}

.comment {
	padding-left: 20px;
	width: 800px;
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	letter-spacing: 0.03em;
	color: #003049;
}

.reviewuser {
	width: 200px;
	text-align: center;
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	color: #003049;
}

#log {
	float: right;
	position: absolute;
	top: 10px;
	right: 10px;
}

#myReviewMore {
	width: 1180px;
	height: 40px;
	background-color: transparent;
	border: 2px solid #FCBF49;
	color: #F77F00;
	margin-top: 20px;
	margin-bottom: 40px;
	border-radius: 12px;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

	$(function(){
		$("#reviewDelete").on("click", function(){
			console.log("test");
		});
		$("#reviewUpdate").on("click", function(){
			console.log("test");
		});
		
		
		
 		$(".list").hide();
		$(".list").slice(0,3).show();
		if($(".list:hidden").length == 0){
			$("#myReviewMore").hide();
		}
				$("#myReviewMore").click(function(e){
			
			if($(".list:hidden").length == 0){
				alert("더이상 리뷰가 존재하지 않습니다.");
			} else {
				e.preventDefault();
				$(".list:hidden").slice(0,3).show();
				console.log($(".list:hidden").length);
			}
		}); 
	});
	
	function delConfirm(reviewNum){
		var confirmflag = confirm("리뷰를 삭제하시겠습니까?");
		if(confirmflag){
			location.href = "./myreviewDeleteOk.jsp?reviewNum="+reviewNum;
		}else{
			console.log("취소");
		}
	}
	function modifyReview(reviewNum){
		var popupWidth = 800;
		var popupHeight = 900;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		var url = "reviewUpdateForm.jsp?reviewNum="+reviewNum;
		var name = "review Update";
		var option = "width = 800px, height = 900px, top = "+popupY+", left = "+popupX+", resizable=no, location = no";
		
		window.open(url, name, option);
	}
	
</script>
<body>
	<div class="myReview">
		<ul>
				
		<%
			ReviewDAO rdao = new ReviewDAO();
			ArrayList<ReviewVO> rList = rdao.selectAllMemberReview(mvo.getUserNum());
			StoreInfoDAO sinfodao = new StoreInfoDAO();
			StoreInfoVO sinfovo = new StoreInfoVO();
			
			for(ReviewVO vo : rList){
		
				sinfovo = sinfodao.selectOne(vo.getStoreNum());
	
		%> 
			<li class="list">
				<div class="reviewuser">	
					<label class=""><%=mvo2.getNickName() %></label> 
					<p><%=sinfovo.getStoreName() %></p>
					<p>
						<%
							for(int i = 1; i <= vo.getPoint(); i++){
								out.println("<span style='color:gold;'>★</span>");
							}
							for(int i = 1; i <= (5-vo.getPoint()); i++){
								out.println("<span style='color:#003049;'>★</span>");
							}
						%>
					</p>
					<label class="insertDate"><%=vo.getReviewDate() %></label>
				</div>
				<div class="comment">
					<label class="reviewText"><%=vo.getReviewComment() %></label>
					<div class="image">
						<%
							ArrayList<ReviewImgVO> imgList = rimgdao.selectAll(vo.getReviewNum());
							
							for(ReviewImgVO imgVO : imgList){
						%>
							<img src="<%=imgVO.getReviewImg() %>" alt="<%=imgVO.getImgNum() %>" />					
						<%
							}
						%>		
					</div>
				</div>
				<div id="log">
					<img src="../etcimg/close.png" class="reviewDelete" onclick="delConfirm(<%=vo.getReviewNum() %>)">	<br />	
					<input type="button" value="리뷰 수정" class="reviewUpdate" onclick="modifyReview(<%=vo.getReviewNum() %>)"/>
				</div>
			</li>
		<%
			}
		%>
			<input type="button" value="▼더보기" id="myReviewMore" />
		</ul>
	</div>
</body>
</html>