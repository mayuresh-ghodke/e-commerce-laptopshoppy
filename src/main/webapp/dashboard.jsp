
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.db.DbConnection"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
        <%               	
    		User user4 = (User) session.getAttribute("userObject");
		    if (user4 == null)
		    {
		        session.setAttribute("message", "You are not logged in !! Login first to access checkout page");
		        response.sendRedirect("login.jsp");
		        return;
		    }		    		    	
		%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>		
		<%@include file="component/common-js-css.jsp" %>
		
    </head>
    <body>  
        <%@include  file="navbar.jsp" %>
    
        <div class="container">
            <div class="row mt-2">                

                <div class="col-md-12 ml-5">
                    <!--form details-->
                    <!--card-->
                    <div class="card">
                        <div class="card-body">
                        	<%@include file="component/message.jsp" %>
                        	<h3 class="text-center mb-5">Personal Information</h3>
                        	
                        		<form class="form" action="DashboardServlet" method="post">
                        			                        	
		                        	<div class="row">
		                        		<div class="col-6">
		                        		<div class="form-group">
		                                    <label for="name">Name</label>
		                                    <input value="<%= user4.getUserName() %>" name="name" type="text" class="form-control" aria-describedby="emailHelp">
                                		</div>
                                		<div class="form-group">
		                                    <label for="exampleInputEmail1">Email Information</label>
		                                    <input value="<%= user4.getUserEmail() %>" name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" disabled>
		                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                		</div>
		                        		<div class="form-group">
		                                    <label for="name">Contact Information</label>
		                                    <input value="<%= user4.getUserPhone() %>" name="contact" type="text" class="form-control"  aria-describedby="emailHelp" placeholder="Contact Information">
                                		</div>
		                    		 </div>
		                        	
		                        	<div class="col-6">
		                        		<div class="form-group">
		                                    <label for="name">My Password</label>
		                                    <input value="<%= user4.getUserPassword() %>" name="password" type="password" class="form-control" id="name" aria-describedby="emailHelp" placeholder="My Password">
                                		</div>
		                        		<div class="form-group">
		                                    <label for="exampleFormControlTextarea1" >Address Information</label>
		                                    <textarea value="<%= user4.getUserAddress() %>" name="address" class="form-control" id="exampleFormControlTextarea1" placeholder="Address Information" rows="3"></textarea>
		                                </div>
		                                <div class="text-center">
		                    				<button class="btn btn-warning" type="submit">Update</button>		                                    
		                				</div>		                              
									</div>
		                        </div>	
		                       	                        	
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>

        </div>


        <%@include file="footer.jsp" %>
		
		<!-- Here include cart modal jsp file -->
		<%@include file="component/common-cart-modal.jsp" %>
    </body>
</html>
