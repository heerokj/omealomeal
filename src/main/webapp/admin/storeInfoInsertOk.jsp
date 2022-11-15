<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String dir = application.getRealPath("/storeimg");
int maxSize = 1024 * 1024 * 10;
String encoding = "UTF-8";

MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, new DefaultFileRenamePolicy());

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

if(accept != null && !accept.equals("")){
	acceptRez = Integer.parseInt(accept);
}

Enumeration files = mr.getFileNames();

String item = null;
String reName = null;
String storeImg = null;

while (files.hasMoreElements()) {

	item = (String) files.nextElement();
	reName = mr.getOriginalFileName(item);
	
	if(reName != null){
		storeImg = "../storeimg/"+reName;
	}
	
	StoreInfoVO vo = new StoreInfoVO();
	
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
	storeDao.insertOne(vo);
}
%>
<script>
opener.parent.location.reload();
window.close();
</script>
