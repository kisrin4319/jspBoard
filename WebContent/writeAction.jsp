<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty property="*" name="bbs" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID== null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하셔야합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	else{
		if(bbs.getTitle()==null || bbs.getContent()==null){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");		
		} else {
			bbs.setDatetime(new Timestamp(System.currentTimeMillis()));
			bbs.setUserid(userID);
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs); 
		
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'board.jsp'");
				script.println("</script>");
			}
		}
	}
		%>
</body>
</html>