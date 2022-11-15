<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String question = request.getParameter("question");
	String answer = request.getParameter("answer");
	String result = "";
	if(id != null && question != null && answer != null){
		OmealMemberDAO dao = new OmealMemberDAO();
		
		result = dao.findPw(id, question, answer);	
	}
	out.println(result);
%>