<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="user" class="member.Member" scope="page" />
<jsp:setProperty property="userID" name="user" />
<jsp:setProperty property="userPassword" name="user" />
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
		
		MemberDAO memberDAO = new MemberDAO();
		int result = memberDAO.login(user.getUserID(), user.getUserPassword());
	
		if(result == 1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��й�ȣ�� Ʋ���ϴ�.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�������� �ʴ� ���̵��Դϴ�.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�����ͺ��̽� ������ �߻��߽��ϴ�.')");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
</body>
</html>