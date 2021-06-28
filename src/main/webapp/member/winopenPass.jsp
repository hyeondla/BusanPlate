<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재확인</title>
<script type="text/javascript">
	function result() {
		 window.opener.location.href="../member/update.jsp";
		 window.close();
	}
</script>
</head>
<body>
<% 
// String id = request.getParameter("id");
String id = (String)session.getAttribute("id");
String pass = request.getParameter("pass");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.userCheck(id, pass);

if(mb == null){
	%>
인증을 위해 비밀번호를 입력해주세요<br><br>
<form action="winopenPass.jsp" method="post">
<input type="password" name="pass"> 
<input type="submit" value="확인">
</form>
	<%
} else {
	%>
인증에 성공했습니다<br><br>
<input type="button" value="확인" onclick="result()">
	<%
}
%>
</body>
</html>