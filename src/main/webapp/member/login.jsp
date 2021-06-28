<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 로그인</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 -->
	<!-- 메인 이미지 -->
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
		<h1>로그인</h1>
		<form action="loginPro.jsp" method="post" id="join">
			<fieldset>
				<legend></legend>
					<label>아이디</label>
					<input type="text" name="id"><br>
					<label>비밀번호</label>
					<input type="password" name="pass"><br>
 			</fieldset>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="로그인" class="submit">
				<input type="button" value="가입하기" class="cancel" onclick="location.href='../member/join.jsp'">
			</div>
		</form>
	</article>
<div class="clear"></div>

<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</div>
</body>
</html>