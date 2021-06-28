<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardDAO"%>
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

BoardDAO bdao = new BoardDAO();
bdao.deleteBoard(num);

CommentDAO cdao = new CommentDAO();
cdao.deleteCommentAll(num);
%>
<script type="text/javascript">
	alert("글이 삭제되었습니다");
	location.href="list.jsp";
</script>
</body>
</html>