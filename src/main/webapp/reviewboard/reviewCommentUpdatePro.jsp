<%@page import="reviewcomment.ReviewCommentDAO"%>
<%@page import="reviewcomment.ReviewCommentBean"%>
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

int commentNum = Integer.parseInt(request.getParameter("commentNum"));
String content = request.getParameter("content");
Timestamp date = new Timestamp(System.currentTimeMillis());

ReviewCommentBean cb = new ReviewCommentBean();
cb.setNum(commentNum);
cb.setContent(content);
cb.setDate(date);

ReviewCommentDAO cdao = new ReviewCommentDAO();
cdao.updateComment(cb);

cb = cdao.getComment(commentNum);
int num = cb.getBoardnum();
%>
<script type="text/javascript">
	alert("댓글이 수정되었습니다");
	location.href="../reviewboard/content.jsp?num=<%=num %>";
</script>
</body>
</html>