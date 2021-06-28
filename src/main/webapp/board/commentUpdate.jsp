<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 자유게시판</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function back(){
	history.back();
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
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	BoardDAO bdao = new BoardDAO();
	BoardBean bb = bdao.getBoard(num);
	String content = bb.getContent();
	if(content != null) {
		content = content.replace("\r\n","<br>");
	}
	SimpleDateFormat ymdhm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	%>
	<article>
		<h1>자유게시판</h1>
		<table id="notice">
			<tr><td>글번호</td><td><%=bb.getNum() %></td>
				<td>글쓴이</td><td><%=bb.getName() %></td></tr>
			<tr><td>작성일</td><td><%=ymdhm.format(bb.getDate()) %></td>
				<td>조회수</td><td><%=bb.getReadcount() %></td></tr>
			<tr><td>제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>
			<tr><td>내용</td><td colspan="3"><%=content %></td></tr>
		</table><br>
<!-- 		------------------------------------------------------------ -->
		<table id="notice">
		<tr><td>댓글</td><td colspan="3">
		<%
		String id = (String)session.getAttribute("id");
		CommentDAO cdao = new CommentDAO();
		List<CommentBean> commentList = cdao.getCommentList(num);
		if(commentList.size() == 0) {
			%>
			댓글이 없습니다
			<%
		}%></td></tr><%
		for(int i=0; i<commentList.size(); i++){
			CommentBean cb = commentList.get(i);
			%>
			<tr><td><%=cb.getName() %></td>
			<td width="60%">
			<%
			if(commentNum == cb.getNum()){
			%>
			<form action="commentUpdatePro.jsp" method="post">
			<input type="hidden" name="commentNum" value="<%=commentNum %>">
			<input type="text" name="content" style="width:70%;" value="<%=cb.getContent() %>">
			<input type="submit" value="수정">
			<input type="button" value="취소" onclick="back()">
			</form>
			<%} else {%>
			<%=cb.getContent() %>
			<%} %>
			</td>
			<td></td>
			<td><%=ymdhm.format(cb.getDate()) %></td></tr>
			<%
			}
			%>
		</table>
<!-- 		------------------------------------------------------------ -->
		<div id="table_search">
			<input type="button" value="글목록" onClick="location.href='list.jsp'" class="btn">
		</div>
		<div class="clear"></div>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>