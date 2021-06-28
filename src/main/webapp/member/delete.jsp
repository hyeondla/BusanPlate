<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 회원탈퇴</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function confirm() {
	var width=400;
	var height=200;
	var left=Math.ceil((window.screen.width-width)/2);
	var top=Math.ceil((window.screen.height-height)/2);
	window.open("winopenDelete.jsp","","width="+width+",height="+height+",left="+left+",top="+top);
}
</script>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("../member/login.jsp");
} else {
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>
<div id="wrap">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

	<div id="sub_img_member"></div>
<!-- 	왼쪽 메뉴 -->
	<jsp:include page="../inc/submenu_member.jsp"/>
<!-- 	본문 -->
	<article>
		<h1>회원 탈퇴</h1>
			탈퇴하셔도 작성한 글이나 댓글은 자동 삭제되지 않습니다<br>
			탈퇴하시겠습니까?<br><br>
			<div id="table_search">
			<input type="button" value="탈퇴" class="btn" onclick="confirm()">
			</div>
	</article>
<div class="clear"></div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
</div>
<%}%>
</body>
</html>