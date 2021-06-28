<%@page import="fileboard.FileBoardDAO"%>
<%@page import="fileboard.FileBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String uploadPath = request.getRealPath("/upload"); // 물리적 경로
int maxSize = 10*1024*1024; // 10MB

MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

String id = (String)session.getAttribute("id");
String name = (String)session.getAttribute("name");

String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String category = multi.getParameter("category");
String location = multi.getParameter("location");
Timestamp date = new Timestamp(System.currentTimeMillis());
String file = multi.getFilesystemName("file");
int isImage = 0;

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
if(category.length() < 1) {
	%>
	<script type="text/javascript">
		alert("분류를 선택해주세요");
		history.back();
	</script>
	<%
	return;
}
if(location.length() < 1) {
	%>
	<script type="text/javascript">
		alert("지역을 선택해주세요");
		history.back();
	</script>
	<%
	return;
}

if(file!=null){ //파일이 있는 경우 이미지 체크
	String[] fileNames = file.split("\\.");
	String extension = fileNames[fileNames.length-1]; //확장자
	if(extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp")){
		isImage = 1;
	} else {
		isImage = 0;
	}
}

FileBoardBean bb = new FileBoardBean();
bb.setId(id);
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);
bb.setCategory(category);
bb.setLocation(location);
bb.setReadcount(0);
bb.setDate(date);
bb.setFile(file);
bb.setImage(isImage);

FileBoardDAO bdao = new FileBoardDAO();
bdao.fileInsertBoard(bb);

%>
<script type="text/javascript">
alert("글이 등록되었습니다");
location.href = "../reviewboard/list.jsp";
</script>
</body>
</html>