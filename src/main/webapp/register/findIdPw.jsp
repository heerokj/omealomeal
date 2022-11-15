<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<style>
@import 
	url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
	*{
		margin: 0px;
		padding: 0px;
	}
	#container{
		max-width : 1440px;
		margin : auto;		
		font-family: 'Poppins', sans-serif;
	}
</style>
</head>
<body>
	<%
		String find = "";
		Object obj = request.getParameter("find");
		if(obj == null){
			find = "findId.jsp";
		}else{
			find = (String)obj+".jsp";
		}
	
	%>

	<div id="container">
		<jsp:include page="idpwHeader.jsp"></jsp:include>
		<jsp:include page="<%= find %>"></jsp:include>
		<jsp:include page="../layout/footer.jsp"></jsp:include>		
	</div>
</body>
</html>