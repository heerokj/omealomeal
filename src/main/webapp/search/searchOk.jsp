<%@page import="vo.MemberVO"%>
<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
StoreInfoDAO storeDao = new StoreInfoDAO();

/* 페이징처리 */
String cp = request.getParameter("paging");

int currentPage = 0;
if(cp != null && !cp.equals("")){
currentPage = Integer.parseInt(cp);
}else {
currentPage = 1;
}

int recordPerPage = 12; //한페이지당 게시물건수
int startNo = (currentPage-1)*recordPerPage; //게시물시작번호
int endNo = currentPage*recordPerPage; //게시물끝번호

/* 정렬 */
String order = request.getParameter("order");

if (order == null){
	order = "HITS";
}

/* 검색 */
String search = request.getParameter("search");
String[] category = request.getParameterValues("category");
String[] local = request.getParameterValues("district");
String[] localArray = null;
ArrayList<String> district = new ArrayList<String>();
if (local != null) {
	for (int i = 0; i < local.length; i++) {
		localArray = local[i].split(" ");
		for (String x : localArray) {
	district.add(x);
		}
	}
}

StoreInfoVO storeVo = null;
ArrayList<StoreInfoVO> storeList = null;

int totalCount = 0;

/* search기능을 수행할 때 필터링 여부 체크 후 각각 다른 메소드 실행 */
if (search != null && local == null && category == null) {
	storeList = storeDao.select(search, order, startNo);
	totalCount = storeDao.totalSelect(search, order);
} else if (search != null && local != null && category == null) {
	storeList = storeDao.searchDistrict(search, district, order, startNo);
	totalCount = storeDao.totalSearchDistrict(search, district, order);
} else if (search != null && local == null && category != null) {
	storeList = storeDao.searchCategory(search, category, order, startNo);
	totalCount = storeDao.totalSearchCategory(search, category, order);
} else if (search != null && local != null && category != null) {
	storeList = storeDao.searchFilter(search, district, category, order, startNo);
	totalCount = storeDao.totalSearchFilter(search, district, category, order);
}

Object objGrade = session.getAttribute("vo");
MemberVO mvo = new MemberVO();
if(objGrade != null){
	mvo = (MemberVO) objGrade;
}

int totalPage = (totalCount%recordPerPage == 0)? totalCount/recordPerPage : totalCount/recordPerPage+1; //총페이지수

int startPage = 1; //시작페이지번호
int endPage = totalPage; //끝 페이지 번호
//시작 페이지 미세조정
if(currentPage <= 5){
startPage = 1;
}else if(currentPage >= 6){
startPage = currentPage-4;
}
//끝페이지 미세조정
if(totalPage - currentPage <= 5 ){
endPage = totalPage;
}else if(totalPage - currentPage > 5 ){
if(currentPage <= 5){
	if(totalPage > 10){
		endPage = 10;
	}else {
		endPage = totalPage;
	}
}else{
	endPage = currentPage+4;
}
}

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>omealomeal</title>  
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17a5f66b5867bd94f74847d7f1683ca7&libraries=services,clusterer,drawing"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	
/* ---------------- 지도 구현하기 -----------------*/
//지도를 띄우는 코드
$(function(){
    var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var mapOptions = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표
        level: 7 //지도의 레벨(확대, 축소 정도)
    };
    var map = new kakao.maps.Map(mapContainer, mapOptions); //지도 생성 및 객체 리턴
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	<% if(storeList != null){
		int idex = 0;
		if(storeList.size() > 20){
			idex = 20;
		} else {
			idex = storeList.size();
		}
	
	for (int i = 0; i < idex ; i++) { %>
	
	geocoder.addressSearch('<%=storeList.get(i).getAddrs()%>',
			function(result, status) {
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker(
							{
								map : map,
								position : coords,
							});
					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow(
							{
								content : '<div style="width:300px;text-align:center;padding:6px 3px;padding-bottom:10px;">'+
											'<span style="color:navy;font-weight:bold;"><%=storeList.get(i).getStoreName()%></span>'+
											'<span style="color:grey;">  <%=storeList.get(i).getCategory()%></span>'+
											'<p style="font-size:12px;text-align:left;margin-top:3px;"><%=storeList.get(i).getAddrs()%></p></div>'
						});
					// 마커에 마우스오버 이벤트를 등록합니다
					kakao.maps.event.addListener(marker, 'mouseover', function() {
					  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
					    infowindow.open(map, marker);
					});
					// 마커에 마우스아웃 이벤트를 등록합니다
					kakao.maps.event.addListener(marker, 'mouseout', function() {
					    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
					    infowindow.close();
					});
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
			}
		});		
	<%}	
	}%>
});
	
	
/* 검색창 실행 */
window.onload = function(){
	var search = document.getElementById("search");
	search.onclick = function(){
		frm.submit();
	}
}
/* 가게 버튼 클릭 시 */
function storePlus(){
	var popupWidth = 800;
	var popupHeight = 900;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	var url = "../admin/adminInsertForm.jsp";
	var name = "adminInsertForm";
	var option = "width = 800px, height = 900px, top = "+popupY+", left = "+popupX+", resizable=no, location = no";
	
	window.open(url, name, option);
}

	
/* 정렬 */ 
$(function(){
	$("#select_value").on('change', function(){
		$("form").submit();
	})
})


