<%@page import="reviewcomment.ReviewCommentDAO"%>
<%@page import="fileboard.FileBoardBean"%>
<%@page import="fileboard.FileBoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 작성글</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("../member/login.jsp");
} else {
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

int pageSize = 15; // 한 화면에 보여줄 글 개수
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum); // 정수화
int startRow = (currentPage-1) * pageSize + 1; // 시작 번호
int endRow = startRow + pageSize - 1; // 끝 번호
FileBoardDAO bdao = new FileBoardDAO();
List<FileBoardBean> boardList = bdao.fileGetMyBoardList(startRow, pageSize, id);

ReviewCommentDAO cdao = new ReviewCommentDAO();
%>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

	<div id="sub_img_member"></div>
<!-- 	왼쪽 메뉴 -->
	<jsp:include page="../inc/submenu_member.jsp"/>
<!-- 	본문 -->
	<article>
		<h1>리뷰게시판 작성글</h1>
		이전 닉네임으로 작성한 글도 모두 표시됩니다<br><br>
		<table id="notice">
			<tr><th class="tno">글번호</th>
			    <th class="ttitle">제목</th>
			    <th class="twriter">작성자</th>
			    <th class="tdate">작성일</th>
			    <th class="tread">조회수</th></tr>
			<% 
			for(int i=0; i<boardList.size(); i++){
				FileBoardBean bb = boardList.get(i);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); // 날짜 포맷 
			%>
				<tr onclick="location.href='../reviewboard/content.jsp?num=<%=bb.getNum() %>'">
				<td><%=bb.getNum() %></td>
				<td class="left"><%=bb.getSubject() %>
				<%
				// 이미지 여부 표시
				if(bb.getImage()==1) {
					%> &nbsp;<img src="../images/icon_image.png"><%
				} 
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
			if(boardList.size()==0){
				%>
				<tr><td colspan=5>작성한 글이 없습니다</td></tr>
				<%
			}
			%>
		</table>
		<div class="clear"></div>
		<div id="page_control">
		<% 
		int pageBlock = 10; //페이지 수
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		int count = bdao.fileGetMyBoardCount(id);
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1);
		if(endPage > pageCount) {
			endPage = pageCount; 
		}
		if(startPage > pageBlock) {
			%><a href="writeReviewList.jsp?pageNum=<%=startPage-pageBlock %>">Prev</a><%
		}
		for(int i=startPage; i<=endPage; i++) {
			%><a href="writeReviewList.jsp?pageNum=<%=i%>"><%=i %></a><%
		}
		if(endPage < pageCount) {
			%><a href="writeReviewList.jsp?pageNum=<%=endPage+pageBlock %>">Next</a><%
		}
		%>
		</div>
	</article>
<div class="clear"></div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
</div>
<%}%>
</body>
</html>