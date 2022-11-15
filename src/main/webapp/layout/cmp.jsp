<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Inter&display=swap');
	*{
		magin: 0;
		padding: 0;
	}
	#header {
        height: 60px;
        background-color: #003049;
        font-family: 'Inter', sans-serif;
        margin: auto;
        text-align: right;
    }
    #icon {
        width: 45px;
        height: 45px;
        position: relative;
        top: 7px;
        left: 20px;
        float: left;
    }
    #main{
    	width: 700px;
    	height:660px;
    	margin: auto;
    	text-align: center;
    	padding : 20px;
    	font-family: 'Inter', sans-serif;
    }
    #closebtn{
    	width: 100px;
    	height: 40px;
		filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));

		background: #F77F00;
		box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
		border-radius: 12px;
		border: none;		
		font-family: 'Poppins';
		font-weight: 500;
		font-size: 15px;
		line-height: 22px;
		text-align: center;
		letter-spacing: 0.03em;
		
		color: #FFFFFF;
    }	
    #closebtn:hover {
		background: #de7403;
	}

	#btn{
		text-align: right;
		margin: 40px 0px;
		position: relative;
  		bottom: 150px;
	}
	#headertxt{
		position: relative;
		top: 20px;
		right: 15px;
		font-weight: 600;
		font-size: 15px;
		line-height: 18px;		
		color: #FCBF49;
  	}
  	#logo{
  		width: 600px;
  		position: relative;
  		bottom: 100px;
  	}
  	.txt{	
  		width : 560px;
		font-weight: 500;
		font-size: 15px;
		line-height: 22px;
		letter-spacing: 0.03em;
		margin: auto;
		position: relative;
  		bottom: 180px;
  	}
  	.txt> p {
  		text-align : left;
  	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
		$("#closebtn").on("click", function(){
			window.close();
		});
	});
</script>
</head>
<body>
	<div id="container">
		<div id="header">
			<a href="../layout/main.jsp"><img src="../logoimg/icon.png" alt="icon" id="icon"></a>
			<span id="headertxt">회사소개</span>
		</div>
	
		<div id="main">
			<div>
				<img src="../logoimg/logo.png" alt="omealLogo" id="logo"/>
			</div>
			<div class="txt">
				<p>오밀오밀은 2022년 5월 설립된 스타트업으로, '서울의 맛집을 소개하자!' 라는 목표아래 시작되었습니다.</p>
				<br />
				<p>기존 포털사이트의 지도로 맛집 정보를 얻을때 불편했던 점인 하위리뷰, 과장광고 그리고 오래된 정보, 이젠 '오밀오밀'과 함께 날려봐요!</p>
				<br />
				<p>오늘의 식사를 알차게, 맛있게 즐기실 수 있도록 오늘도 '오밀오밀'은 여러분의 선택을 기다립니다.</p>
			</div>
			
			<div id="btn">
				<input type="button" value="닫기" id="closebtn"/>
			</div>
		</div>
	</div>
</body>
</html>