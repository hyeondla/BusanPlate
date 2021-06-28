<%@page import="notice.NoticeDAO"%>
<%@page import="notice.NoticeBean"%>
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
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String subject = request.getParameter("subject");
String content = request.getParameter("content");

NoticeBean nb = new NoticeBean();
nb.setNum(num);
nb.setSubject(subject);
nb.setContent(content);

NoticeDAO ndao = new NoticeDAO();
ndao.updateBoard(nb);
%>
<script type="text/javascript">
	alert("공지사항이 수정되었습니다");
	location.href="content.jsp?num=<%=num %>";
</script>
</body>
</html>