<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
</head>
<body>
	<%	
		request.setCharacterEncoding("UTF-8");
	
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		out.println(id);
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.isExists(id, pw);
		
		if(vo == null){
			// 로그인 실패
			session.setAttribute("errMsg", "아이디 혹은 비밀번호가 일치하지 않습니다.");
			response.sendRedirect("login.jsp");
	
		}else{
			// 로그인 성공
			session.setAttribute("vo", vo);
			response.sendRedirect("../layout/main.jsp");
		} 
		dao.close();
	%>
</body>
</html>