/* 페이징 처리 */	
function number(i){
	console.log(i);
	$("#numberPg").val(i);
	$('form').submit();
}
</script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap')
	;
   *{
        margin:0px;
        padding:0px;
    }
    
    #container{
        width: 1440px;
        margin: auto;
    }
    
     /* 헤더영역(임시) include로 배치예정 */
    #header{
        margin: 0 auto;
        height: 360px;
        background-color: #D9D9D9;
    }
    
    #sort{
        margin: 0 auto;
        height: 106px; 
        position:relative;   
    }
   
	/* 정렬버튼 */
    #select_value {
    width: 113px;
    height: 41px;
    border-radius: 12px;
    padding-left:16px;
    position: relative;
    left: 1276px;
    top:80px;
    }
      
    /* 가게등록버튼 */
     #plusbtn>input{
    	width: 111px;
        height: 41px;
        border-radius: 10px;
        background-color:#EAE2B7;
        border-color:#EAE2B7;
        box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 10px 0 rgba(0,0,0,0.19);
        position:absolute; 
        top:80px;
        left:490px;
        
       
    }
    
    /* 왼쪽영역 */
    #left{
        width: 428px;
        margin: 0;
        margin-top:50px;
        float: left;
    }
    
    /* 오른쪽영역 */
    #right{
        width: 912px;
        float: right;
        margin-top:50px;
        margin-right:50px;
        margin-left:50px;
    }
 
 	/* 페이지네이션 */
    #page{
    clear:both;
    width:100%;    
	text-align:center;
    }
    #pagination{
    list-style:none;
    display:inline-block;
    padding:50px 0px;
    margin-left:400px;
    
    }
    #pagination>li{
    display:inline;
    text-align:center;
    }
    #pagination>li>a{
    float:left;
    display:block;
    width:30px;
	height: 40px;
    font-size:30px;
    text-decoration:none;
    margin:0px 5px;
    padding: 5px 5px;
    /* border: solid #D9D9D9;
	border-width: 1px; */
    color:#003049;
    }
    #num:hover{
    /* border: solid #D9D9D9;
	border-width: 1px; */
	width:30px;
	height: 40px;
	/* border-radius:50%; */
    background-color:#F77F00;
    color:#FFFFFF;
    }
     #pagination>li>a>img{
    margin-left:10px;
    margin-bottom:2px;
    width:20px;
	height: 20px;
    }
 
    /* 아래영역(임시) include로 배치예정 */
    #footer{
        clear: both;
        height: 259px;
        background-color: #D9D9D9;
    }
    
    /* 지도 */
    #map{
        width:428px;
        height: 399px;
    }
    
    /* 필터버튼 */
    #fitter{
        width: 111px;
        height: 41px;
        background-color: #F77F00;
        box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 10px 0 rgba(0,0,0,0.19);
        border-radius: 10px;
        border: #F77F00;
        color: #FFFFFF;
        position: relative;
        left: 150px;
    }
    
    /* 필터버튼에 마우스 올렸을떄 */
     #fitter:hover{
    	background: #003049; 
		color: white;
    }
    
    /* 필터(지역) */
    #area{
        height: 370px;
        margin-top: 47px;
    }
    #sectors{
        height: 450px;
    }
    table{
        padding-left: 30px;
    }
    td{
        padding: 5px;
        font-size: 20px;
    }
    input[type="checkbox"]{
        width: 1.5rem;
        height: 1.5rem;
    }
    input, progress {
    accent-color: #F77F00;
    }
    
    .ch2>td{
        padding: 3px;
        font-size: 20px;
    }
    
    th{
        text-align: left;
        padding: 10px;
    }
    
    .wrap{
    	width:285px;
    	height:300px;
    	float:left;
    	margin:0px 9px 50px 9px;
    }
    
    /* 식당이미지 */
    .wrap>a>img{
        width: 285px;
        height: 205px;
    }
    
    /* 조회수,리뷰 색 */
    .hits{
        color: #aaaaaa; 
		font-size: 1.2em;
		position: relative;
		top:-20px;
        
    }
    
    /* 눈, 팬이미지 */
    #eye, #pen{
        width: 20px;
        height: 14px;
        margin-right:5px;
    } 
    
    /*  별이미지 */
    #star{
   		width: 28px;
        height: 28px;
    }
      
    h1{
    color:#003949;
    }
