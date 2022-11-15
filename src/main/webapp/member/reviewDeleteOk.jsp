<%@page import="vo.MemberVO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String num = request.getParameter("reviewNum");
String snum = request.getParameter("storeNum");
int reviewNum = 0;
int storeNum = 0;

if(num != null){
	reviewNum = Integer.parseInt(num);
}
if(snum != null){
	storeNum = Integer.parseInt(snum);
}

ReviewDAO dao = new ReviewDAO();
dao.deleteOne(reviewNum);

MemberVO mVo = new MemberVO();
Object obj = session.getAttribute("vo");
if(obj != null){
	mVo = (MemberVO) obj;
}

if(mVo.getGrade() == 0){
response.sendRedirect("storeInfo.jsp?storeNum="+storeNum);
} else if (mVo.getGrade() == 1){
response.sendRedirect("../admin/adminStoreInfo.jsp?storeNum="+storeNum);
}
%>