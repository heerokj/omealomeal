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
    	width: 800px;
    	height:840px;
    	margin: auto;
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
  	#accordion{
  		width: 800px;
  		height: 660px;
  		margin: 50px auto;
  		text-decoration: none;
  	}
  	#accordion .ui-accordion-header{
	  	background: #003049;
  		color: #FCBF49;
  		icon: null;
  	}
  	#accordion .ui-accordion-content {

  		/* width: 700px;
  		height: 220px;
  		background: #003049; */

  	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script>
	$(function(){
		$("#accordion" ).accordion();
		
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
			<span id="headertxt">공지사항</span>
		</div>
		<div id="main">
			<div id="accordion">
				<h3>[공지] 오밀오밀 공지안내</h3>
				<div>
					<p>
						공지사항입니다.
					</p>
				</div>
				<h3>[공지] 오밀오밀 시연안내</h3>
				<div>
					<p>
						2022년 06월 07일 시연예정입니다.
					</p>
				</div>	
				<h3>[공지] 휴일안내</h3>
				<div>
					<p>
						2022년 06월 06일 휴식안내입니다.
					</p>
				</div>
				<h3>[공지] 발표안내</h3>
				<div>
					<p>
						발표 예정일은 2022년 06월 07일 입니다.
					</p>
				</div>						
			</div>
			<div id="btn">
				<input type="button" value="닫기" id="closebtn"/>
			</div>
		</div>
	</div>
</body>
</html>