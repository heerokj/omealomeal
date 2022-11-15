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
		margin: 0%;
	}
	.container {
		width: 1440px;
		margin: auto;
	}
	/* 카테고리 */
	.category {
		width: 1230px;
		height: 570px;
		position: relative;
		left: 128px;
	}
	#text {
		font-family: 'Inter';
		font-style: normal;
		font-weight: 700;
		font-size: 32px;
		color: #003049;
	}
	.categoryBtn>input {
		width: 200px;
		height: 200px;
	}
	.categoryBtn>input:focus {
    	border: none;
    	outline:none;
    }
	#btn1 {
		background: url( "../images/category1.png" ) no-repeat;
		position: relative;
		top: 40px;
		border: 1px solid #D0D0D0;
	}
	#btn2 {
		background: url( "../images/category2.png" ) no-repeat; 
 		position: relative;
		left: 46px;
		top: 40px;
		border: 1px solid #D0D0D0; 
	}
	#btn3 {
		background: url( "../images/category4.png" ) no-repeat;
		position: relative;
		left: 92px;
		top: 40px;
		border: 1px solid #D0D0D0;
	}
	
	#btn4 {
		background: url( "../images/category3.png" ) no-repeat;
		position: relative;
		left: 138px;
		top: 40px;
		border: 1px solid #D0D0D0;
	}
	#btn5 {
		background: url( "../images/category5.png" ) no-repeat; 
		position: relative;
		left: 184px;
		top: 40px;
		border: 1px solid #D0D0D0; 
	}
	#btn6 {
		background: url( "../images/category6.png" ) no-repeat; 
		position: relative;
		top: 80px;
		border: 1px solid #D0D0D0; 
	}
	#btn7 {
		background: url( "../images/category7.png" ) no-repeat; 
		position: relative;
		left: 46px;
		top: 80px;
		border: 1px solid #D0D0D0; 
	}
	#btn8 {
		background: url( "../images/category8.png" ) no-repeat; 
		position: relative;
		left: 92px;
		top: 80px;
		border: 1px solid #D0D0D0; 
	}
	#btn9 {
		background: url( "../images/category9.png" ) no-repeat; 
		position: relative;
		left: 138px;
		top: 80px;
		border: 1px solid #D0D0D0; 
	}
	#btn10 {
		background: url( "../images/category10.png" ) no-repeat; 
		position: relative;
		left: 184px;
		top: 80px;
		border: 1px solid #D0D0D0; 
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
 	$(function(){
		$(".categoryBtn>input").on('click', function(){

			var iden = $(this).attr('id');
			//console.log(iden);
			
			if(iden=='btn1'){
				window.location = "../search/search.jsp?category=한식";  
			}else if(iden=='btn2'){
				window.location = "../search/search.jsp?category=중국식";  
			}else if(iden=='btn3'){
				window.location = "../search/search.jsp?category=일식";  
			}else if(iden=='btn4'){
				window.location = "../search/search.jsp?category=분식";  
			}else if(iden=='btn5'){
				window.location = "../search/search.jsp?category=뷔페식";  
			}else if(iden=='btn6'){
				window.location = "../search/search.jsp?category=경양식";  
			}else if(iden=='btn7'){
				window.location = "../search/search.jsp?category=호프/통닭";  
			}else if(iden=='btn8'){
				window.location = "../search/search.jsp?category=패밀리레스토랑";  
			}else if(iden=='btn9'){
				window.location = "../search/search.jsp?category=정종/대포집/소주방";  
			}else if(iden=='btn10'){
				window.location = "../search/search.jsp?category=기타";  				
			}
			
		})
	}) 
	
</script>
</head>
<body>
 	<jsp:include page="header.jsp"></jsp:include><br>
 	<jsp:include page="searchBar.jsp"></jsp:include>
	<div class="container">
		<div class="category">
	 		<p id="text">종류별로 모아봤어요</p>
	 		<div class="categoryBtn">
	 			<input type="button" id="btn1">
	 			<input type="button" id="btn2"> 
	 			<input type="button" id="btn3">
	 			<input type="button" id="btn4">
	 			<input type="button" id="btn5"><br>
	 			<input type="button" id="btn6">
	 			<input type="button" id="btn7">
	 			<input type="button" id="btn8">
	 			<input type="button" id="btn9">
	 			<input type="button" id="btn10">
	 		</div>
		</div>	
		<jsp:include page="recommend.jsp"></jsp:include>	
	</div>
	<jsp:include page="footer.jsp"></jsp:include>	
</body>
</html>