</style>
</head>
<body>
	
<div id="container">

	<form action="searchOk.jsp" name="frm">

       <!--------------------- head부분 --------------------->
        <div id="header">
			<jsp:include page="../layout/header.jsp"></jsp:include> 
		    <jsp:include page="../layout/searchBar.jsp"></jsp:include> 
	     </div>

       <!--------------------- 정렬버튼 --------------------->
                <div id = "sort">
                <%
                if (mvo.getGrade() == 1){
                %>
                <span id="plusbtn"><input type="button" value="가게등록" onclick="storePlus();"></span>
                <%}
                
                String[] orderName1 = {"AVGSTAR", "HITS", "REVIEW"};
                String[] orderName2 = {"별점순", "조회순", "리뷰갯수순"};
                %>
                    <select name="order" id="select_value">
                    
                  <%  for(int i=0 ; i< 3; i++){
                    	if(order.equals(orderName1[i])){%>
                        <option value="<%=orderName1[i]%>" selected><%=orderName2[i] %></option>
                    	<%} else {%>
                        <option value="<%=orderName1[i]%>"><%=orderName2[i] %></option>
                    	<%}
                    }%> 
                    </select>
                </div>

       <!--------------------- left영역 --------------------->
            <div id="left">
             <!------------ 지도표현 ---------->
                <div id="map"></div>
                
             <!------------ 필터표현 ---------->

                    <div id="area"> <!-- 체크박스(지역) -->
                        <table>
                            <tr>
                                <th><h1>지역</h1></th>
                                <td><input type="submit" value="필터적용" id="fitter">
                                </td>
                            </tr>
                            <%
                            String[] districtName1 = {"종로/중구/용산", "서초/강남/송파/강동", "성북/강북/노원/도봉", "동대문/중랑/성동/광진", "은평/서대문/마포", 
                            																					"강서/양천/구로", "영등포/동작/관악/금천"};
                            String[] districtName2 = {"종로 중구 용산", "서초 강남 송파 강동", "성북 강북 노원 도봉", "동대문 중랑 성동 광진", "은평 서대문 마포", 
                            																					"강서 양천 구로", "영등포 동작 관악 금천"};
                            if (local != null){
                            outer:
                                for (int i=0; i < districtName2.length; i++){
                                	for(String x : local){
                                		if(districtName2[i].equals(x)){ %>
                                			<tr class="ch2">
                                    			<td colspan="2"><input type="checkbox" name="district" id="" value="<%=districtName2[i]%>" checked><%=districtName1[i]%></td>
                              				</tr>
                                	<%	
                                			continue outer;
                                		}
                                	}
                                	
                                	%>
                                	<tr class="ch2">
                                    	<td colspan="2"><input type="checkbox" name="district" id="" value="<%=districtName2[i]%>"><%=districtName1[i]%></td>
                              		</tr>
                                	<%
                                }
                            } else {
                            	for (int i=0; i< districtName2.length; i++){%>
                            		<tr class="ch2">
                                    	<td colspan="2"><input type="checkbox" name="district" id="" value="<%=districtName2[i]%>"><%=districtName1[i]%></td>
                              		</tr>
                            	<%}
                            }
                            %>
                        </table>
                    </div> <!-- 체크박스 지역영역 end -->

                    <div id="sectors"> <!-- 체크박스(업종) -->
                            <table>
                                <tr>
                                    <th><h1>업종</h1></th>
                                </tr>
                                <%
                                String[] categoryname = {"한식", "일식", "중국식", "분식", "경양식", "뷔페식", "패밀리레스토랑", "호프/통닭", "정종/대포집/소주방", "기타"};
                                
                                if(category != null){
                                outer:
                                for (int i=0; i < 10; i++){
                                	for(String x : category){
                                		if(categoryname[i].equals(x)){ %>
                                			<tr class="ch2">
                                    			<td colspan="2"><input type="checkbox" name="category" id="" value="<%=categoryname[i]%>" checked><%=categoryname[i]%></td>
                              				</tr>
                                	<%	
                                			continue outer;
                                		}
                                	}
                                	
                                	%>
                                	<tr class="ch2">
                                    	<td colspan="2"><input type="checkbox" name="category" id="" value="<%=categoryname[i]%>"><%=categoryname[i]%></td>
                              		</tr>
                                	<%
                                	}
                                } else {
                                	for (int i=0; i<10; i++){%>
                                		<tr class="ch2">
                                    		<td colspan="2"><input type="checkbox" name="category" id="" value="<%=categoryname[i]%>"><%=categoryname[i]%></td>
                              			</tr>
                                	<%}
                                }
                                %>
                            </table>
                            
                      </div>  <!-- 체크박스 업종영역 end -->
                      
			 </div> <!-- left영역 end -->

    
	
		<!--------------------- 오른쪽(상점 이미지)구현 --------------------->

		<div id="right">
			
		<%ReviewDAO dao1 = new ReviewDAO();
		 	for(StoreInfoVO vo : storeList){ 
		%>	
				
			     <div class="wrap">
            	
	             <!-- 가게이미지 -->
					<%if (mvo.getGrade() == 0){ %>
						<a href="../member/storeInfo.jsp?storeNum=<%=vo.getStoreNum()%>"><img src="<%=vo.getStoreImage() %>" alt="<%=vo.getStoreName()%>"></a>
					<%} else{ %>
						<a href="../admin/adminStoreInfo.jsp?storeNum=<%=vo.getStoreNum()%>"><img src="<%=vo.getStoreImage() %>" alt="<%=vo.getStoreName()%>"></a>
					<%} %>
				 <!-- 가게명 -->
		          	<span style = " font-size:1.2em; font-weight: bold;"><%= vo.getStoreName() %></span>
		         <!-- 별이미지&평점 -->	
			        <img src="../images/star.png" alt="star" id="star"><%= dao1.averagePoint(vo.getStoreNum()) %><br>
			     <!-- 지역-업종 -->
			        <div style= "padding:10px 0;"><%=vo.getDistrict() %>-<%=vo.getCategory()%></div><br>
			     <!-- 조회수 -->
			        <div class="hits"><img src="../images/eye-alt.png" alt="eye" id="eye"><%=vo.getHits() %>
			     <!-- 리뷰수 -->
					<img src="../images/pen.png" alt="pen" id="pen"><%=dao1.countReview(vo.getStoreNum())%></div>
              	
       	  	  </div> <!-- wrap end --> 

				
					
		<%
			}
				
		%>
        </div> <!--right영역 end  -->
						 
				 <div id="page">
						<ul id="pagination">
							<li><a href="#" onclick="number(1)"><img src="../etcimg/page_pprev.png" alt="처음페이지" /></a></li>
							<%
								for(int i = startPage; i<=endPage; i++){
							%>								
								<li><a href="#" onclick="number(<%=i %>)" id="num"><%=i %></a></li>
							<%	
								}
							%>
							<li><a href="#" onclick="number(<%=endPage%>)"><img src="../etcimg/page_nnext.png" alt="마지막페이지" /></a></li>
						</ul>
				</div>

        <input type="hidden" name="paging" id="numberPg" value=""/>

   	</form> <!-- 전체 form end -->
      <!------------------------ foot부분 ------------------------>
        <div id="footer">
            <jsp:include page="../layout/footer.jsp"></jsp:include>
        </div>
    </div> <!-- container영역 end -->
</body>
</html>