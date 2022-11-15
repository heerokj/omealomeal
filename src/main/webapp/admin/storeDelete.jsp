<%@page import="dao.StoreInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String store = request.getParameter("storeNum");
int storeNum = 0;
if(store != null){
	storeNum = Integer.parseInt(store);
}
StoreInfoDAO dao = new StoreInfoDAO();
dao.deleteOne(storeNum);

response.sendRedirect("../layout/main.jsp");
%>

