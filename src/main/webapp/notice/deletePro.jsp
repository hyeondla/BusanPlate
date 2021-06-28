<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));

String id = (String)session.getAttribute("id");
if(!id.equals("admin") || id==null) {
	%>
	<script type="text/javascript">
	alert("권한이 없습니다");
	</script>
	<%
	response.sendRedirect("../notice/list.jsp");
} else {

NoticeDAO ndao = new NoticeDAO();
ndao.deleteBoard(num);
%>
<script type="text/javascript">
	alert("공지사항이 삭제되었습니다");
	location.href="list.jsp";
</script>
<% } %>
</body>
</html>