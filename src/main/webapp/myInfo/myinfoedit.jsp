<%@page import="dao.MemberDAO"%>
<%@page import="dao.OmealMemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* member_num 값 가져오기 위한 코드 */
Object objGrade = session.getAttribute("vo");
MemberVO mvo = new MemberVO();
if(objGrade != null){
	mvo = (MemberVO) objGrade;
}
MemberDAO dao = new MemberDAO();
MemberVO mvo2 = dao.isExistsNum(mvo.getUserNum());

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omealomeal</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap')
	;
#contain {
	position: relative;
	width: 1440px;
	height: 1300px;
	margin: 0 auto;
	background-color: #FFFFFF;
}
#nickname {
	position: absolute;
	width: 124px;
	height: 132px;
	left: 658px;
	top: 173px;
}
.file>label {
	display:block;
    width: 15px;
    height: 15px;
    background-color: #EAE2B7;
    position: absolute;
    width: 15px;
	height: 15px;
	left: 762px;
	top: 275px;
	margin: 5px auto;
    background-image: url('../etcimg/camera.png');
    background-size: 15px 15px;
    filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
    margin-top: 10px;
}
#nicklabel {
	position: relative;
	width: 130px;
	height: 55.56px;
	left: 665px;
	top: 305px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	display: flex;
	align-items: center;
	color: #003049;
}
#editNick {
	position: absolute;
	width: 15px;
	height: 15px;
	left: 790px;
	top: 312px;
}

#edit {
	position: absolute;
	width: 100px;
	height: 15px;
	left: 840px;
	top: 312px;
	
	width: 358.82px;
    height: 41.31px;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.25));
	border-radius: 12px;
	
	outline-color: #F77F00;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
}
#line1 {
	position: absolute;
	width: 1187px;
	height: 0px;
	left: 133px;
	top: 392px;
	border: 1px solid #737070;
}
#editlabel {
	position: absolute;
	width: 360px;
	height: 39px;
	left: 200px;
	top: 464px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 700;
	font-size: 32px;
	line-height: 39px;
	/* identical to box height */
	display: flex;
	align-items: center;
	color: #003049;
}
.currentPw {
	position: absolute;
	left: 13.89%;
	right: 61.11%;
	top: 41.69%;
	bottom: 52.98%;
	
}
.pwLabel, .cpwLabel, .cpwChkLabel {
	position: absolute;
	left: 0%;
	right: 74.72%;
	top: 0%;
	bottom: 68.21%;
	
	width: 154px;
    height: 22px;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 15px;
	line-height: 22px;
	letter-spacing: 0.03em;
	color: #003049;
}
#pw, #cpw, #cpwChk {
	position: absolute;
	left: 0.33%;
	right: 0%;
	top: 40.3%;
	bottom: 0%;
	
	padding-left: 8px;
	padding-right: 8px;
	
	width: 358.82px;
    height: 41.31px;
	border: 1px solid rgba(0, 0, 0, 0.25);
	filter: drop-shadow(0px 4px 10px rgba(0, 0, 0, 0.25));
	border-radius: 12px;
	
	outline-color: #F77F00;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
}
#cpw {
	position: absolute;
	left: 0.33%;
	right: 1.64%;
	top: 28.45%;
	bottom: 29.39%;
}
.changePw {
	position: absolute;
	left: 13.89%;
	right: 60.69%;
	top: 48.77%;
	bottom: 43.69%;
}
#changeInfo {
	position: absolute;
	left: 1.91%;
	right: 0%;
	top: 84.69%;
	bottom: 0%;
	font-family: 'Noto Sans KR', sans-serif;
	font-style: normal;
	font-weight: 500;
	font-size: 12px;
	line-height: 18px;
	letter-spacing: 0.03em;
	color: #003049;
}
.changePwCheck {
	position: absolute;
	left: 13.89%;
	right: 61.11%;
	top: 58.08%;
	bottom: 36.6%;
}
#cpwChk {
	position: absolute;
	left: 0.33%;
	right: 0%;
	top: 40.3%;
	bottom: 0%;
}
#deleteInfo {
	position: absolute;
	left: 71.04%;
	right: 22.01%;
	top: 68.15%;
	bottom: 28.69%;
	border: 0;
	outline: 0;
	background: #F77F00;
	filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
	border-radius: 12px;
	color: #FFFFFF;
	
	width: 100px;
    height: 41px;
}
#saveInfo {
	position: absolute;
	left: 79.24%;
	right: 13.82%;
	top: 68.15%;
	bottom: 28.69%;
	border: 0;
	outline: 0;
	background: #F77F00;
	filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
	border-radius: 12px;
	color: #FFFFFF;
	
	width: 100px;
    height: 41px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/httpRequest.js"></script>
