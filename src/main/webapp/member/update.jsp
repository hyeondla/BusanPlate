<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 회원정보</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function winopen() {
	var name=document.fr.name.value;
	var width=400;
	var height=200;
	var left=Math.ceil((window.screen.width-width)/2);
	var top=Math.ceil((window.screen.height-height)/2);
	document.open("winopenChangeName.jsp?name="+name,"","width="+width+",height="+height+",left="+left+",top="+top);
}
function resetAddress() {
	document.getElementById('postcode').value = "";
	document.getElementById('roadAddress').value = "";
	document.getElementById('detailAddress').value = "";
}
//	다음 API
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress;
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('roadAddress').value = roadAddr;
            var guideTextBox = document.getElementById("guide");
            document.getElementById('detailAddress').value = "";
            document.getElementById('detailAddress').focus();
        }
    }).open();
}
</script>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("../member/login.jsp");
} else {
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 -->
	<!-- 메인 이미지 -->
	<div id="sub_img_member"></div>
	<!-- 왼쪽 메뉴 -->
	<jsp:include page="../inc/submenu_member.jsp"/>
	<!-- 본문 내용 -->
	<article>
		<h1>회원정보 수정</h1>
		<form action="updatePro.jsp" method="post" id="join" name="fr">
			<fieldset>
				<legend>필수 사항</legend>
					
					<label>닉네임</label>
					<input type="text" name="name" value="<%=mb.getName() %>" readonly>
					<input type="button" value="변경" class="dup" onclick="winopen()"><br>
					<input type="hidden" name="nameDup" value="nameUncheck">
					
					<label>생년월일</label>
					<%=mb.getBirth() %>
					<br>
					
					<label>성별</label>
					<%=mb.getGender() %>
					<br>
					
					<label>이메일</label>
					<%=mb.getEmail() %>
					<br>
					
			</fieldset>
			<fieldset>
				<legend>선택 사항</legend>
					
					<label>주소</label>
					<input type="text" name="postcode" id="postcode" class="postcode" placeholder="우편번호" value="<%=mb.getPostcode() %>" readonly>
					<input type="button" class="dup" onclick="execDaumPostcode()" value="우편번호 찾기">
					<input type="button" class="dup" onclick="resetAddress()" value="초기화"><br>
					<label>&nbsp;</label>
					<input type="text" name="roadAddress" id="roadAddress" class="address" placeholder="도로명주소" value="<%=mb.getRoad_address() %>" readonly>
					<span id="guide" style="color:#999;display:none"></span><br>
					<label>&nbsp;</label>
					<input type="text" name="detailAddress" id="detailAddress" class="address" placeholder="상세주소" value="<%=mb.getDetail_address() %>"><br>
					
					<label>연락처</label>
					<input type="text" name="phone" placeholder="000-0000-0000" value="<%=mb.getPhone() %>"><br>
					
			</fieldset>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="저장하기" class="submit">
				<input type="reset" value="되돌리기" class="cancel">
			</div>
		</form>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
<%} %>
</body>
</html>