<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="user" class="member.Member" scope="page" />
<jsp:setProperty property="*" name="user" />
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
	
	if(user.getUserID() ==  null || user.getUserPassword() == null || user.getUserName()== null
		|| user.getUserGender() == null || user.getUserEmail() == null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
		script.println("history.back()");
		script.println("</script>");		
	} else {
		MemberDAO memberDAO = new MemberDAO();
		int result = memberDAO.join(user);
	
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