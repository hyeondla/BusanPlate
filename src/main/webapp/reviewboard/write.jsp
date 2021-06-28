<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 리뷰쓰기</title>
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
		<h1>리뷰 쓰기</h1>
		<form action="writePro.jsp" method="post" enctype="multipart/form-data">
		<table id="notice">
			<tr><td class="twrite">지역</td><td>
			<select name="location" style="width:60%;">
			    <option value="">선택</option>
			    <option value="강서구">강서구</option>
			    <option value="금정구">금정구</option>
			    <option value="기장군">기장군</option>
			    <option value="남구">남구</option>
			    <option value="동구">동구</option>
				<option value="동래구">동래구</option>
				<option value="부산진구">부산진구</option>
				<option value="북구">북구</option>
				<option value="사상구">사상구</option>
				<option value="사하구">사하구</option>
				<option value="서구">서구</option>
				<option value="수영구">수영구</option>
				<option value="연제구">연제구</option>
				<option value="영도구">영도구</option>
				<option value="중구">중구</option>
				<option value="해운대구">해운대구</option>
			</select>
			</td>
			<td class="twrite">분류</td><td>
			<select name="category" style="width:60%;">
			    <option value="">선택</option>
			    <option value="방문">방문</option>
			    <option value="배달">배달</option>
			    <option value="포장">포장</option>
			</select>
			</td></tr>
			<tr><td class="twrite">제목</td><td colspan="3"><input type="text" name="subject" style="width:95%;" placeholder="제목을 입력해주세요"></td></tr>
			<tr><td class="twirte">내용</td><td colspan="3"><textarea rows="20" name="content" style="width:95%;" placeholder="내용을 입력해주세요"></textarea></td></tr>
			<tr><td class="twrite">파일</td><td><input type="file" name="file"></td><td colspan="2">※ 10MB까지 업로드 가능합니다</td></tr>
		</table>
		<div id="table_search">
			<input type="submit" value="글쓰기" class="btn">
		</div>
		</form>
		<div class="clear"></div>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
<%	} %>
</body>
</html>