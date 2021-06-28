<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 공지사항</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function del(num) {
	if(confirm('글을 삭제합니다')) {
		location.href="deletePro.jsp?num="+num;
	}
}
</script>
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
	int num = Integer.parseInt(request.getParameter("num"));
	NoticeDAO ndao = new NoticeDAO();
	ndao.updateReadcount(num);
	NoticeBean nb = ndao.getBoard(num);
	String content = nb.getContent();
	if(content != null) {
		content = content.replace("\r\n","<br>");
	}
	SimpleDateFormat ymdhm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	%>
	<article>
		<h1>공지사항</h1>
		<table id="notice">
			<tr><td width="10%">글번호</td><td><%=nb.getNum() %></td>
				<td>글쓴이</td><td><%=nb.getName() %></td></tr>
			<tr><td>작성일</td><td><%=ymdhm.format(nb.getDate()) %></td>
				<td>조회수</td><td><%=nb.getReadcount() %></td></tr>
			<tr><td>제목</td><td colspan="3"><%=nb.getSubject() %></td></tr>
			<tr><td>내용</td><td colspan="3"><%=content %></td></tr>
		</table><br>
		<div id="table_search">
		<%
		String id = (String)session.getAttribute("id");
		if(id!=null){
			if(id.equals("admin")){
				%>
				<input type="button" value="글수정" onClick="location.href='update.jsp?num=<%=nb.getNum() %>'" class="btn">
				<input type="button" value="글삭제" onClick="del(<%=num%>)" class="btn">
				<%
			}
		}%>
			<input type="button" value="글목록" onClick="location.href='list.jsp'" class="btn">
		</div>
		<div class="clear"></div>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>