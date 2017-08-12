<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import  ="java.io.PrintWriter" %>
<%@ page import = "bbs.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale ="1">
<link rel = "stylesheet" href="css/bootstrap.css">
<title>JSP �Խ��� �� ����Ʈ</title>
</head>
<body>
	<%
	
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���.')");
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
	
	%>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
		<button type="button" class = "navbar-toggle collapsed"
			 data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			 aria-expanded = "false">
			 <span class = "icon-bar"></span>
			 <span class = "icon-bar"></span>
			 <span class = "icon-bar"></span>
			 </button>
		<a class = "navbar-brand" href = "main.jsp">JSP �Խ��� �� ����Ʈ</a>
		</div>
		<div class ="collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href="main.jsp">����</a></li>
				<li class ="active"><a href="board.jsp">�Խ���</a></li>
			</ul>
			<ul class ="nav navbar-nav navbar-right">
				<li class = "dropdown">
				<a href="#" class ="dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded ="false">ȸ������<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "logoutAction.jsp">�α׾ƿ�</a></li>
					</ul>
				</li>
			</ul>			
		</div>
	</nav>
	<div class ="container">
		<div class ="row">
			<form method="post" action="updateAction.jsp?numb=<%= numb %>">
			<table class ="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;"> �Խ��� �۾��� ��� </th>
				</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder  ="�� ����" name="title" maxlength="50" value ="<%=bbs.getTitle()%>"></td>
					</tr>
					<tr>	
						<td><textarea class="form-control" placeholder  ="�� ����" name="content" maxlength="2048" style="height: 350px;"><%=bbs.getContent() %></textarea></td>
					</tr>				
				</tbody>				
			</table>
				<input type ="submit" class="btn btn-primary pull-right" value ="�۾���" >
			</form>			
		</div>
	</div>
 <script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src = "js/bootstrap.js"></script>
</body>
</html>