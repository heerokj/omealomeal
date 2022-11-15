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
	storeDao.plusHits(no);
	storeVo = storeDao.selectOne(no);
} else {	
	storeVo = storeDao.selectOne(3);
}
ArrayList<StoreInfoVO> storeList = storeDao.recommend(storeVo.getStoreNum(), storeVo.getSimpleAddrs());
boolean login = false;
boolean wish = false;
MemberVO mvo = new MemberVO(); 
Object objlogin = session.getAttribute("vo");
if(objlogin != null){
login = true;
mvo = (MemberVO) objlogin;
wish = wishDao.isWish(storeVo.getStoreNum(), mvo.getUserNum());
}
ReviewDAO reviewDao = new ReviewDAO();
ReviewImgDAO reviewImgDao = new ReviewImgDAO();

MemberDAO mDao = new MemberDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e340a4990804a7960faa8fdc378a8d87&libraries=services,clusterer,drawing"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
/*---------------------------------------------------------------지도관련 script---------------------------------------------------------------*/
	$(function(){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 5
		};
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		<% if(storeList != null){
		
		for (int i = 0; i < storeList.size(); i++) { %>
		
		geocoder.addressSearch('<%=storeList.get(i).getAddrs()%>',
				function(result, status) {
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker(
								{
									map : map,
									position : coords,
								});
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						var infowindow = new kakao.maps.InfoWindow(
								{
									content : '<div style="width:300px;text-align:center;padding:6px 3px;padding-bottom:10px;">'+
												'<span style="color:navy;font-weight:bold;"><%=storeList.get(i).getStoreName()%></span>'+
												'<span style="color:grey;">  <%=storeList.get(i).getCategory()%></span>'+
												'<p style="font-size:12px;text-align:left;margin-top:3px;"><%=storeList.get(i).getAddrs()%></p></div>'
							});
						// 마커에 마우스오버 이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'mouseover', function() {
						  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
						    infowindow.open(map, marker);
						});
						// 마커에 마우스아웃 이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'mouseout', function() {
						    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
						    infowindow.close();
						});
					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				}
			});		
		<%}	
		}%>
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('<%=storeVo.getAddrs()%>',
						function(result, status) {
							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {
								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
							    var imageSize = new kakao.maps.Size(24, 35); 
							    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker(
										{
											map : map,
											position : coords,
									        image : markerImage // 마커 이미지 
										});
								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow(
										{
											content : '<div style="width:300px;text-align:center;padding:6px 3px;padding-bottom:10px;">'+
														'<span style="color:navy;font-weight:bold;"><%=storeVo.getStoreName()%></span>'+
														'<span style="color:grey;">  <%=storeVo.getCategory()%></span>'+
														'<p style="font-size:12px;text-align:left;margin-top:3px;"><%=storeVo.getAddrs()%></p></div>'
									});
							infowindow.open(map, marker);
							
							kakao.maps.event.addListener(marker, 'click', function() {
							      // 마커 위에 인포윈도우를 표시합니다
							      infowindow.close(); 
							});
							kakao.maps.event.addListener(marker, 'mouseover', function() {
								  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
								    infowindow.open(map, marker);
							});
							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});
	});
</script>

<script>
/*---------------------------------------------------------------위시리스트 등록 및 예약하기---------------------------------------------------------------*/
$(function(){
	
	$("#rez").on('click', function(){
		if(<%=!login%>){
			alert("로그인 후 이용해주세요");
			window.location = "../login/login.jsp";
		}else{
			window.location = "reservation.jsp?storeNum=<%=storeVo.getStoreNum()%>"
		}
	});
	$("#wish").on('click', function(){
		if(<%=!login%>){
			alert("로그인 후 이용해주세요");
			window.location = "../login/login.jsp";
		} else if (<%=wish%>){
			alert("위시리스트에서 제거되었습니다.");
			window.location = "wishDeleteOk.jsp?storeNum=<%=storeVo.getStoreNum()%>";
		} else if (<%=!wish%>){
			alert("위시리스트에 등록되었습니다.");
			window.location = "wishInsertOk.jsp?storeNum=<%=storeVo.getStoreNum()%>";
		}
	});
});
</script>

