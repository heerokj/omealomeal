<%@page import="dao.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rez_num = Integer.parseInt(request.getParameter("rezNum"));
	
	
	ReservationDAO rdao = new ReservationDAO();
	rdao.deleteRez(rez_num);
	
	response.sendRedirect("../myInfo/myinfo.jsp");
	
%>