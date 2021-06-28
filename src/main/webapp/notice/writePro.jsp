<%@page import="notice.NoticeDAO"%>
<%@page import="notice.NoticeBean"%>
<%@page import="java.sql.Timestamp"%>
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

String id = (String)session.getAttribute("id");
String name = (String)session.getAttribute("name");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
Timestamp date = new Timestamp(System.currentTimeMillis());

if(subject.length() < 1) {
	%>
	<script type="text/javascript">
		alert("제목을 입력해주세요");
		history.back();
	</script>
	<%
	return;
}
if(content.length() < 1) {
	%>
	<script type="text/javascript">
		alert("내용을 입력해주세요");
		history.back();
	</script>
	<%
	return;
}

NoticeBean cb = new NoticeBean();
cb.setName(name);
cb.setSubject(subject);
cb.setContent(content);
cb.setDate(date);
cb.setReadcount(0);
cb.setId(id);

NoticeDAO ndao = new NoticeDAO();
ndao.insertBoard(cb);
%>
<script type="text/javascript">
alert("공지사항이 등록되었습니다");
location.href = "../notice/list.jsp";
</script>
</body>
</html>