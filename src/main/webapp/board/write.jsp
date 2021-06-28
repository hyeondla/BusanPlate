<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 글쓰기</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

<!-- 본문 -->
	<!-- 메인 이미지 -->
	<div id="sub_img_center"></div>
	<!-- 왼쪽 메뉴 -->
	<jsp:include page="../inc/submenu.jsp"/>
	<!-- 본문 내용 -->
	<%
	String id = (String)session.getAttribute("id");
	if(id == null) {
		response.sendRedirect("../member/login.jsp");
	} else {
	%>
	<article>
		<h1>글쓰기</h1>
		<form action="writePro.jsp" method="post">
			<table id="notice">
			<tr><td class="twrite">제목</td><td><input type="text" name="subject" style="width:95%" placeholder="제목을 입력해주세요"></td></tr>
			<tr><td class="twirte">내용</td><td><textarea rows="20" name="content" style="width:95%;" placeholder="내용을 입력해주세요"></textarea></td></tr>
			</table>			
			<div id="table_search">
			<input type="submit" value="등록" class="btn">
			</div>
		</form>
		<div class="clear"></div>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
<% } %>
</body>
</html>