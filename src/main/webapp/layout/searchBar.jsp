<%@page import="java.util.ArrayList"%>
<%@page import="dao.StoreInfoDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchBar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var rnd = Math.floor(Math.random()*5);
		$(".searchBg>img").attr("src","../images/searchBg"+(rnd+1)+".jpg");
		
		$("#btnSearch").on('click', function(){
			var search = $("#searchBar").val();
			window.location = "../search/searchOk.jsp?search="+search;
		});
		
		$("#searchBar").keyup(function(e){
			if(e.keyCode == 13){
				//console.log("test");
				var search = $("#searchBar").val();
				window.location = "../search/searchOk.jsp?search="+search;
			}
		});
	})
</script>
<style>
    *{
        margin: 0%;
    }
    #sear {
        width: 1440px;
        margin: auto;
    }
    input:focus {
        outline: none;
    }
    /* 검색창 뒷배경 */
    .searchBg {
        width: 1440px;
        height: 400px;
        margin: auto;
    }
    .searchBg > img {
        width: 1440px;
        height: 400px;
        object-fit: cover;
    }
    /* 검색바 */
    .searchBar {
        width: 576px;
        height: 48px;
        position: relative;
        bottom: 220px;
        margin: auto;
    }
    /* 검색버튼 */
    #btnSearch {
       position: relative;
       left: 560px;
       bottom: 38px;
       background: url( "../images/magnify.png" ) no-repeat;
       border:none;
       width: 28px;
       height: 28px;
    }
    #btnSearch:focus {
    	border: none;
    	outline:none;
    }
    #searchBar {
        width: 576px;
        height: 48px;
        border-radius: 12px;
        border: 0;
        font-family: 'Roboto';
        font-weight: 400;
        font-size: 15px;
        padding: 0px 10px;
    }
    #searchBar:hover {
    	box-shadow: 0 5px 18px -7px rgba(0,0,0,1);
    }
    #searchBar:focus {
   		box-shadow: 0 5px 18px -7px rgba(0,0,0,1);
    }
</style>
</head>
<body>
<%
String search = request.getParameter("search");
if (search == null) search = "";
%>
		<!-- searchOk.jsp로 넘어감 -->
    <div id="sear">
        <div class="searchBg">
            <img src="" alt="searchimg" id="searchimg">
        </div>
        <div class="searchBar">
            <input type="text" name="search" placeholder="  가게명, 메뉴, 키워드로 검색하세요" id="searchBar" value="<%=search%>">
            <input type="image" src="../images/magnify.png" alt="btnSearch" id="btnSearch">
        </div>
    </div>
</body>
</html>