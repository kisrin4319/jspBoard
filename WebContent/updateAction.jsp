<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="bbs.*"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("EUC-KR"); %>
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
	
	if(userID== null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�α����� �ϼž��մϴ�.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}

	int numb= 0;
	if(request.getParameter("numb")!=null){
		numb = Integer.parseInt(request.getParameter("numb"));
	}
	if(numb == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('��ȿ���� ���� ���Դϴ�.')");
		script.println("location.href = 'board.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(numb);
	if(!userID.equals(bbs.getUserid())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('������ �����ϴ�.')");
		script.println("location.href = 'board.jsp'");
		script.println("</script>");
	}
		
	else{
		if(request.getParameter("title")==null || request.getParameter("content")==null
				|| request.getParameter("title").equals("") || request.getParameter("content").equals("")){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
			script.println("history.back()");
			script.println("</script>");		
		} else {
			bbs.setUserid(userID);
			bbs.setTitle(request.getParameter("title"));
			bbs.setContent(request.getParameter("content"));
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.update(bbs); 
		
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�� ������ �����߽��ϴ�.')");
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