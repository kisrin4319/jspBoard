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
<title>JSP �Խ��� �� ����Ʈ</title>
</head>
<body>

	<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID!= null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�̹� �α����� �Ǿ��ֽ��ϴ�.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	if(bbs.getTitle()==null || bbs.getContent()=null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
		script.println("history.back()");
		script.println("</script>");		
	} else {
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getTitle(), userID, bbs.getContent())
	
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�̹� �����ϴ�  ���̵��Դϴ�.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	}
		%>
</body>
</html>