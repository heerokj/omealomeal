<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String result = "";
	if(id != null){
		OmealMemberDAO dao = new OmealMemberDAO();
		
		result = dao.isExistsId(id);
		dao.close();
	}else{
		result = "false";
	}
	out.println("id:"+result);
%>