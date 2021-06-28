<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더 -->
<header>
	<% 
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	if(id == null) { //세션값 없음
		%>
		<!-- 로그인 / 가입-->
		<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">가입</a></div>
		<%
	} else { //세션값 있음
		%>
		<!-- 로그아웃 / 정보 수정 -->
		<div id="login"><%=name %>님 | <a href="../member/info.jsp">내 정보</a> | <a href="../member/logout.jsp">로그아웃</a></div>
		<%
	}
	%>
	<div class="clear"></div>
	<!-- 로고 -->
	<div id="logo"><img src="../images/logo.png"></div>
	<!-- 메뉴 -->
	<nav id="top_menu">
		<ul>
			<li><a href="../main/main.jsp">플레이트 홈</a></li>
			<li><a href="../notice/list.jsp">공지사항</a></li>
			<li><a href="#">탑 메뉴 1</a></li>
			<li><a href="#">탑 메뉴 2</a></li>
			<li><a href="../mail/mailSend.jsp">문의하기</a></li>
		</ul>
	</nav>
</header>