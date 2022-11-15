<%@page import="vo.OmealMemberVO"%>
<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int user_num = Integer.parseInt(request.getParameter("user_num"));

 	OmealMemberDAO dao = new OmealMemberDAO();

	dao.deleteOne(user_num);

	out.println(user_num);
	
	response.sendRedirect("../login/logoutOk");
	
%>