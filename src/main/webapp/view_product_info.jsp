
<%               	
   User userMore = (User) session.getAttribute("userObject");	    		    	
%>
<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.Review"%>
<%@page import="com.mypackage.dao.ReviewDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DbConnection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Review</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://kit.fontawesome.com/b982f6e503.js" crossorigin="anonymous"></script>
<!-- Other scripts and your custom script go here -->
<style>
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
        /* Add the following styles to styles.css */
		.star-1, .star-2, .star-3, .star-4, .star-5 {
			cursor:pointer;
    		color: gold;
		}
		.star-1, .star-2, .star-3, .star-4, .star-5 :hover{
			cursor:pointer;
    		
		}
		
        
		
	
</style>
</head>
<body class="bg-light">

	<%
			
			
	
			ProductDao productDao = new ProductDao(DbConnection.getConn());
	
			int productId = Integer.parseInt(request.getParameter("productId"));
			
			Product product = productDao.getProductById(productId);
			
			
	%>
    <%@include file="navbar.jsp" %>
    
    <div class="container p-5">
    <div class="card ">
        <div class="row m-3">
            <div class="col-md-4">
                <img src="Images/<%= product.getProductFile() %>" width="250px" height="250px">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <h3 class="mt-3 font-weight-bold"><%= product.getProductTitle() %></h3>
                </div>
                <div class="row">
                    <h5 class="mt-3 "><%= product.getProductDescription() %></h5>
                </div>
                <div class="row">
                    <h5 class="mt-3 "><h4 class="mt-3 font-weight-bold">Rs. <%= product.getProductPrice() %></h4></h5>
                </div>
                <div class="row">
                	<!-- Review Part Start -->
                	
									<%
										ReviewDao rdao = new ReviewDao(DbConnection.getConn());
									    int pId = product.getProductId();
										Review review = rdao.getReviewByProductId(pId);
									%>				
									<% int ratingCount =  review.getRatingCount(); %>
									<div>
									  <% for (int i = 1; i <= 5; i++) { %>
									    
									    <% if (i <= ratingCount) { %>
									      <span style="color:gold" class="gold-star">&#9733;</span>
									    <% } else { %>
									      <span class="empty-star">&#9734;</span>
									    <% } %>
									  <% } %>
									</div>
									<!-- Review Part End -->
                </div>
                
                <div class="row"><%= review.getComment() %></div>
            </div>
        </div>
    </div>
</div>

      <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
<script>
	
</script>
</body>
</html>