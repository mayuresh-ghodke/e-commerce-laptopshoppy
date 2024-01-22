<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Admin Login</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>	
	
</head>
	<body class="bg-light">
	
		<div class="container">
	        <div class="row justify-content-center mt-5">
	            <div class="col-md-6">
	                <div class="card">
	                    <div class="card-header bg-primary text-white text-center">
	                        <h3 class="font-weight-bold">Admin Login</h3>
	                    </div>
	                    
	                    <%@include file="../component/message.jsp" %>
	                    
	                    <div class="card-body">
	                        <form action="../AdminLoginServlet" method="get">
	                            <div class="form-group">	                                
	                                <input type="text" class="form-control" id="username" name="adminusername" placeholder="admin@gmail.com" required>
	                            </div>
	                            <div class="form-group">	                                
	                                <input type="password" class="form-control" id="password" name="adminpassword" placeholder ="Password" required>
	                            </div>
	                            <button type="submit" class="btn btn-primary btn-block">Login</button>
	                            <button type="reset" class="btn btn btn-block">Clear</button>
	                        </form>
	                    </div>
	                    
	                </div>
	                <div class="text-center mt-5 font-weight-bold">
	                	<a href="../index.jsp" >Go To Home Page</a>
	                </div>
	                 
	            </div>
	           
	        </div>
	    </div>
	</body>
</html>