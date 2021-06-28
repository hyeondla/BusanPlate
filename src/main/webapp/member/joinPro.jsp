<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
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
String pass2 = request.getParameter("pass2");
String name = request.getParameter("name");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String birth = "";
if(month.length()==1){
	birth += year + "-0" + month;
} else {
	birth += year + "-" + month;
}
if(day.length()==1){
	birth += "-0" + day;
} else {
	birth += "-" + day;
}
String gender = request.getParameter("gender");
String email = request.getParameter("email");
String postcode = request.getParameter("postcode");
String roadAddress = request.getParameter("roadAddress");
String detailAddress = request.getParameter("detailAddress");
String phone = request.getParameter("phone");
Timestamp date = new Timestamp(System.currentTimeMillis());

// DB 작업
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setBirth(birth);
mb.setGender(gender);
mb.setEmail(email);
mb.setPostcode(postcode);
mb.setRoad_address(roadAddress);
mb.setDetail_address(detailAddress);
mb.setPhone(phone);
mb.setDate(date);

MemberDAO mdao = new MemberDAO();
mdao.insertMember(mb);

%>
<script type="text/javascript">
	alert("회원가입 되셨습니다");
	location.href = "login.jsp";
</script>
</body>
</html>