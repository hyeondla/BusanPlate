<%@page import="fileboard.FileBoardBean"%>
<%@page import="fileboard.FileBoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 홈</title>
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
	int pageSize = 9; // 한 화면에 보여줄 글 개수
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	if(pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum); // 정수화
	int startRow = (currentPage-1) * pageSize + 1; // 시작 번호
	int endRow = startRow + pageSize - 1; // 끝 번호
	FileBoardDAO bdao = new FileBoardDAO();
	List<FileBoardBean> boardList = bdao.fileGetGalleryList(startRow, pageSize);
%>
	<div>
	<article>
	<h1>플레이트에 오신걸 환영합니다!</h1><br>
	<table id="photo">
		<%
		for(int i=0; i<boardList.size(); i++) {
			FileBoardBean bb = boardList.get(i);
			if(i%3==0){
				%><tr><%
			}
			%>
			<td onclick="location.href='../reviewboard/content.jsp?num=<%=bb.getNum() %>'"><img src="../upload/<%=bb.getFile() %>" width=100%></td>
			<%
			if(i%3==2){
				%></tr><%
			}
		}
		%>
	</table>
	<div class="clear"></div>	
	<div id="page_control">
		<% 
		int pageBlock = 10; //페이지 수
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		int count = bdao.fileGetGalleryCount();
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1);
		if(endPage > pageCount) {
			endPage = pageCount; 
		}
		if(startPage > pageBlock) {
			%><a href="main.jsp?pageNum=<%=startPage-pageBlock %>">Prev</a><%
		}
		for(int i=startPage; i<=endPage; i++) {
			%><a href="main.jsp?pageNum=<%=i%>"><%=i %></a><%
		}
		if(endPage < pageCount) {
			%><a href="main.jsp?pageNum=<%=endPage+pageBlock %>">Next</a><%
		}
		%>
	</div>
	<div class="clear"></div>
</article>
	</div>
	
	
<div class="clear"></div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>