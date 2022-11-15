<%@page import="vo.MemberVO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String num = request.getParameter("reviewNum");
int reviewNum = 0;

if(num != null){
	reviewNum = Integer.parseInt(num);
}

ReviewDAO dao = new ReviewDAO();
dao.deleteOne(reviewNum);

MemberVO mVo = new MemberVO();
Object obj = session.getAttribute("vo");
if(obj != null){
	mVo = (MemberVO) obj;
}
response.sendRedirect("myinfo.jsp");
%>