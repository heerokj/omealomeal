<%@page import="dao.MemberDAO"%>
<%@page import="vo.ReviewImgVO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dao.ReviewImgDAO"%>
<%@page import="dao.WishListDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
StoreInfoDAO storeDao = new StoreInfoDAO();
WishListDAO wishDao = new WishListDAO();
String store = request.getParameter("storeNum");
StoreInfoVO storeVo = null;
if (store != null){
	int no = Integer.parseInt(store);
	storeVo = storeDao.selectOne(no);
} else {	
	storeVo = storeDao.selectOne(2);
}
ArrayList<StoreInfoVO> storeList = storeDao.recommend(storeVo.getStoreNum(), storeVo.getSimpleAddrs());
boolean login = false;
boolean wish = false;
MemberVO mvo = new MemberVO(); 
ReviewDAO reviewDao = new ReviewDAO();
ReviewImgDAO reviewImgDao = new ReviewImgDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e340a4990804a7960faa8fdc378a8d87&libraries=services,clusterer,drawing"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
/*---------------------------------------------------------------이미지 확대---------------------------------------------------------------*/
$(function (e) {
    $(document).on("click", ".image>img", function (e) {
        var path = $(this).attr('src')
        var top = window.pageYOffset;
        showImage(path, top);
    });//end click event
    $(".bigPictureWrapper").on("click", function (e) {
        $('.bigPictureWrapper').hide();
    });
});
function showImage(fileCallPath, top) {
    $(".bigPictureWrapper").css("display", "flex").css("top", top).show();
    $(".bigPicture")
        .html("<img src='" + fileCallPath + "' >")
        .animate({ width: '100%', height: '100%' }, 500);
}
/*---------------------------------------------------------------리뷰수정 팝업---------------------------------------------------------------*/
 function updateReview(reviewNum){
	var popupWidth = 800;
	var popupHeight = 900;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	var url = "../member/reviewUpdateForm.jsp?reviewNum="+reviewNum;
	var name = "review Update";
	var option = "width = 800px, height = 900px, top = "+popupY+", left = "+popupX+", resizable=no, location = no";
	
	window.open(url, name, option);
} 
/*---------------------------------------------------------------더보기 버튼 구현---------------------------------------------------------------*/
$(function(){
	$(".list").hide();
	$(".list").slice(0,3).show();
	if($(".list:hidden").length == 0){
		$("#more").hide();
	}
	$("#more").click(function(e){
		if($(".list:hidden").length == 0){
			alert("더이상 리뷰가 존재하지 않습니다.");
		} else {
			e.preventDefault();
			$(".list:hidden").slice(0,3).show();
			console.log($(".list:hidden").length);
		}
	});
	
	$("#map>.storebutton[value='가게 삭제']").on("click", function(){
		window.location = "storeDelete.jsp?storeNum="+<%=storeVo.getStoreNum()%>;
	})
	$("#map>.storebutton[value='정보 수정']").on("click", function(){
		
		var popupWidth = 800;
		var popupHeight = 900;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		var url = "adminStoreInfoUpdateForm.jsp?storeNum="+<%=storeVo.getStoreNum()%>;
		var name = "AdminStoreInfoEdit";
		var option = "width = 800px, height = 900px, top = "+popupY+", left = "+popupX+", resizable=no, location = no";
		
		window.open(url, name, option);
	})
})
</script>

<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="../member/store.css" />
<style>
.swiper {
  width: 1440px;
  height: 300px;
  margin-bottom: 100px
}
.swiper-slide {
  text-align: center;
  font-size: 18px;
  background: #fff;
  /* Center slide text vertically */
  display: -webkit-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  -webkit-justify-content: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  -webkit-align-items: center;
  align-items: center;
}
.swiper-slide img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>
</head>