<script> 
/*---------------------------------------------------------------리뷰작성---------------------------------------------------------------*/
$(function () {
    $(".scorestar").hover(function () {
        var flag = $("input[name='reviewStar']").is(':checked');
        var t = $(this).attr('for').substr(4);
        if (!flag) {
            $(this).prevAll().css("color", "gold");
            $(this).css("color", "gold");
        }
    }, function () {
        var flag = $("input[name='reviewStar']").is(':checked');
        if (!flag) {
            $(".scorestar").css("color", "#bbbbbb");
        }
    });
    
	$("#notreview").on('click', function(){
		alert("로그인 후 이용해주세요");
		window.location = "../login/login.jsp";
	});
	
	$("#submitform").on('click', function(){
        if($("textarea").val() == '') {
            alert("리뷰를 작성해주세요");
            $("textarea").focus();
            return;
        } if(!$("input[name='reviewStar']").is(':checked')) {
            alert("별점을 등록해주세요");
            return;
        }
        $("#myform").submit();
    })
});
function score(t) {
    var a = ".scorestar:nth-child(-n+" + t * 2 + ")";
    var b = ".scorestar:nth-child(n+" + (t + 1) * 2 + ")";
    $(a).css("color", "gold");
    $(b).css("color", "#bbbbbb");
}
$(function () {
    $("#file").on('change', function () {
        console.log("file upload 완료");
        var reader = new FileReader();
        reader.onload = function (e) {
            var t = e.target.result;
            console.log(t);
        }
    });
});
function readURL(input, th) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var t = e.target.result;
            $("label[for='file" + th + "']").css('background-image', 'url(' + t + ')').css('background-size', '100% 100%');
            $("label[for='file" + th + "']"+"> .minus").show();
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
}
</script>

<script>
/*---------------------------------------------------------------이미지 확대---------------------------------------------------------------*/
$(function (e) {
    $(document).on("click", ".image>img", function (e) {
        var path = $(this).attr('src')
        var top = window.pageYOffset;
        console.log(top);
        showImage(path, top);
    });//end click event
    function showImage(fileCallPath, top) {
        $(".bigPictureWrapper").css("display", "flex").css("top", top).show();
        $(".bigPicture")
            .html("<img src='" + fileCallPath + "' >")
            .animate({ width: '100%', height: '100%' }, 500);
    }//end fileCallPath
    $(".bigPictureWrapper").on("click", function (e) {
        $('.bigPictureWrapper').hide();
    });//end bigWrapperClick event
});
/*---------------------------------------------------------------리뷰수정 팝업---------------------------------------------------------------*/
function updateReview(reviewNum){
	var popupWidth = 800;
	var popupHeight = 900;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	var url = "reviewUpdateForm.jsp?reviewNum="+reviewNum;
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
})
</script>

