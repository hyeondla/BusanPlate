<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
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
int commentNum = Integer.parseInt(request.getParameter("num"));

CommentDAO cdao = new CommentDAO();

CommentBean cb = cdao.getComment(commentNum);
int num = cb.getBoardnum();

cdao.deleteComment(commentNum);
%>
<script type="text/javascript">
	alert("댓글이 삭제되었습니다");
	location.href="../board/content.jsp?num=<%=num %>";
</script>
</body>
</html>