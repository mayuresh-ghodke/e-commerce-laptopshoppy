
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.db.DbConnection"%>
<%@page import="java.util.List"%>
<%@page import="javax.servlet.ServletException" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpServletResponse" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
        
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Order View</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>	
		<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">	
		<%@include file="component/common-js-css.jsp" %>
		<style type="text/css">
		.product-row {
    border-bottom: 1px solid #ddd;
}

.product-image-cell {
    width: 20%;
    padding: 10px;
    vertical-align: middle;
}

.product-details-cell {
    width: 80%;
    padding: 10px;
    vertical-align: middle;
}

.product-image {
    max-width: 100%;
    border-radius: 6px;
}

.product-title {
    font-size: 1.5rem;
    margin-top: 0;
    margin-bottom: 10px;
}

.product-description {
    font-size: 1rem;
    color: #555;
    margin-bottom: 15px;
}

.product-price-value {
    font-size: 1.2rem;
    font-weight: bold;
    color: #e74c3c; /* Red color for price */
    margin-right: 20px;
}

.product-quantity-value {
    font-size: 1.2rem;
    font-weight: bold;
    color: #3498db; /* Blue color for quantity */
}


		</style>
		
    </head>
    <body class="bg-light">  
        <%@include  file="navbar.jsp" %>
        
        <% 
        User currentUser = (User) session.getAttribute("userObj");
        
        
        UserDao userdao = new UserDao(DbConnection.getConn());
        int currentUserId = userdao.getUserId(user.getUserEmail());
        
        CartDao cartDao = new CartDao(DbConnection.getConn());
        List<Cart> cartItems = cartDao.getCartItems(currentUserId); // Retrieve all cart items for the user
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        
        String productTitle = request.getParameter("productTitle");
        
        String price = request.getParameter("orderPrice");
        int productPrice = Integer.parseInt(price);
        
        String quantity = request.getParameter("orderQty");
        int productQuantity = Integer.parseInt(quantity);
               
    %>
	<div class="container p-5">
		<div class="card">
			<div class="card-body">
				<h5><b>Congratulations </b>dear <%= user.getUserName() %>, </h5><br>
				Your Order <span class="font-weight-bold"><i>order number <%= orderId %></i></span> has been successfully placed for <span class="font-weight-bold"><%= productTitle %></span> of <span class="font-weight-bold"> <%= productQuantity %> qunatity </span>, and price <span class="font-weight-bold"><%= productPrice %></span>
			</div>	
		</div>
		
		<h5 class="text-center mt-3">Thank you for shopping with us. <a href="index.jsp#sectionId" class="text-dark"> Continue Shopping</a></h5>
	</div>
	
    </body>
</html>