<body>
	<%-- 사진 클릭시 크게 보일 구간 설정 --%>
	<div class='bigPictureWrapper'>
		<div class='bigPicture'></div>
	</div>

	<%-- 내용을 포함하는 페이지 구간 --%>
	<div id="container">

		<%-- omealomeal 상단바 --%>
		<div class="top">
		<jsp:include page="../layout/header.jsp" />
		</div>
		<div class="storecontents">
			<%-- 가게 이미지 삽입 --%>
			<%ArrayList<ReviewImgVO> imgAll = reviewImgDao.selectStore(storeVo.getStoreNum());
			
			if(imgAll.size() < 4) {%>
			
			<div class="storepicture" style="background : url(<%=storeVo.getStoreImage()%>) no-repeat center;background-size: cover;"></div>
			
			<%} else {%>
			    <div class="swiper mySwiper">
			      <div class="swiper-wrapper">
			      <%for(ReviewImgVO vo : imgAll){ %>
			        <div class="swiper-slide"><img src="<%=vo.getReviewImg()%>"></div>
			       <%} %>
			      </div>
			      <div class="swiper-pagination"></div>
	  		  </div>
	  		  
	  		<!-- Swiper JS -->
		    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
		    <!-- Initialize Swiper -->
		    <script>
		      var swiper = new Swiper(".mySwiper", {
		        spaceBetween: 30,
		        slidesPerView : 3,
		        centeredSlides: true,
		        autoplay: {
		          delay: 3000,
		          disableOnInteraction: false,
		        },
		        loop:true,
		        pagination: {
		          el: ".swiper-pagination",
		          clickable: true,
		        },
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		      });
	    	</script>
			<%} %>
	
			<%-- 페이지 내용 작성 구간(이미지 제외) --%>
			<div class="contents">
				<div class="side">
	
					<%-- 가게 수정 / 삭제 이벤트 버튼 --%>
					<div id="map">
					<p class="tema">가게 관리</p>
					<br><br>
						<input class="storebutton" type="button" value="가게 삭제" /> <br>
						<input class="storebutton" type="button" value="정보 수정" />
					</div>
				</div>
				
				<%-- 가게 정보 입력 --%>
				<div class="dec">
					<div class="infoStore">
						<div class="storename">
	                        <p class="tema"><%=storeVo.getStoreName() %></p>
	                        <%double storestar = reviewDao.averagePoint(storeVo.getStoreNum()); %>
	                        <span class="star">★<span class="tema"><%=storestar %></span></span>
		                </div>
		                    <ul>
		                        <li class="deco">주소 : <%=storeVo.getAddrs() %></li>
		                        <li class="deco">전화번호 : <%=storeVo.getTel() %></li>
		                        <li class="deco">업종 : <%=storeVo.getCategory() %></li>
		                        <%if(storeVo.getStoreMenu() != null) {%>
		                        <li class="deco">주메뉴 : <%=storeVo.getStoreMenu() %></li>
		                        <%}%>
		                        <li class="deco">영업시간 : <%=storeVo.getOpentime()%> ~ <%=storeVo.getClosetime() %></li>
		                        
		                    </ul>
					</div>
	
					<div class="review">
						<p class="tema">리뷰</p>
						<ul>
							<%
								ArrayList<ReviewVO> rList = reviewDao.selectAllReview(storeVo.getStoreNum());
								
								for(ReviewVO vo : rList){
							%>
							<li class="list">
								<div class="user">
								<% MemberDAO mDao = new MemberDAO();%>
									<p class="alias"><%=mDao.findNickname(vo.getUserNum()) %></p>
									<p><%
									for(int i = 1; i <= vo.getPoint(); i++){
										out.println("<span style='color:gold;'>★</span>");
									}
									for(int i = 1; i <= (5-vo.getPoint()); i++){
										out.println("<span style='color:#003049;'>★</span>");
									}
									%></p>
									<p class="alias"><%=vo.getReviewDate()%></p>
								</div>
								<div class="commend">
									<pre><%=vo.getReviewComment() %></pre>
									<div class="image">
									<%
									ArrayList<ReviewImgVO> imgList = reviewImgDao.selectAll(vo.getReviewNum());
									
									for(ReviewImgVO imgVo : imgList){
									%>
									<img class="" src="<%=imgVo.getReviewImg() %>" alt="" />
									<%
									}
									%>
									</div>
								</div>
								<div id="log">
	                                <a href="../member/reviewDeleteOk.jsp?reviewNum=<%=vo.getReviewNum()%>&storeNum=<%=storeVo.getStoreNum()%>"><input class="btn" type="button" value="삭제하기"></a>
	                            </div>
							</li>
								<%
								}
								%>
							<input type="button" value="▼더보기" id="more" />
	
						</ul>
					</div>
				</div>
			</div>
			<jsp:include page="../layout/footer.jsp" />
		</div>
	</div>
</body>
</html>