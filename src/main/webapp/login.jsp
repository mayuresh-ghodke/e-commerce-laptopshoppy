
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>User Login</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
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
		}
		.show-pass {
		  font-family: "Raleway", sans-serif;
		  font-size: 10pt;
		  margin-top: 3px;
		  text-align: left;
		}
		label {
            display: block;
            margin-bottom: 8px;
        }

        input,
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }
		
	</style>
	
	
</head>
	<body class="bg-light">
	
		<%@include file="navbar.jsp" %>
	
	  <div class="container">
	  	<div class="row justify-content-center mt-5">
	    	<div class="col-md-6">
	        	<div class="card">
	            	<div class="p-2  bg-white text-dark text-center">
	                	<h3 class="font-weight-bold p-3">Login</h3>
	                </div>
	                    
	                <div id="msg"></div>
		      		
		      		<form action="LoginServlet" method="post" class="form" id="loginform">	  
		      			<div class="container"><hr></div>   		
			      		<div class="p-3">	      	 			
				     		<div class="form-group mt-3">
									
									<input type="text" name="username" id="email" placeholder="example@gmail.com" required>
							</div>
							<div class="form-group">
									
									<input type="password" name="userpassword" id="pass" placeholder="Password" required>
							</div>
							<a href="forgot-password.jsp">
          						<legend id="forgot-pass">Forgot password?</legend>
        					</a>
						</div>					
						 <div class="card card-footer bg-white">
					        <button>Login</button>
					        <button class="btn  mt-3" type="reset">Clear</button>
					        <p class="mt-3 text-center">Don't have an account?<a href="register.jsp"> Register here</a></p>
					     </div>		      	
		      		</form>
		      </div>
		    </div>  
	    </div>
  	</div>
  	
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  	
  	
  		
  		
	</body>
</html>