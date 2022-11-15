<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String nickname = request.getParameter("nickname");
	String result = "";
	if(nickname != null){
		OmealMemberDAO dao = new OmealMemberDAO();
		
		result = dao.isExistsNickname(nickname);	
		dao.close();
	}else{
		result = "false";
	}
	out.println("nickname:"+result);
%>