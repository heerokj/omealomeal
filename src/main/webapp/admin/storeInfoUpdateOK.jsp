<%@page import="dao.StoreInfoDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

	String dir = application.getRealPath("/storeimg");
	int maxSize = 1024 * 1024 * 10;
	String encoding = "UTF-8";

	MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, new DefaultFileRenamePolicy());
	
	String store = mr.getParameter("storeNum");
	int storeNum = 0;
	if(store != null){
		storeNum = Integer.parseInt(store);
	}
	String storeName = mr.getParameter("storeName");
	String addrs1 = mr.getParameter("addrs1");
	String addrs2 = mr.getParameter("addrs2");
	String district = mr.getParameter("district");
	String simpleAddrs = mr.getParameter("simpleaddrs");
	String tel = mr.getParameter("tel");
	String category = mr.getParameter("category");
	String storeMenu = mr.getParameter("storeMenu");
	String opentime = mr.getParameter("opentime");
	String closetime = mr.getParameter("closetime");
	String img = mr.getParameter("img");
	String accept = mr.getParameter("acceptRez");
	int acceptRez = 0;
	
	if(accept != null){
		acceptRez = Integer.parseInt(accept);
	}
	
	Enumeration files = mr.getFileNames();

	String item = null;
	String reName = null;
	String storeImg = null;

	while (files.hasMoreElements()) {

		item = (String) files.nextElement();
		reName = mr.getOriginalFileName(item);
		
		if(reName == null){
			storeImg = img;
		} else {
			storeImg = "../storeimg/"+reName;
		}
		
		StoreInfoVO vo = new StoreInfoVO();
		
		vo.setStoreNum(storeNum);
		vo.setStoreName(storeName);
		vo.setAddrs(addrs1+" "+addrs2);
		vo.setDistrict(district);
		vo.setSimpleAddrs(simpleAddrs);
		vo.setTel(tel);
		vo.setCategory(category);
		vo.setStoreMenu(storeMenu);
		vo.setOpentime(opentime);
		vo.setClosetime(closetime);
		vo.setStoreImage(storeImg);
		vo.setAcceptRez(acceptRez);
		
		StoreInfoDAO storeDao = new StoreInfoDAO();
		storeDao.updateStore(vo);
	}
	%>
</body>
<script>
opener.parent.location.reload();
window.close();
</script>
</html>