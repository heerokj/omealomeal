<%@page import="vo.ReservationVO"%>
<%@page import="dao.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int user_num = Integer.parseInt(request.getParameter("user_num"));
	int people_num = Integer.parseInt(request.getParameter("people_num"));
	int store_num = Integer.parseInt(request.getParameter("store_num"));

	String rez_date = request.getParameter("rez_date");
	String time = request.getParameter("time");
	String memo = request.getParameter("memo");
	
	ReservationDAO dao = new ReservationDAO();
	ReservationVO vo = new ReservationVO(user_num, people_num, store_num, rez_date, time, memo);
	
	dao.insertReservation(vo);
	response.sendRedirect("/omealomeal/myInfo/myinfo.jsp");
%>