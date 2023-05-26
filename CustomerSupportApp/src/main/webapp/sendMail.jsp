<%@page import="net.etfbl.ip.services.MailManager"%>
<%@page import="net.etfbl.ip.dto.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="net.etfbl.ip.beans.MessagesBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="userBean" class="net.etfbl.ip.beans.UserBean" scope="session"></jsp:useBean>
<jsp:useBean id="messagesBean" class="net.etfbl.ip.beans.MessagesBean" scope="session"></jsp:useBean>

<!DOCTYPE html>

<%

	if(!(userBean.isLoggedIn())) response.sendRedirect("login.jsp");

	String action = request.getParameter("action");
	List<Message> messages = new ArrayList<>();
	
	if(action == null || "getAllMessages".equals(action)) {
		
		messages = messagesBean.getAllMessages();
		
	}
	
	if("updateMessage".equals(action) && (request.getParameter("id") != null)) {
		
		messagesBean.checkAsRead(Integer.parseInt(request.getParameter("id")));
		messages = messagesBean.getAllMessages(); 
		
	}
	
	if(request.getParameter("submit") != null) {
		
		String receiver = request.getParameter("receiver");
		String content = request.getParameter("content");
		
		if(MailManager.getMailManager().sendMail(receiver, content)) {
			
			session.setAttribute("notification", "Mail is sent!");		
			
		} else {
			
			session.setAttribute("notification", "Error! Check your internet connection!");
			
		}
			
	} else {
			
		if (request.getParameter("id") != null) {
				
			session.setAttribute("notification", "");
			Message message = messagesBean.getMessageById(Integer.parseInt(request.getParameter("id")));
			session.setAttribute("receiver", message.getMail());
			session.setAttribute("messageFromUser", message.getContent());
				
		}
		else {
				
			response.sendRedirect("Messages.jsp");
				
		}
		
	} 

%>

<html>
<head>
<meta charset="UTF-8">
<title>Replay with mail</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Rowdies:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
<link href="styles/sendMailStyle.css" rel="stylesheet">

</head>
<body onload="init()">

<div class="container px-4 py-4 px-md-3 text-center text-lg-start my-2">
    <div class="row gx-lg-5 align-items-center mb-5">

      <div class="col-lg-12 mb-5 mb-lg-0 position-relative">
        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

        <div class="card bg-glass">
          <div class="card-body px-4 py-3 px-md-5">
            <form method="post" action="sendMail.jsp">
              
              <!-- Message from user -->
              <div class="form-outline mb-4">
              	<label class="form-label" for="message-from-user">Message from user:</label>
                <label for="message-from-user" id="message-from-user" class="form-control"><%=session.getAttribute("messageFromUser")%></label>
              </div>
              
               <!-- Response -->
			  <div class="form-outline mb-4">
              	<label class="form-label" for="content">Response:</label>
                <textarea name="content" id="content" class="form-control"></textarea>
              </div>

              <!-- Sender -->
              <div class="form-outline mb-4">
              	<label class="form-label" for="sender">From:</label>
                <input type="text" name="sender" id="sender" class="form-control" value="Customer support" readonly/>
              </div>
              
              <!-- Receiver -->
              <div class="form-outline mb-4">
              	<label class="form-label" for="receiver">To:</label>
                <input type="text" name="receiver" id="receiver" class="form-control" value="<%=session.getAttribute("receiver")%>" readonly/>
              </div>
             				
              <p class="mail-notification"><%=session.getAttribute("notification")%></p>
              
              <div class="response-buttons">
              	<!-- Back button -->
              	<a class="btn btn-outline-secondary btn-block mb-4" href="messages.jsp">Back</a>
              	<!-- Submit button -->
              	<button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Send</button>
              </div>
              
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>