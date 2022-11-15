<%@page import="vo.StoreInfoVO"%>
<%@page import="dao.StoreInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	$("#search").on('click', function(){
		new daum.Postcode({
			oncomplete : function(data) { // 팝업에서 검색결과를 클릭했을 때 실행내용
				$("input[name='addrs1']").val(data.address);
			
			var d = data.sigungu;
			
			if(d == '중구') {
				$("input[name='district']").val(d);
			} else {
				d = d.substr(0, d.length - 1);
				$("input[name='district']").val(d);
			}
				$("input[name='simpleaddrs']").val(data.bname);
			}
		}).open();
	});
	
	$("#submitform").on('click', function(){
 		if($("input[name='storeName']").val() == ''){
			alert("상호명을 입력해주세요");
			$("input[name='storeName']").focus();
			return
		} else if ($("input[name='addrs1']").val() == ''){
			alert("주소를 입력해주세요");
			$("input[name='addrs2']").focus();
			return
		} else if ($("input[name='tel']").val() == ''){
			alert("가게 전화번호를 입력해주세요");
			$("input[name='tel']").focus();
			return
		} else if ($("select[name='category'] option:selected").val() == '-------'){
			alert("업종을 선택해주세요");
			return 
		} else if ($("input[name='storeMenu']").val() == ''){
			alert("주 메뉴를 입력해주세요");
			$("input[name='storeMenu']").focus();
			return 
		} else if ($("select[name='opentime'] option:selected").val() == '-------'){
			alert("시작시간을 선택해주세요");
			return 
		} else if ($("select[name='closetime'] option:selected").val() == '-------'){
			alert("시작시간을 선택해주세요");
			return 
		} else if ($("input[type='file']").val() == ''){
			alert("가게 이미지를 선택해주세요");
			return 
		}
 		
 		$("#frm").submit();
 		
	});
	
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var t = e.target.result;
            $("label[for='imgfile']").css('background-image', 'url(' + t + ')').css('background-size', '100% 100%');
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";
    }
}

</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@700&family=Poppins:wght@300;500&display=swap');
* {
	margin: 0px;
	padding: 0px;
}

html, body {
	margin: 0px;
	padding: 0px
}

#container {
	margin: 0px auto;
	width: 100%;
}

.top {
	width: 100%;
	height: 60px;
	background-color: #003049;
	margin-bottom: 40px;
}

.top>img {
	width: 45px;
	height: 45px;
	margin-top: 8px;
	margin-left: 15px;
}

.top>p {
	font-size: 15px;
	position: absolute;
	right: 22px;
	top: 16px;
	font-family: '고딕';
	font-weight: bolder;
	color: #FCBF49;
}
form>p{
	font-family: 'Inter';
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	align-items: center;
	color: #003049;
	margin-left:60px;
}
#edit{
	width:15px;
	height:15px;
	background-color: transparent;
    background-image: url('../images/editing.png');
	background-size: 100% 100%;
	border:none;
	margin-left: 20px;

}
.warn{
	font-family: 'Poppins';
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	line-height: 18px;
	letter-spacing: 0.03em;
	color: #003049;
	margin-bottom:30px;
}
.editform{
	width:600px;
	margin: 30px auto;
}
.editform  input, select {
	width:350px;
	height:40px;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 2px rgba(0, 0, 0, 0.25));
	outline-color: #FCBF49;
	border-radius: 12px;
	margin-bottom:10px;
	padding:0px 5px;
	font-family: 'Poppins';
	font-weight: 300;
	font-size: 14px;
	line-height: 21px;
	letter-spacing: 0.03em;
}
.editform h3  {
	font-family: 'Poppins';
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	letter-spacing: 0.03em;
	color: #003049;
}
.editform > input[type='button']{
	background-color: #F77F00;
    width: 120px;
    height: 40px;
    color: white;
    border: none;
    border-radius: 12px;
    margin-left: 15px;
    font-family: 'Poppins';
	font-weight: 500;
	font-size: 13px;
	line-height: 22px;
	text-align: center;
	letter-spacing: 0.03em;
}
.select{
	position:relative;
}
.file{
    position:absolute;
    top:-35px;
    right:40px;
    width:150px;
    height:150px;
    text-align: center;

}
.file>label {
	display:block;
    width: 100px;
    height: 100px;
    background-color: #EAE2B7;
    position: relative;
	margin: 5px auto;
    background-image: url('../images/add-image.png');
    background-size: 100px 100px;
    margin-top: 10px;
}

