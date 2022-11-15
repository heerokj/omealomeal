<%@page import="vo.ReservationVO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ReservationDAO reservationDao = new ReservationDAO();

/* member_num 값 가져오기 위한 코드 */
Object objGrade = session.getAttribute("vo");
MemberVO mvo = new MemberVO();
if(objGrade != null){
	mvo = (MemberVO) objGrade;
}

/* storeNum 값 가져오기 위한 코드 */
String rezNum = request.getParameter("rezNum");
int rez = 0;
if(rezNum != null){
	rez = Integer.parseInt(rezNum);
}

ReservationVO rvo = reservationDao.selectOne(rez);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reservation</title>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap')
	;

#contain {
	position: relative;
	width: 1440px;
	height: 1800px;
	margin: 0 auto;
	background-color: #FFFFFF;
}

/* 상단 배경 */
#rezImg {
	position: absolute;
	width: 1440px;
	height: 300px;
	left: 0px;
	top: 60px;
	background: url(../storeimg/store_img317.jpg) no-repeat center;
	background-size: cover
}

/* 예약 진행 헤드 영역 */
legend {
	position: absolute;
	left: 47.36%;
	right: 43.54%;
	top: 22.28%;
	bottom: 74.94%;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	color: #003049;
}

/* 라벨 공통 */
label {
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	letter-spacing: 0.03em;
	color: #003049;
	position: absolute;
	left: 0%;
	right: 13.43%;
	top: 0%;
	bottom: 69.44%;
}

/* 인원 수 영역 위치 */
.headcount {
	position: absolute;
	width: 283px;
	height: 72px;
	left: 573px;
	top: 508px;
}

/* 날짜 영역 위치 */
.date {
	position: absolute;
	width: 283px;
	height: 72px;
	left: 573px;
	top: 616px;
}

/* 시간 영역 위치 */
.time {
	position: absolute;
	width: 283px;
	height: 72px;
	left: 573px;
	top: 724px;
}

/* 요청사항 영역 위치 */
.requests {
	position: absolute;
	width: 283px;
	height: 154px;
	left: 573px;
	top: 832px;
}

/* 예약 변경 및 취소 수수료 안내 위치 */
.rezterms {
	position: absolute;
	width: 283px;
	height: 200px;
	left: 573px;
	top: 1022px;
}

/* 동의 체크 영역 위치, 폰트 */
.rezcheckbox {
	position: absolute;
	width: 426px;
	height: 26px;
	left: 575px;
	top: 1282px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	letter-spacing: 0.03em;
	color: #003049;
}

.alert {
	position: absolute;
	width: 414px;
	height: 21px;
	left: 573px;
	top: 1338px;
}

/* 셀렉트박스 공통 */
.selectbox {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	padding: 8px;
	gap: 16px;
	position: absolute;
	left: 0%;
	right: -27.21%;
	top: 43.06%;
	bottom: 0%;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.08))
		drop-shadow(0px 1px 1px rgba(0, 0, 0, 0.12));
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	background: url(../etcimg/selectbox.png) no-repeat 97% 50%;
	border-radius: 12px;
	outline-color: #F77F00;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.datebox {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	padding: 8px;
	gap: 16px;
	position: absolute;
	left: 0%;
	right: -27.21%;
	top: 43.06%;
	bottom: 0%;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.08))
		drop-shadow(0px 1px 1px rgba(0, 0, 0, 0.12));
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	border-radius: 12px;
	outline-color: #F77F00;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

/* 요청사항 텍스트 입력 영역 */
.request_box {
	padding: 8px;
	resize: none;
	position: absolute;
	left: 0%;
	right: -26.86%;
	top: 19.48%;
	bottom: 0%;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.08))
		drop-shadow(0px 1px 1px rgba(0, 0, 0, 0.12));
	border-radius: 12px;
	outline-color: #F77F00;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
}

/* 약관 텍스트 영역 */
.rezterms_box {
	padding: 8px;
	resize: none;
	position: absolute;
	left: 0%;
	right: -26.86%;
	top: 16%;
	bottom: -19.5%;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.08))
		drop-shadow(0px 1px 1px rgba(0, 0, 0, 0.12));
	border-radius: 12px;
	outline-color: #F77F00;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
}

/* 붉은색 경고 문구 */
#warning {
	position: absolute;
	left: 5.8%;
	right: 16.67%;
	top: 0%;
	bottom: 0%;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 300;
	font-size: 14px;
	line-height: 21px;
	/* identical to box height */
	letter-spacing: 0.03em;
	color: #DB1E1E;
}

/* 예약하기 버튼 */
#rezok {
	position: absolute;
	width: 359px;
	height: 41.31px;
	left: 573px;
	top: 1389px;
	background: #F77F00;
	box-shadow: 0px 4px 10px rgba(233, 68, 75, 0.25);
	border-radius: 12px;
	border: 0;
	outline: 0;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 300;
	font-size: 15px;
	line-height: 21px;
	/* identical to box height */
	letter-spacing: 0.03em;
	color: #FFFFFF;
}