<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="store.css" />

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
	
					<%-- 가게 지도 표현 --%>
					<div id="map"></div>
	
					<%-- 주변 가게 추천 --%>
					<% if(storeList != null) {%>
					
					<div class="recommend">
						<p class="tema" style="margin-bottom:40px;">주변 추천 맛집</p>
						<ul style="list-style: none;">
						
							<% for(StoreInfoVO svo : storeList){
								double recommend = reviewDao.averagePoint(svo.getStoreNum());
								%>
								<a style="text-decoration:none;color:black;" href="storeInfo.jsp?storeNum=<%=svo.getStoreNum()%>">
								<li class="reclist">
	                            <div class="recstore">
	                                <img src="<%=svo.getStoreImage() %>" alt="">
	                                <p style="width: 200px; height:20px; padding: 3px 10px;">
	                                    <span class="recName"><%=svo.getStoreName() %></span>
	                                </p>
	                                <p class="recDist" style="padding: 3px 10px;"><%=svo.getDistrict() %>
	                                <span style="color:gold;position:absolute;right:5px;">★<span style="color: black;"><%=recommend %></span></span></p>
		                        </div>
		                        </li>
	                        	</a>
							<%
							}
						}%>
						</ul>
					</div>
				</div>
				
				<%-- 가게 정보 입력 --%>
				<div class="dec">
					<div class="infoStore">
						<div class="storename">
	                        <p class="tema"><%=storeVo.getStoreName() %></p>
	                        <%double storestar = reviewDao.averagePoint(storeVo.getStoreNum()); %>
	                        <span class="star">★<span class="tema"><%=storestar %></span></span>
	                        <div class="eventbtn">
	                            <button type="button" style="margin-right: 20px;" id="rez"><img src="../images/reservation.png" alt=""><br>예약하기</button>
	                            <%if(!wish) { %> 
	                            <button type="button" id="wish"><img src="../images/wish-list.png" alt=""><br>위시리스트</button>
	                            <%} else if(wish) {%>
	                            <button type="button" id="wish"><img src="../images/wish-list-full2.png" alt=""><br>위시리스트</button>
	                            <%}%>
	                        </div>
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
					<%-- 리뷰 작성 --%>
					<div class="write">
						<form name="frm" action="reviewOk.jsp" id="myform" method="post" enctype="multipart/form-data">
						<input type="hidden" name="storeNum" value=<%=storeVo.getStoreNum() %> />
	                        <p class="tema">리뷰</p>
	                        <div class="pane">
	                            <div class="writeuser"> <br>
	                            	<%if(login){
	                            		out.println("<p class='alias'>"+mDao.findNickname(mvo.getUserNum())+"</p>");
	                            	} else{
	                            		out.println("<p class='alias'>닉네임</p>");
	                            	}%>
	                                <div>
	                                    <input type="radio" name="reviewStar" value="1" id="rate1"><label class="scorestar" for="rate1" onclick="score(1)">★</label>
	                                    <input type="radio" name="reviewStar" value="2" id="rate2"><label class="scorestar" for="rate2" onclick="score(2)">★</label>
	                                    <input type="radio" name="reviewStar" value="3" id="rate3"><label class="scorestar" for="rate3" onclick="score(3)">★</label>
	                                    <input type="radio" name="reviewStar" value="4" id="rate4"><label class="scorestar" for="rate4" onclick="score(4)">★</label>
	                                    <input type="radio" name="reviewStar" value="5" id="rate5"><label class="scorestar" for="rate5" onclick="score(5)">★</label>
	                                </div>
	
	                            </div>
	                            <div class="writecomment">
	                                <textarea name="reviewcomment" id="" placeholder="리뷰를 작성해주세요."></textarea>
	                                <div>
	                                    <input id="file1" type="file" style="display: none;" onchange="readURL(this, 1);" name="file1" />
	                                    <label for="file1" class="file">
	                                        <input class="minus" type="button" value="-" onclick="remove(1);">
	                                    </label>
	                                    <input id="file2" type="file" style="display: none;" onchange="readURL(this, 2);" name="file2" />
	                                    <label for="file2" class="file">
	                                        <input class="minus" type="button" value="-" onclick="remove(2);">
	                                    </label>
	                                    <input id="file3" type="file" style="display: none;" onchange="readURL(this, 3);" name="file3"/>
	                                    <label for="file3" class="file">
	                                        <input class="minus" type="button" value="-" onclick="remove(3);">
	                                    </label>
	                                </div>
	                            </div>
	                            <%
	                            if(login){%>
		                            <input type="button" value="리뷰 등록" id="submitform" >                        
	                            <%} else { %>
	                            	<input type="button" value="리뷰 등록" id="notreview"/>
	                            <% } %>
	                        </div>
	                    </form>
					</div>
	
	
					<div class="review">
						<ul>
							<%
								ArrayList<ReviewVO> rList = reviewDao.selectAllReview(storeVo.getStoreNum());
								
								for(ReviewVO vo : rList){
							%>
							<li class="list">
								<div class="user">
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
								<%
								if(vo.getUserNum() == mvo.getUserNum()){
								%>
								<div id="log">
	                                <input class="btn" type="button" value="수정하기" onclick="updateReview(<%=vo.getReviewNum()%>);"><br>
	                                <a href="reviewDeleteOk.jsp?reviewNum=<%=vo.getReviewNum()%>&storeNum=<%=storeVo.getStoreNum()%>"><input class="btn" type="button" value="삭제하기"></a>
	                            </div>
	                            <%} %>
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