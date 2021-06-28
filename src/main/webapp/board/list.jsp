<%@page import="comment.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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
	int pageSize = 15; // 한 화면에 보여줄 글 개수
	
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	if(pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum); // 정수화
	
	int startRow = (currentPage-1) * pageSize + 1; // 시작 번호
	int endRow = startRow + pageSize - 1; // 끝 번호
	
	BoardDAO bdao = new BoardDAO();
	List<BoardBean> boardList = bdao.getBoardList(startRow, pageSize);
	
	CommentDAO cdao = new CommentDAO();
	%>
	<article>
		<h1>자유게시판</h1>
		<table id="notice">
			<tr><th class="tno">글번호</th>
			    <th class="ttitle">제목</th>
			    <th class="twriter">작성자</th>
			    <th class="tdate">작성일</th>
			    <th class="tread">조회수</th></tr>
			<% 
			for(int i=0; i<boardList.size(); i++){
				BoardBean bb = boardList.get(i);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); // 날짜 포맷 
			%>
			<tr onclick="location.href='content.jsp?num=<%=bb.getNum() %>'"><td><%=bb.getNum() %></td>
				<td class="left"><%=bb.getSubject() %>
				<%
				// 댓글 개수 표시				
				if(cdao.getCommentCount(bb.getNum()) != 0) {
					%> &nbsp;[<%=cdao.getCommentCount(bb.getNum()) %>]<%
				}
				%>
				</td>
				<td><%=bb.getName() %></td>
				<td><%=sdf.format(bb.getDate()) %></td>
				<td><%=bb.getReadcount() %></td></tr>
			<%
			}
			%>
		</table>
		<div id="table_search">
			<form action="listSearch.jsp" method="post">
				<input type="text" name="search" class="input_box">
				<input type="submit" value="검색" class="btn">
			</form>
		</div>
		<%
		String id = (String)session.getAttribute("id");
		if(id != null){
			%>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'" style="float:left;">
			</div>
			<%
		}
			%>
		<div class="clear"></div>
		<div id="page_control">
		<% 
		int pageBlock = 10; //페이지 수
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		int count = bdao.getBoardCount();
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1);
		if(endPage > pageCount) {
			endPage = pageCount; 
		}
		if(startPage > pageBlock) {
			%><a href="list.jsp?pageNum=<%=startPage-pageBlock %>">Prev</a><%
		}
		for(int i=startPage; i<=endPage; i++) {
			%><a href="list.jsp?pageNum=<%=i%>"><%=i %></a><%
		}
		if(endPage < pageCount) {
			%><a href="list.jsp?pageNum=<%=endPage+pageBlock %>">Next</a><%
		}
		%>
		</div>
	</article>
	<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>