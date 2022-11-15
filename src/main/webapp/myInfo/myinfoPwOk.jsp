<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.OmealMemberVO"%>
<%@page import="dao.OmealMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String dir = application.getRealPath("/etcimg");
	int maxSize = 1024 * 1024 * 10;
	String encoding = "UTF-8";

	MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, new DefaultFileRenamePolicy());

	int user_num = Integer.parseInt(mr.getParameter("user_num"));
	String user_pw = mr.getParameter("cpw");
	String userImg = mr.getParameter("user_img");
	String nickname = mr.getParameter("editNick");
	OmealMemberDAO dao = new OmealMemberDAO();
	OmealMemberVO vo = new OmealMemberVO(user_num, user_pw);
	OmealMemberVO ovo = new OmealMemberVO();
	
	Enumeration files = mr.getFileNames();

	String item = null;
	String reName = null;

	while (files.hasMoreElements()) {

		item = (String) files.nextElement();
		reName = mr.getOriginalFileName(item);
		
		if(reName != null){
			userImg = "../etcimg/"+reName;
		}
		
		ovo.setUser_num(user_num);
		ovo.setUser_pw(user_pw);
		ovo.setUser_image(userImg);
		ovo.setNickname(nickname);
		
	}
	
 	dao.updatePw(ovo);
	response.sendRedirect("myinfo.jsp");
	
	

%>