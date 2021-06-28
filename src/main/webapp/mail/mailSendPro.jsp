<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.GoogleAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
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

String sender = request.getParameter("sender");
String receiver = request.getParameter("receiver");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

if(subject.length() < 1) {
	%>
	<script type="text/javascript">
		alert("제목을 입력해주세요");
		history.back();
	</script>
	<%
	return;
}
if(content.length() < 1) {
	%>
	<script type="text/javascript">
		alert("내용을 입력해주세요");
		history.back();
	</script>
	<%
	return;
}

if(content != null) {
	content = content.replace("\r\n","<br>");
}
try {
	// Properties 객체 생성
	Properties properties = System.getProperties();
	properties.put("mail.smtp.starttls.enable", "true");
	// 서버 정보 저장
	properties.put("mail.smtp.host", "smtp.gmail.com");
	// 사용자 인증
	properties.put("mail.smtp.auth", "true");
	// gmail 포트 설정
	properties.put("mail.smtp.port", "587");
	
	// 인증정보 생성
	// Authenticator 객체 생성 -> 인증값 저장
	Authenticator auth = new GoogleAuthentication();
	// Session 객체 생성
	Session s = Session.getDefaultInstance(properties, auth);
	// Message 객체 생성
	Message message = new MimeMessage(s);
	
	// 발송자 정보 저장
	Address sender_address = new InternetAddress(sender);
	// 수신자 정보 저장
	Address receiver_address = new InternetAddress(receiver);
	message.setHeader("content-type", "text/html;charset=UTF-8");
	message.setFrom(sender_address);
	message.addRecipient(Message.RecipientType.TO, receiver_address);
	message.setSubject(subject);
	message.setContent(content, "text/html;charset=UTF-8");
	message.setSentDate(new Date());
	
	//전송
	Transport.send(message);
	
} catch(Exception e) {
	out.println("SMTP 서버 잘못 설정 / 서비스 문제 발생");
	e.printStackTrace();
}
%>
<script type="text/javascript">
	alert("메일 전송중")
	alert("메일 전송이 완료되었습니다");
	location.href = "../main/main.jsp";
</script>
</body>
</html>