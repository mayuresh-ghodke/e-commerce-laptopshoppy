
<%               	
   User user1 = (User) session.getAttribute("userObject");	    		    	
%>
<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.ProductDao"%>
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
			
			UserDao userdaoForReview = new UserDao(DbConnection.getConn());
	        int currentUserIdForReview = userdaoForReview.getUserId(user1.getUserEmail());
			
			
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
            </div>
        </div>
        <div class="row mr-2 float-left">
        	<div class="col-md-4"></div>
            <div class="col-md-8">
                <form action="ReviewServlet" method="post" id="reviewForm" class="form-group">
                	<input type="hidden" id="userId" name="userId" value="<%= currentUserIdForReview%>">
                	<input type="hidden" id="productId" name="productId" value="<%= product.getProductId() %>">
                	<label class="mt-3" for="comment">Rate your experience:</label>
				    <div class="star-rating" onclick="rateProduct(event)">
				        <i id="star1" class="fas fa-star" data-value="1"></i>
				        <i id="star2" class="fas fa-star" data-value="2"></i>
				        <i id="star3" class="fas fa-star" data-value="3"></i>
				        <i id="star4" class="fas fa-star" data-value="4"></i>
				        <i id="star5" class="fas fa-star" data-value="5"></i>
				    </div>
				    <input type="hidden" id="ratingValue" name="rating" value="">				    
					<label class="mt-3" for="comment">Write your product experience:</label>
                    <textarea id="comment" name="comment" rows="4" cols="50" class="form-control" required></textarea>
                    <button type="submit" class="text-dark btn btn-warning mt-3">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

      <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
<script>
	function rateProduct(event) {
	    const selectedStar = event.target;
	    if (selectedStar.classList.contains('fa-star')) {
	        const ratingValue = selectedStar.getAttribute('data-value');
	
	        // Update the hidden input value
	        document.getElementById('ratingValue').value = ratingValue;
	
	        // Reset all stars to default color
	        const stars = document.querySelectorAll('.fa-star');
	        stars.forEach((star, index) => {
	            star.style.color = index < ratingValue ? 'gold' : 'black';
	        });
	    }
	}
	
	$(document).ready(function () {
	    console.log("Page is ready....");

	    $("#reviewForm").on('submit', function (event) {
	        // stop the default form submission behavior
	        event.preventDefault();

	        $(".loader").show();
	        $(".form").hide();

	        $.ajax({
	            url: 'ReviewServlet',
	            data: $(this).serialize(), // Serialize form data directly
	            type: 'POST',
	            success: function (data, textStatus, jqXHR) {
	                console.log(data);

	                if (data.trim() === "RegisterSuccess") {
	                    $("#msg").load("component/message.jsp");
	                    alert("Review Submitted.");
	                    window.location.href = "my-order-history.jsp";
	                } else {
	                    $("#msg").load("component/message.jsp");
	                    alert("Review Submission Done.");
	                    window.location.href = "my-order-history.jsp";
	                }
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR.responseText); // log the response text
	                console.log("Error");

	                $("#msg").load("component/message.jsp");
	                alert("Review Submission Failed");
	                window.location.href = "my-order-history.jsp";

	                $(".loader").hide();
	                $(".form").show();
	            }
	        });
	    });
	});

</script>
</body>
</html>