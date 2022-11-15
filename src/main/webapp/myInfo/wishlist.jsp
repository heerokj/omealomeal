<%@page import="dao.ReviewDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.StoreInfoDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberVO mvo = new MemberVO();
Object obj = session.getAttribute("vo");

if(obj != null){
	mvo = (MemberVO)obj;
}

StoreInfoDAO storeDAO = new StoreInfoDAO();
ArrayList<StoreInfoVO> storeList = storeDAO.findWish(mvo.getUserNum());

%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<title>Swiper</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script>
function loc(store){
	window.location = "../member/storeInfo.jsp?storeNum="+store;
}
</script>
<!-- Link Swiper's CSS -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />

<!-- Demo styles -->
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap')
	;

html, body {
	position: relative;
}

body {
	background: #ffffff;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	color: #003049;
}

@media ( max-width : 1187px) {
	.swiper-button-next {
		right: 20px;
		transform: rotate(90deg);
	}
	.swiper-button-prev {
		left: 20px;
		transform: rotate(90deg);
		color: #F77F00;
	}
}

.swiper {
	width: 100%;
	height: 100%;
	margin-left: 10px;
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

.wrap {
	width: 220px;
	height: 250px;
	float: left;
	margin: 30px 0px;
}

.wrap>img {
	width: 200px;
	height: 150px;
	margin: auto;
}

.wrap>table {
	font-weight: 600;
	font-size: 15px;
	line-height: 18px;
	width: 220px;
	border-collapse: collapse;
}

.rezbtn {
	width: 200px;
	height: 35px;
	background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	border: none;
	margin: 10px 0px;
	color: white;
}

.rezbtn:active {
	background: #e07604;
	border: 1px solid rgba(0, 0, 0, 0.5);
}

.district {
	font-weight: 500;
	font-size: 12px;
	line-height: 15px;
	text-align: left;
	padding-left : 10px;
}

.point {
	text-align: right;
	padding-right: 10px;
}
.storename{
	text-align: left;
	padding-left : 10px;
}
#nextStoreBtn {
	position: relative;
	top: 80px;
	right: 50px;
	width: 50px;
	height: 50px;
	padding-bottom: 5px;
	padding-left: 5px;
	border-radius: 50%;
	border: none;
	font-size: 30px;
	font-weight: 800;
	float: right;
	background: white;
	filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
}

#nextStoreBtn:active {
	border: 1px solid rgba(0, 0, 0, 0.5);
}
.swiper-button-next {
	color: #F77F00;
}

.swiper-button-prev {
	color: #F77F00;
}
#star{
	color: gold;
	font-size: 20px;
}
</style>
</head>

<body>
 <!-- Swiper -->
    <div class="swiper mySwiper">
      <div class="swiper-wrapper">
      			<%
			ReviewDAO dao = new ReviewDAO();
			for (int i = 0; i < storeList.size(); i++) {
				StoreInfoVO storevo = storeList.get(i);
				String storeName;
				if (storevo.getStoreName().length() > 10) {
					storeName = storevo.getStoreName().substring(1, 11) + "...";
				} else {
					storeName = storevo.getStoreName();
				}
				double avgPoint = dao.averagePoint(storeList.get(i).getStoreNum());
			%>
			<div class="swiper-slide">
				<div class="wrap">
					<img src="<%=storevo.getStoreImage()%>"
						alt="<%=storevo.getStoreName()%>" onclick="loc(<%=storevo.getStoreNum()%>);"/><br />
					<table>
						<tr>
							<td class="storename"><%=storeName%></td>
							<td class="point"><span id="star">★</span><%=avgPoint%></td>
						</tr>
						<tr>
							<td colspan="2" class="district"><%=storevo.getDistrict()%></td>
						</tr>
					</table>
				</div>
			</div>
			<%
			}
			%>
      
      </div>
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
    </div>

    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        spaceBetween: 30,
        slidesPerView : 5,
        initialSlide: 2,
        centeredSlides: true,
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        on: {
            activeIndexChange : function() {
              if (this.realIndex == 2) {
                this.allowSlidePrev = false;
              } else {
                this.allowSlidePrev = true;
              }
              
              if (this.realIndex == 7){
            	  this.allowSlideNext = false;
              } else{
	              this.allowSlideNext = true;
              }
            },
          }
      });

    </script>
</body>

</html>