<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이트 : 회원정보</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function confirm() {
	var width=400;
	var height=200;
	var left=Math.ceil((window.screen.width-width)/2);
	var top=Math.ceil((window.screen.height-height)/2);
	window.open("winopenPass.jsp","","width="+width+",height="+height+",left="+left+",top="+top);
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
		<h1>회원정보 조회</h1>
		<%
		SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
		%>
		<table id="info">
			<tr><th>닉네임</th><td><%=mb.getName() %></td></tr>
			<tr><th>생일</th><td><%=mb.getBirth() %></td></tr>
			<tr><th>성별</th><td><%=mb.getGender() %></td></tr>
			<tr><th>이메일</th><td><%=mb.getEmail() %></td></tr>
			<tr><th>주소</th><td>(우편번호 <%=mb.getPostcode() %>) <%=mb.getRoad_address() %> <%=mb.getDetail_address() %></td></tr>
			<tr><th>연락처</th><td><%=mb.getPhone() %></td></tr>
			<tr><th>가입일</th><td><%=ymd.format(mb.getDate()) %></td></tr>
		</table>
		<div id="table_search">
		<input type="button" value="수정" class="btn" onclick="confirm()">
		</div>
	</article>
<div class="clear"></div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
</div>
<%}%>
</body>
</html>