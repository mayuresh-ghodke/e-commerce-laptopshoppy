<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Forgot Password</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<style>		
		a {
		  text-decoration: none;
		}
		body {
		  background-repeat: no-repeat;
		}
		label {
		  font-family: "Raleway", sans-serif;
		  font-size: 13pt;
		}
		#forgot-pass {
		  font-family: "Raleway", sans-serif;
		  font-size: 10pt;
		  margin-top: 3px;
		  text-align: right;			
	</style>	
</head>
	<body>
	
		<%@include file="navbar.jsp" %>
	
	  <div class="container">
	  	<div class="row justify-content-center mt-5">
	    	<div class="col-md-6">
	        	<div class="card">
	            	<div class="card-header bg-light text-dark text-center">
	                	<h3>Forgot Password</h3>
	                </div>
	                    
	                <%@include file="component/message.jsp" %>
		      		
		      		<form action="ForgotPassword" method="post" class="form">	      		
			      		<div class="card card-body">	      	 			
				     		<div class="form-group mt-3">
									<label for="name">Enter Email</label>
									<input type="text" name="useremail" class="form-control" id="name" placeholder="Enter Your Email" required>
							</div>
							<div class="form-group">
								<label for="email">Enter New Password</label>
								<input type="text" name="newpassword" class="form-control" id="email" placeholder="Enter Your Password" required>
							</div>
						</div>			
								
						 <div class="card card-footer">
					        <button class="btn btn-primary">Change Password</button>
					        <button class="btn btn-dark text-white mt-3" ><a href="login.jsp" class="text-white" style="text-decoration:none">Go To Login</a></button>
					     </div>		      	
		      		</form>
		      </div>
		    </div>  
	    </div>
  	</div>
  		<%@include file="footer.jsp" %>
	</body>
</html>