<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.userCheck(id, pass);

if(mb != null){
	mb = mdao.getMember(id);
	session.setAttribute("id", id);
	session.setAttribute("name", mb.getName());
	response.sendRedirect("../main/main.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("아이디 또는 비밀번호가 틀립니다");
		history.back();
	</script> 
	<%
}
%>
</body>
</html>