<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import  ="java.io.PrintWriter" %>
<%@ page import = "bbs.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale ="1">
<link rel = "stylesheet" href="css/bootstrap.css">
<title>JSP �Խ��� �� ����Ʈ</title>
<style type="text/css">
	a, a:hover {
	color: #000000;
	text-decoration: none;
</style>
</head>
<body>
	<%
		String userID = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(session.getAttribute("userID")!= null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<%
			
				if(userID == null){			
			%>
			<ul class ="nav navbar-nav navbar-right">
				<li class = "dropdown">
				<a href="#" class ="dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded ="false">�����ϱ�<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "login.jsp">�α���</a></li>
						<li><a href = "join.jsp">ȸ������</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			
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
			<%
				}
			%>
		</div>
	</nav>
	<div class ="container">
		<div class ="row">
			<table class ="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">��ȣ</th>
						<th style="background-color: #eeeeee; text-align: center;">����</th>
						<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
						<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					if(list.size()!=0){
					for(int i = 0; i<list.size(); i++){
						
				%>
				<tr>
					<td><%=list.get(i).getNumb() %></td>
					<td><a href ="view.jsp?numb=<%=list.get(i).getNumb() %>"><%=list.get(i).getTitle() %></a></td>
					<td><%=list.get(i).getUserid() %></td>
					<td><%=sdf.format(list.get(i).getDatetime())%></td>
				</tr>
				<%		
					}
				} else {
				%>
				<td colspan="4"> ��ϵ� �Խñ��� �����ϴ�.</td>
				<%} %>
				</tbody>
			</table>
			<%
				if(pageNumber!=1){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arrow-left">����</a>
			<%
				} if(bbsDAO.nextPage(pageNumber+1)) {
			%> 
				<a href="board.jsp?pageNumber=<%=pageNumber+1 %>" class ="btn btn-success btn-arrow-left">����</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">�۾���</a>
		</div>
	</div>
 <script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src = "js/bootstrap.js"></script>
</body>
</html>