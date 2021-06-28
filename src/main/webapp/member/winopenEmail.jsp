<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복 조회</title>
<script type="text/javascript">
	function result() {
		opener.document.fr.emailDup.value = "emailCheck";
		opener.document.fr.email.value = document.wfr.email.value;
		window.close();
	}
</script>
</head>
<body>
<% 
String email = request.getParameter("email");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.dupCheck("email",email);
%>
<form action="winopenEmail.jsp" method="post" name="wfr">
이메일 <input type="text" name="email" value="<%=email %>">&nbsp;
<input type="submit" value="중복확인">
</form>
<br>
<%
if(mb != null) {
	out.println("중복입니다");
} else if(!email.contains("@")){
	out.println("@를 포함해주세요");
}
else {
	out.println("사용가능합니다");
	%>
	<input type="button" value="사용하기" onclick="result()">
	<%
}
%>
</body>
</html>