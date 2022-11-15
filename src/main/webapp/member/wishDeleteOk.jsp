<%@page import="dao.WishListDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberVO mvo = null;
int userNum = 0;
int sNum = 0;
Object obj = session.getAttribute("vo");

if(obj != null){
mvo = (MemberVO) obj;
userNum = mvo.getUserNum();
}

String storeNum = request.getParameter("storeNum");
if(storeNum != null) {
	sNum = Integer.parseInt(storeNum);
}

WishListDAO wdao = new WishListDAO();

wdao.deleteWish(sNum, userNum);
response.sendRedirect("storeInfo.jsp?storeNum="+sNum);

%>