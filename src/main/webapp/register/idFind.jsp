<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String result = "";
	if(name != null && email != null){
		OmealMemberDAO dao = new OmealMemberDAO();
		
		result = dao.findId(name, email);
	}
	out.println(result);
%>