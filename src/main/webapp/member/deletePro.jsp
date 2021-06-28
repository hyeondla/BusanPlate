<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");

MemberDAO mdao = new MemberDAO();
mdao.deleteMember(id);

session.invalidate();
%>
<script type="text/javascript">	
	alert("회원탈퇴 완료");
	location.href="../main/main.jsp";
</script>
</body>
</html>