<%@page import="fileboard.FileBoardBean"%>
<%@page import="fileboard.FileBoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String uploadPath = request.getRealPath("/upload");
int maxSize = 10*1024*1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8", new DefaultFileRenamePolicy());

int num = Integer.parseInt(multi.getParameter("num"));
String location = multi.getParameter("location");
String category = multi.getParameter("category");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");
int image = Integer.parseInt(multi.getParameter("image"));

if(file==null) { // 기존 파일이름 유지
	file = multi.getParameter("oldfile"); // 히든 -> getParameter
} else { // 파일이 수정된 경우
	String[] fileNames = file.split("\\.");
	String extension = fileNames[fileNames.length-1]; //확장자
	if(extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp")){
		image = 1;
	} else {
		image = 0;
	}
}

FileBoardDAO bdao = new FileBoardDAO();

FileBoardBean bb = new FileBoardBean();
bb.setNum(num);
bb.setLocation(location);
bb.setCategory(category);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);
bb.setImage(image);

bdao.fileUpdateBoard(bb);
%>
<script type="text/javascript">
	alert("수정되었습니다");
	location.href="content.jsp?num=<%=num %>";
</script>
</body>
</html>