<script>
$(function(){
	$("#saveInfo").on("click", function(){
		if($("#pw").val() == ""){
			alert("기존 비밀번호를 입력해주세요.")
			$("#pw").focus();
			return;
		}else if($("#cpw").val() == ""){
			alert("변경할 비밀번호를 입력해주세요.")
			$("#cpw").focus();
			return;
		}else if($("#cpwChk").val() == ""){
			alert("변경할 비밀번호를 한번 더 입력해주세요.")
			$("#cpwChk").focus();
			return;
		}else if($("#cpw").val() != $("#cpwChk").val()){
			alert("변경할 비밀번호가 일치하지 않습니다.")
			$("#cpwChk").val("");
			$("#cpwChk").focus();
			return;
		}else if($("#pw").val() == $("#cpw").val()){
			alert("기존 비밀번호와 다른 비밀번호를 입력해주세요.")
			$("#cpw").val("");
			$("#cpwChk").val("");
			$("#cpw").focus();
			return;
		}else if($("#cpw").val().length < 4 || $("#cpw").val().length > 20){
			alert("4~20 범위의 비밀번호를 입력해주세요.");
			$("#cpw").val("");
			$("#cpwChk").val("");
			$("#cpw").focus();
			return;
		}else if($("#user_pw").val() != $("#pw").val()){
			alert("기존 비밀번호가 올바르지 않습니다.")
			$("#pw").val("");
			$("#pw").focus();
			return;
		}
		$("#frm").submit();
	});
	$("#deleteInfo").on("click", function(){
		var result = confirm("정말로 탈퇴하시겠습니까?");
		if(result){
			// yes
			document.location = "myinfoDelete.jsp?user_num="+<%=mvo.getUserNum()%>;
		} else {
			// no
		}
	});
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var t = e.target.result;
            $("#nickname").attr('src', t);
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";
    }
}

$(function(){
	$("#editNick").on("click", function(){
		$("#edit").show();
	})
});

</script>
	<jsp:include page="../layout/header.jsp" />
</head>
<body>
	<div id="contain">
		<form action="myinfoPwOk.jsp" id="frm" method="post" enctype="multipart/form-data">
		<% if(mvo2.getUserImage() != null){ %>
		<img id="nickname" src="<%=mvo2.getUserImage() %>" />
		<% }else{ %>
		<img id="nickname" src="../etcimg/profile.png" />
		<% } %>
		<div class="file">
		<input type="file" name="img" id="imgfile" style="display:none;" onchange="readURL(this);"/>
				<label for="imgfile"></label>
		</div>
		<!-- <a href="editimg.jsp"><img id="camera" src="../etcimg/camera.png" /></a> -->
		<label id="nicklabel"><%= mvo2.getNickName() %></label>
		<img id="editNick" src="../etcimg/editing.png" />
		<input type="text" name="editNick" value="<%=mvo2.getNickName() %>" id="edit" style="display:none;">
 		<hr id="line1" />
		<label id="editlabel">회원 정보 수정</label>
		<input type="hidden" name="user_num" id="user_num" value="<%=mvo.getUserNum() %>">
		<input type="hidden" name="user_pw" id="user_pw" value="<%=mvo2.getUserPw() %>">
		<input type="hidden" name="user_img" value="<%=mvo2.getUserImage() %>">
			<div class="currentPw">
				<label class="pwLabel">기존 비밀번호</label>
				<input type="password" name="pw" placeholder="기존 비밀번호를 입력해주세요." id="pw">
			</div>
			<div class="changePw">
				<label class="cpwLabel">변경 비밀번호</label>
				<input type="password" name="cpw" placeholder="변경할 비밀번호를 입력해주세요." id="cpw">
				<label id="changeInfo">4~20자리 범위 내 생성</label>
			</div>
			<div class="changePwCheck">
				<label class="cpwChkLabel">변경 비밀번호 확인</label>
				<input type="password" name="cpwChk" placeholder="변경할 비밀번호를 한번 더 입력해주세요." id="cpwChk">
			</div>
		</form>
		<input type="button" value="탈퇴하기" id="deleteInfo"  /> 
		<input type="button" value="저장하기" id="saveInfo" />
	</div>
	<jsp:include page="../layout/footer.jsp" />
</body>
</html>