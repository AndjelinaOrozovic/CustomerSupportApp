<%@page import="org.apache.naming.factory.SendMailFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="net.etfbl.ip.dto.Message"%>
<%@page import="net.etfbl.ip.beans.MessagesBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="userBean" class="net.etfbl.ip.beans.UserBean" scope="session"></jsp:useBean>
<jsp:useBean id="messagesBean" class="net.etfbl.ip.beans.MessagesBean" scope="session"></jsp:useBean>

<!DOCTYPE html>

<%
	if(!userBean.isLoggedIn()) response.sendRedirect("login.jsp");

	String action = request.getParameter("action");
	
	List<Message> messages = new ArrayList<>();
	
	if(action == null || "getAllMessages".equals(action)) {
		
		messages = messagesBean.getAllMessages();
		
	} else if("getAllUnreadMessages".equals(action)) {
		
		messages = messagesBean.getAllUnreadMessages();
		
	} else if("updateMessage".equals(action) && (request.getParameter("id") != null)) {
		
		messagesBean.checkAsRead(Integer.parseInt(request.getParameter("id")));
		messages = messagesBean.getAllMessages(); 
		
	} else if("searchMessages".equals(action) && (request.getParameter("search-messages") != null)) {
		
		messages = messagesBean.getSearchedMessages(request.getParameter("search-messages"));
		
	}
%>

<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Messages</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Rowdies:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
<link href="styles/messagePageStyle.css" rel="stylesheet">

</head>
<body onload="init()">
	<header>
		<nav>
			<div class="d-flex flex-md-row align-items-center pb-3 border-bottom customer-header">
				<div>
					<a class="navbar-brand" href="#">
        				<img src="https://cdn-icons-png.flaticon.com/512/237/237131.png" height="25" alt="MDB Logo"/>
        			</a> 
        			<span> Customer support application</span>
        		</div>
      			<div>
      				<%=userBean.getFirstName()%> <%=userBean.getLastName()%>
					<a class="btn btn-outline-secondary" href="logout.jsp"> Log out</a>	
      			</div>
      		
				
			</div>
		</nav>
		<nav class="navbar navbar-expand-lg navbar-light bg-light customer-navbar">
			<div>
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="btn btn-light btn-outline-secondary navbar-btn-margin" href="messages.jsp?action=getAllMessages">View all messages</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-light btn-outline-secondary navbar-btn-margin" href="messages.jsp?action=getAllUnreadMessages">View unread messages</a>
					</li>
				</ul>
			</div>
			<div>
				<form method="post" action="messages.jsp?action=searchMessages">
					<div class="input-group navbar-btn-margin">
  						<div class="form-outline">
    						<input type="search" placeholder="Search messages" id="search-messages" name="search-messages" required class="form-control"/>
  						</div>
  						<button class="btn btn-primary" type="submit">
    						<i class="bi bi-search"></i>
  						</button>
					</div>
				</form>
			</div>
		</nav>
	</header>
	<section>
		<table class="table table-hover table-messages">
			<thead>
				<tr>
					<th scope="col">Message id</th>
					<th scope="col">Sender</th>
					<th scope="col">Message</th>
					<th scope="col">Date and time</th>
					<th scope="col">Is read</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Message m : messages) {
						
						String styleClass = "unopened";
						
						if(m.isRead()) {
							styleClass = "opend";
						}
				
						out.println("<tr class=\"" + styleClass + "\"><th scope=\"row\">" + m.getId() + "</th>");
						out.println("<td id=\"tdTable\" class=\"" + styleClass + "\">" + m.getUsername() + "</td>");
						out.println("<td id=\"message-content\"\">" + m.getContent() + "</td>");
						out.println("<td class=\"" + styleClass + "\">" + m.getDateAndTime() + "</td>");
						if(m.isRead()) {
							out.println("<td class=\"" + styleClass+  "\"><a href=\"sendMail.jsp?action=updateMessage&id=" + m.getId() + "\">Open</a></td>");
						} else {
							out.println("<td class=\"" + styleClass + "\"><a href=\"sendMail.jsp?action=updateMessage&id=" + m.getId() + "\">Open</a></td>");
						}
					}
				%>
			</tbody>
		</table>
	</section>
</body>
</html>