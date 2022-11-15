<%@page import="vo.ReviewImgVO"%>
<%@page import="dao.ReviewImgDAO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String dir = application.getRealPath("/reviewimg");
	int maxSize = 1024 * 1024 * 10;
	String encoding = "UTF-8";

	MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, new DefaultFileRenamePolicy());

	// 리뷰이미지의 등록번호와 상태를 구하기 위한 배열
	String[] imgNum = { mr.getParameter("imgNum1"), mr.getParameter("imgNum2"), mr.getParameter("imgNum3") };
	String[] status = { mr.getParameter("status1"), mr.getParameter("status2"), mr.getParameter("status3") };

	int[] img = new int[3];
	for (int i = 0; i < 3; i++) {
		if (imgNum[i] != null) {
			img[i] = Integer.parseInt(imgNum[i]);
		}
	}

	String star = mr.getParameter("reviewStar");
	String rNum = mr.getParameter("rNum");
	String comment = mr.getParameter("comment");

	int point = 0;
	int reviewNum = 0;
	if (star != null || rNum != null) {
		point = Integer.parseInt(star);
		reviewNum = Integer.parseInt(rNum);
	}

	ReviewDAO rdao = new ReviewDAO();
	ReviewVO rvo = new ReviewVO();

	rvo.setPoint(point);
	rvo.setReviewComment(comment);
	rvo.setReviewNum(reviewNum);

	rdao.updateReview(rvo);

	Enumeration files = mr.getFileNames();

	String item = null;
	String reName = null;

	int idx = 2;

	ReviewImgDAO idao = new ReviewImgDAO();
	while (files.hasMoreElements()) {

		item = (String) files.nextElement();
		reName = mr.getOriginalFileName(item);

		ReviewImgVO ivo = new ReviewImgVO(img[idx], reviewNum, "../reviewimg/" + reName);

		out.println(img[idx] + "status : " + status[idx]);
		out.println("이미지번호" + img[idx] + " : " + reName);

		if (status[idx].equals("delete")) {
			out.println("이미지번호" + img[idx] + "삭제완료" + "<br>");
			idao.deleteImg(img[idx]);
		} else if (status[idx].equals("upload") && img[idx] == 0) {
			out.println(reName + "추가 완료" + "<br>");
			idao.insertReviewImg(ivo);
		} else if (status[idx].equals("upload") && img[idx] != 0) {
			out.println("이미지번호" + img[idx] + "변경 완료" + "<br>");
			idao.updateImg(ivo);
		} else {
			out.println("이미지번호" + img[idx] + "유지 완료" + "<br>");
		}

		idx--;
	}
	%>
</body>
<script>
opener.parent.location.reload();
window.close();
</script>
</html>