/* 커스텀 체크박스 시작 */
/* Customize the label (the container) */
.ckcontainer {
	display: inline-block;
	position: relative;
	padding-left: 35px;
	padding-right: 35px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 15px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* Hide the browser's default checkbox */
.ckcontainer input {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 0;
	height: 25px;
	width: 25px;
	background-color: #eee;
	border-radius: 7px;
}

/* On mouse-over, add a grey background color */
.ckcontainer:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a orange background */
.ckcontainer input:checked ~ .checkmark {
	background-color: #F77F00;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.ckcontainer input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.ckcontainer .checkmark:after {
	left: 9px;
	top: 5px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}
/* 커스텀 체크박스 종료 */
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/httpRequest.js"></script>
<script>
	var people;
	var date;
	var time;
	var memo;
	
	$(function(){
		$("#rezok").on("click", function(){
			if($("#selectbox1").val() == ""){
				alert("예약 인원을 선택해주세요.")
				$("#selectbox1").focus();
				return;
			}else if($("#datebox").val() == ""){
				alert("예약 날짜를 선택해주세요.")
				$("#datebox").focus();
				return;
			}else if($("#selectbox2").val() == ""){
				alert("예약 시간을 선택해주세요.")
				$("#selectbox2").focus();
				return;
			}else if(!$("#check1").prop("checked") || !$("#check2").prop("checked")){
				alert("모든 약관에 동의해주세요.")
				return;
			}
			document.frm.action = "rezUpdateOk.jsp";
			document.frm.method = "get";
			document.frm.submit();
		});
	})
	
</script>
	<jsp:include page="../layout/header.jsp" />
</head>
<body>
<div id="contain">
	<img id="rezImg">
	<legend>예약 진행</legend>
	<form action="" name="frm">
	<input type="hidden" name="user_num" value="<%=mvo.getUserNum() %>">
	<input type="hidden" name="store_num" value="<%=rvo.getStore_num() %>">
	<input type="hidden" name="rez_num" value="<%=rvo.getRez_num() %>">
	<div class="headcount">
		<label>인원 수</label> <select name="people_num" class="selectbox" id="selectbox1">
			<option value="">예약 인원을 선택해주세요.</option>
			<%for(int i=1; i<=8; i++){ 
				if(i == rvo.getPeople_num()){
			%>
				<option value="<%=i %>" selected><%=i %>명</option>
			<%} else { %>
				<option value="<%=i %>"><%=i %>명</option>
			<%}
				} %>
		</select>
	</div>
	<div class="date">
		<label>날짜</label> <input type="date" name="rez_date" class="datebox" id="datebox" value = "<%=rvo.getRez_date()%>"/>
	</div>
	<div class="time">
		<label>시간</label> <select name="time" class="selectbox" id="selectbox2">
			<option value="">예약시간을 선택해주세요.</option>
			<option value="11:00">11:00</option>
			<option value="11:30">11:30</option>
			<option value="12:00">12:00</option>
			<option value="12:30">12:30</option>
			<option value="13:30">13:00</option>
			<option value="13:30">13:30</option>
			<option value="14:00">14:00</option>
			<option value="14:30">14:30</option>
			<option value="15:00">15:00</option>
			<option value="15:30">15:30</option>
			<option value="16:00">16:00</option>
			<option value="16:30">16:30</option>
			<option value="17:00">17:00</option>
		</select>
	</div>
	<div class="requests">
		<label>요청사항</label>
		<textarea name="memo" class="request_box" placeholder="요청사항을 입력해주세요." id="req"> <%=rvo.getMemo()%></textarea>
	</div>
	<div class="rezterms">
		<label>예약 변경 및 취소 수수료 안내</label>
		<textarea readonly class="rezterms_box">
▶ 예약 변경 안내
- 날짜 변경 : 1일 전까지 가능
- 시간 변경 : 6시간 전까지 가능

▶ 취소 수수료 안내
- 1일 전 취소 : 취소 수수료 없음
- 12시간 전 취소 : 10% 취소수수료 발생
- 1시간 전 취소 : 환불 불가 </textarea>
	</div>
	<div class="rezcheckbox">
		<label class="ckcontainer">예약 변경 규정 동의 <input type="checkbox" name="terms" id="check1"><span
			class="checkmark"></span>
		</label> <label class="ckcontainer">환불 규정 동의 <input type="checkbox" name="terms" id="check2"><span
			class="checkmark"></span>
		</label>
	</div>
	<div class="alert">
		<div>
			<img src="../etcimg/alert.png" />
		</div>
		<div id="warning">인원수와 날짜 및 시간을 다시 한번 확인해주세요.</div>
	</div>
	<input type="button" value="예약하기" id="rezok" />
	</div>
	</form>
		<jsp:include page="../layout/footer.jsp" />
</body>
</html>