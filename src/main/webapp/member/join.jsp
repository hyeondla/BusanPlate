<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 회원 가입</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
// 	입력제어
	function check() {
		if(document.fr.idDup.value != "idCheck"){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		
		if(document.fr.pass.value.length<4 || document.fr.pass.value.length>10) {
			alert("비밀번호를 4~10자 입력하세요");
			document.fr.pass.focus();
			return false;
		}
		if(document.fr.pass2.value.length<4 || document.fr.pass2.value.length>10) {
			alert("비밀번호를 4~10자 입력하세요");
			document.fr.pass2.focus();
			return false;
		}
		if(document.fr.pass.value != document.fr.pass2.value) {
			alert("비밀번호가 일치하지 않습니다");
			document.fr.pass.focus();
			return false;
		}
		
		if(document.fr.nameDup.value != "nameCheck"){
			alert("닉네임 중복체크를 해주세요");
			return false;
		}
		
		if(document.fr.year.value == "" || isNaN(document.fr.year.value)) {
			alert("생년월일을 입력하세요");
			document.fr.year.focus();
			return false;
		}

		if(document.fr.emailDup.value != "emailCheck"){
			alert("이메일 중복체크를 해주세요");
			return false;
		}
	}
	
// 	중복 체크창
	function winopen1() {
		if(document.fr.id.value.length<3 || document.fr.id.value.length>10){
			alert("아이디를 3~10자 입력하세요");
			document.fr.id.focus();
			return;
		}
		var width=400;
		var height=200;
		var left=Math.ceil((window.screen.width-width)/2);
		var top=Math.ceil((window.screen.height-height)/2);
		var id=document.fr.id.value;
		document.open("winopenId.jsp?id="+id,"","width="+width+",height="+height+",left="+left+",top="+top);
	}
	function winopen2() {
		if(document.fr.name.value.length<2 || document.fr.name.value.length>10) {
			alert("닉네임을 2~10자 입력하세요");
			document.fr.name.focus();
			return;
		}
		var width=400;
		var height=200;
		var left=Math.ceil((window.screen.width-width)/2);
		var top=Math.ceil((window.screen.height-height)/2);
		var name=document.fr.name.value;
		document.open("winopenName.jsp?name="+name,"","width="+width+",height="+height+",left="+left+",top="+top);
	}
	function winopen3() {
		if(document.fr.email.value == "") {
			alert("이메일을 입력하세요");
			document.fr.email.focus();
			return;
		} else if(!document.fr.email.value.includes('@')){
			alert("잘못된 이메일 형식입니다\n@를 포함해주세요");
			document.fr.email.focus();
			return;
		}
		var width=400;
		var height=200;
		var left=Math.ceil((window.screen.width-width)/2);
		var top=Math.ceil((window.screen.height-height)/2);
		var email=document.fr.email.value;
		document.open("winopenEmail.jsp?email="+email,"","width="+width+",height="+height+",left="+left+",top="+top);
	}

// 	다음 API
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress;
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('roadAddress').value = roadAddr;
                var guideTextBox = document.getElementById("guide");
                document.getElementById('detailAddress').focus();
            }
        }).open();
    }
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 -->
	<!-- 메인이미지 -->
	<div id="sub_img_member"></div>
	<!-- 왼쪽 메뉴 -->
<!-- 	<nav id="sub_menu"> -->
<!-- 			<ul> -->
<!-- 				<li><a href="#">Join us</a></li> -->
<!-- 				<li><a href="#">Privacy policy</a></li> -->
				
<!-- 			</ul> -->
<!-- 	</nav> -->
	<!-- 본문 내용 -->
	<article>
		<h1>회원 가입</h1>
		<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return check()">
			<fieldset>
				<legend>필수 사항</legend>
				
					<label>아이디</label>
					<input type="text" name="id" class="id" placeholder="3~10자">
					<input type="button" value="중복확인" class="dup" onclick="winopen1()"><br>
					<input type="hidden" name="idDup" value="idUncheck">
					
					<label>비밀번호</label>
					<input type="password" name="pass" placeholder="4~10자"><br>
					<label>비밀번호 확인</label>
					<input type="password" name="pass2" placeholder="4~10자"><br>
					
					<label>닉네임</label>
					<input type="text" name="name" placeholder="2~10자">
					<input type="button" value="중복확인" class="dup" onclick="winopen2()"><br>
					<input type="hidden" name="nameDup" value="nameUncheck">
					
					<label>생년월일</label>
					<input type="text" name="year" class="year">년
					<select name="month">
						<%
							for(int i=1; i<=12; i++){
						%>
								<option value="<%=i %>"><%=i %></option>
						<%
							}
						%>						
					</select>월
					<select name="day">
						<%
							for(int i=1; i<=31; i++){
						%>
								<option value="<%=i %>"><%=i %></option>
						<%
							}
						%>						
					</select>일
					<br>
					
					<label>성별</label>
					<input type="radio" name="gender" value="남">남 &nbsp;
					<input type="radio" name="gender" value="여">여 &nbsp;
					<input type="radio" name="gender" value="선택안함" checked>선택안함
					<br>
					
					<label>이메일</label>
					<input type="email" name="email">
					<input type="button" value="중복확인" class="dup" onclick="winopen3()"><br>
					<input type="hidden" name="emailDup" value="emailUncheck">
			</fieldset>
			<fieldset>
				<legend>선택 사항</legend>
					
					<label>주소</label>
					<input type="text" name="postcode" id="postcode" class="postcode" placeholder="우편번호" readonly>
					<input type="button" class="dup" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<label>&nbsp;</label>
					<input type="text" name="roadAddress" id="roadAddress" class="address" placeholder="도로명주소" readonly>
					<span id="guide" style="color:#999;display:none"></span><br>
					<label>&nbsp;</label>
					<input type="text" name="detailAddress" id="detailAddress" class="address" placeholder="상세주소"><br>
					
					<label>연락처</label>
					<input type="text" name="phone" placeholder="000-0000-0000"><br>
					
			</fieldset>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="가입하기" class="submit">
				<input type="reset" value="초기화" class="cancel">
			</div>
		</form>
	</article>
<div class="clear"></div>

<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>