<%@page import="member.MemberBean"%>
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
request.setCharacterEncoding("utf-8");

//닉네임 변경시 세션은 이전 닉네임 유지됨
//=> 닉네임 세션 삭제
session.removeAttribute("name"); 

String id = (String)session.getAttribute("id");
String name = request.getParameter("name");
String postcode = request.getParameter("postcode");
String roadAddress = request.getParameter("roadAddress");
String detailAddress = request.getParameter("detailAddress");
String phone = request.getParameter("phone");

MemberDAO mdao = new MemberDAO();
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setName(name);
mb.setPostcode(postcode);
mb.setRoad_address(roadAddress);
mb.setDetail_address(detailAddress);
mb.setPhone(phone);

mdao.updateMember(mb);

session.setAttribute("name", mb.getName()); //=>닉네임 세션 재등록


%>
<script type="text/javascript">	
	alert("회원정보 수정 완료");
	location.href="../member/info.jsp";
</script>
</body>
</html>