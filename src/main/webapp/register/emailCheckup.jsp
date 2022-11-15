<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String result = "";
	if(email != null){
		OmealMemberDAO dao = new OmealMemberDAO();
		
		result = dao.isExistsEmail(email);	
		dao.close();
	}else{
		result = "false";
	}
	out.println("email:"+result);
%>