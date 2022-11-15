<%@page import="dao.OmealMemberDAO"%>
<%@page import="vo.OmealMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = request.getParameter("id");
	String user_pw = request.getParameter("pw");
	String user_name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String email = request.getParameter("email");
	String pw_q = request.getParameter("question");
	String pw_a = request.getParameter("answer");
	
	OmealMemberDAO dao = new OmealMemberDAO();
	OmealMemberVO vo = new OmealMemberVO(user_id, user_pw, user_name, nickname, email, pw_q, pw_a);
	
	dao.insertOne(vo);
	response.sendRedirect("../login/login.jsp");
%>
