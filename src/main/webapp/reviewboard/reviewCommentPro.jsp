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

String id = (String)session.getAttribute("id");
String name = (String)session.getAttribute("name");
int boardnum = Integer.parseInt(request.getParameter("boardnum"));
String content = request.getParameter("comment");
Timestamp date = new Timestamp(System.currentTimeMillis());

if(content.length() < 1) {
	%>
	<script type="text/javascript">
		alert("내용을 입력해주세요");
		history.back();
	</script>
	<%
	return;
} 

ReviewCommentBean cb = new ReviewCommentBean();
cb.setId(id);
cb.setName(name);
cb.setContent(content);
cb.setBoardnum(boardnum);
cb.setDate(date);

ReviewCommentDAO cdao = new ReviewCommentDAO();
cdao.insertComment(cb);
%>
<script type="text/javascript">
alert("댓글이 등록되었습니다");
location.href = "../reviewboard/content.jsp?num=<%=boardnum %>";
</script>
</body>
</html>