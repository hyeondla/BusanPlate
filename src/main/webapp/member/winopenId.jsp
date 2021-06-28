<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 조회</title>
<script type="text/javascript">
	function result() {
		opener.document.fr.idDup.value = "idCheck";
		opener.document.fr.id.value = document.wfr.id.value;
		window.close();
	}
</script>
</head>
<body>
<% 
String id = request.getParameter("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.dupCheck("id",id);
%>
<form action="winopenId.jsp" method="post" name="wfr">
아이디 <input type="text" name="id" value="<%=id %>">&nbsp;
<input type="submit" value="중복확인">
</form>
<br>
<%
if(mb != null) {
	out.println("중복입니다");
} else if(id.length()<3 || id.length()>10){
	out.println("아이디를 3~10자 입력하세요");
} else {
	out.println("사용가능합니다");
	%>
	<input type="button" value="사용하기" onclick="result()">
	<%
}
%>
</body>
</html>