#submitform{
	background-color: #F77F00;
    width: 100px;
    height: 40px;
    color: white;
    border: none;
    border-radius: 12px;
    position:absolute;
    right:50px;
    bottom:50px;
    filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
    box-shadow: 0px 4px 4px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	font-family: 'Poppins';
	font-weight: 500;
	font-size: 13px;
	line-height: 22px;
	text-align: center;
	letter-spacing: 0.03em;
}
</style>
</head>
<body>

<div id="container">
		<div class="top">
			<img src="../logoimg/icon.png" alt="" />
			<p>가게정보 편집</p>
		</div>

		<form action="storeInfoInsertOk.jsp" id="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="storeNum"  /> 
		<div class="editform">
			<div id="storeName">
			<h3>상호명</h3>
			<input type="text" name="storeName" placeholder="상호명을 입력해주세요"/>
			</div>
			<h3>주소</h3>	
			<input type="text" name="addrs1" id="" placeholder="도로명 주소를 입력해주세요" readonly/>
			<input type="button" value="도로명주소" id="search" /><br>
			<input type="text" name="addrs2" id="" placeholder="상세 주소를 입력해주세요" />
			<input type="hidden" name="district" />
			<input type="hidden" name="simpleaddrs" />
			<h3>전화번호</h3>	
			<input type="text" name="tel" id="" placeholder="가게 전화번호를 입력해주세요" />
			<h3>업종</h3>	
			<select name="category" id="">
				<option value="-------" style="color:gray;">업종을 선택해주세요</option>
				<% String[] categoryname = {"한식", "일식", "중국식", "분식", "경양식", "뷔페식", "패밀리레스토랑", "호프/통닭", "정종/대포집/소주방", "기타"}; 
				
				for(int i=0; i<categoryname.length; i++){
					 %>
						<option value="<%=categoryname[i]%>"><%=categoryname[i]%></option>
					<%
				}
				%>
			</select>
			<h3>주메뉴</h3>	
			<input type="text" name="storeMenu" id="" placeholder="주 메뉴를 입력해주세요" />
			<h3>예약 가능 좌석</h3>	
			<input type="text" name="acceptRez" id="" placeholder="예약가능한 좌석을 입력해주세요" />
			<div class="select">
			<h3>영업시간</h3>
			<select name="opentime" id="">
				<option value="-------">시작 시간</option>
				<%
				for(int i=0; i<48; i++){
					if(i%2 == 0){ %>
							<option value="<%=i/2%>:00"><%=i/2%>:00</option>
						<%
					} else{ 
						%>
							<option value="<%=i/2%>:30"><%=i/2%>:30</option>
						<%
					} 
				} // for문 종료
				%>
			</select>
			<select name="closetime" id="">
				<option value="-------">마감 시간</option>
				<%
				for(int i=0; i<48; i++){
					if(i%2 == 0){ 
						%>
							<option value="<%=i/2%>:00"><%=i/2%>:00</option>
						<%
					} else{ 
						%>
							<option value="<%=i/2%>:30"><%=i/2%>:30</option>
						<%
					} 
				} // for문 종료%>

			</select>
			<div class="file">
				<h3>가게이미지</h3>
				<input type="file" name="img" id="imgfile" style="display:none;" onchange="readURL(this);"/>
				<label for="imgfile"></label>
			</div>
			</div>
		</div>
			<input id="submitform" type="button" value="정보 수정" />
		</form>
	</div>
</body>
</html>