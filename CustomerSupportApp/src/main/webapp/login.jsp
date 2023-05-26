<%@page import="net.etfbl.ip.beans.UserBean"%>
<%@page import="net.etfbl.ip.services.LoginManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="userBean" class="net.etfbl.ip.beans.UserBean" scope="session"></jsp:useBean>
<jsp:setProperty property="username" name="userBean" param="username" />
<jsp:setProperty property="password" name="userBean" param="password" />

<!DOCTYPE html>
<%
	if(request.getParameter("submit") != null) {
		UserBean u = LoginManager.getLoginManager().loginUser(userBean.getUsername(), userBean.getPassword());
		if(u != null) {
			userBean.setId(u.getId());
			userBean.setFirstName(u.getFirstName());
			userBean.setLastName(u.getLastName());
			userBean.setLoggedIn(true);
			session.setAttribute("notification", "");
			response.sendRedirect("messages.jsp");
		} else {
			session.setAttribute("notification", "Wrong username or password! Please enter your username and password again.");
			userBean.setLoggedIn(false);
		}
	} else {
		session.setAttribute("notification", "");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Rowdies:wght@300&display=swap" rel="stylesheet">
	<link href="styles/style.css" rel="stylesheet">
</head>
<body class="background-radial-gradient">
	
	<div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
    <div class="row gx-lg-5 align-items-center mb-5">
      <div class="col-lg-6 mb-5 mb-lg-0" style="z-index: 10">
        <h1 class="my-5 display-5 fw-bold ls-tight" style="color: hsl(218, 81%, 95%)">
          Customer support application <br />
          <span style="color: hsl(218, 81%, 75%)">Internet Programming</span>
        </h1>
        <p class="mb-4 opacity-70" style="color: hsl(218, 81%, 85%)">
          <%=session.getAttribute("notification")%>
        </p>
      </div>

      <div class="col-lg-6 mb-5 mb-lg-0 position-relative">
        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

        <div class="card bg-glass">
          <div class="card-body px-4 py-5 px-md-5">
            <form method="post" action="login.jsp">
              
              <!-- Username input -->
              <div class="form-outline mb-4">
                <input type="text" name="username" id="username" class="form-control" required/>
                <label class="form-label" for="username">Username</label>
              </div>

              <!-- Password input -->
              <div class="form-outline mb-4">
                <input type="password" name="password" id="password" class="form-control" required/>
                <label class="form-label" for="password">Password</label>
              </div>

              <!-- Submit button -->
              <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">
                Login
              </button>

            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>