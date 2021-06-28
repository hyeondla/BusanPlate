<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복 조회</title>
<script type="text/javascript">
	function result() {
		opener.document.fr.nameDup.value = "nameCheck";
		opener.document.fr.name.value = document.wfr.name.value;
		window.close();
	}
</script>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.dupCheck("name",name);
%>
<form action="winopenName.jsp" method="post" name="wfr">
닉네임 <input type="text" name="name" value="<%=name %>">&nbsp;
<input type="submit" value="중복확인">
</form>
<br>
<%
if(mb != null) {
	out.println("중복입니다");
} else if(name.length()<2 || name.length()>10){
	out.println("닉네임을 2~10자 입력하세요");
} else {
	out.println("사용가능합니다");
	%>
	<input type="button" value="사용하기" onclick="result()">
	<%
}
%>
</body>
</html>