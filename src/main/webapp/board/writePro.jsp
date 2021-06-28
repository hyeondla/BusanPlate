<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
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

BoardBean bb = new BoardBean();
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);
bb.setDate(date);
bb.setReadcount(0);
bb.setId(id);

BoardDAO bdao = new BoardDAO();
bdao.insertBoard(bb);
%>
<script type="text/javascript">
alert("글이 등록되었습니다");
location.href = "../board/list.jsp";
</script>
</body>
</html>