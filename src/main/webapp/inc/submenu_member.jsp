<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 왼쪽 메뉴 -->
<nav id="sub_menu">
	<ul>
		<li><a href="../member/info.jsp">내 정보 보기 / 수정</a></li>
		<li><a href="#" class="disclick">내가 쓴 글</a></li>
		<li><a href="../member/writeList.jsp">- 자유게시판</a></li>
		<li><a href="../member/writeReviewList.jsp">- 리뷰게시판</a></li>
		<li><a href='#' class="disclick">내가 쓴 댓글</a></li>
		<li><a href="../member/commentList.jsp">- 자유게시판</a></li>
		<li><a href="../member/commentReviewList.jsp">- 리뷰게시판</a></li>
		<%
		String id = (String)session.getAttribute("id");
		if(id.equals("admin")) {
			%>
		<li><a href="../member/noticeList.jsp">내가 쓴 공지사항</a></li>
			<%
		} 
		%>
		<li><a href='../member/delete.jsp'>탈퇴</a></li>
	</ul>
</nav>