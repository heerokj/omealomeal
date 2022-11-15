<%@page import="vo.ReviewImgVO"%>
<%@page import="dao.ReviewImgDAO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="vo.MemberVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

Object obj = session.getAttribute("vo");
MemberVO mvo = (MemberVO) obj;

String dir = application.getRealPath("/reviewimg");
int maxSize = 1024 * 1024 * 10;
String encoding = "UTF-8";

MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, new DefaultFileRenamePolicy());

String storeNum = mr.getParameter("storeNum");
String reviewcomment = mr.getParameter("reviewcomment");
String reviewStar = mr.getParameter("reviewStar");

int userNum = mvo.getUserNum();
int store = Integer.parseInt(storeNum);
int star = Integer.parseInt(reviewStar);

ReviewDAO reviewDao = new ReviewDAO();
ReviewImgDAO reviewImgDao = new ReviewImgDAO();

ReviewVO  reviewVo = new ReviewVO();

reviewVo.setStoreNum(store);
reviewVo.setUserNum(userNum);
reviewVo.setPoint(star);
reviewVo.setReviewComment(reviewcomment);

reviewDao.insertReview(reviewVo);

int reviewNum = reviewDao.maxNum(userNum);

Enumeration files = mr.getFileNames();

String item = null;
String originName = null;
int idx = 1;

while (files.hasMoreElements()) {
	item = (String) files.nextElement();
	originName = mr.getOriginalFileName(item);
	if (originName != null) {
		ReviewImgVO reviewImgVo = new ReviewImgVO(0, reviewNum, "../reviewimg/"+originName);
		reviewImgDao.insertReviewImg(reviewImgVo);
		out.println("file"+idx+" : "+originName+"<br>");
		idx++;
	}

}
response.sendRedirect("storeInfo.jsp?storeNum="+store);
%>
