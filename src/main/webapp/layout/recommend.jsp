<%@page import="dao.StoreInfoDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script>
function loc(store){
	window.location = "../member/storeInfo.jsp?storeNum="+store;
}
</script>

<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<style>
@import 
url('https://fonts.googleapis.com/css2?family=Inter&display=swap');
* {
	margin: 0;
	padding: 0;
}

#recommend {
	width: 1230px;
	margin: 20px auto;
	position: relative;
	right: 5px;
}

#recommend>p {
	font-family: 'Inter';
	font-weight: 700;
	font-size: 32px;
	color: #003049;
	position: relative;
	left: 30px;
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
	margin: 32px 0px;
}

.wrap>img {
	width: 200px;
	height: 200px;
	margin: auto;
}

.wrap>table {
	font-weight: 600;
	font-size: 15px;
	line-height: 18px;
	width: 220px;
	border-collapse: collapse;
	position: relative;
	bottom: 10px;
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
	font-family: 'Inter';
	font-weight: 500;
	font-size: 12px;
	line-height: 15px;
	text-align: left;
	padding-left : 10px;
	padding-top : 5px;
}

.point {
	text-align: right;
	padding-right: 15px;
	font-family: 'Inter';
	font-weight: 600;
	font-size: 15px;
}
.storename{
	text-align: left;
	padding-left : 10px;
	font-family: 'Inter';
	font-weight: 600;
	font-size: 15px;
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
	color: #FFD700;
	font-size: 20px;
}
</style>
</head>
<body>

	<div id="recommend">
		<p>요즘 뜨는 맛집</p>

		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
			<%
			ReviewDAO dao = new ReviewDAO();
			StoreInfoDAO dao2 = new StoreInfoDAO();
			ArrayList<StoreInfoVO> list = dao.recommend();
			for (int i = 0; i < 10; i++) {
				StoreInfoVO storevo = dao2.selectOne(list.get(i).getStoreNum());
				String storeName;
				if (storevo.getStoreName().length() > 10) {
					storeName = storevo.getStoreName().substring(1, 11) + "...";
				} else {
					storeName = storevo.getStoreName();
				}
				double avgPoint = dao.averagePoint(list.get(i).getStoreNum());
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
<%-- 					<a
						href="../member/reservation.jsp?store_num=<%=list.get(i).getStoreNum()%>"><input
						type="button" value="예약하기" class="rezbtn" /></a> --%>
	
				</div>
			</div>
			<%
			}
			%>
			
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
	</div>
 <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        spaceBetween: 10,
        slidesPerView : 5,
        centeredSlides: true,
        initialSlide: 2,
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