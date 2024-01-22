<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mypackage.dao.OrderDao"%>
<%@page import="com.db.DbConnection"%>
<%@ page import="com.mypackage.entity.Order" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
    <%@include file="navbar.jsp" %>
    
    
    
    <% 
        User currentUser = (User) session.getAttribute("userObj");
        
        
        UserDao userdao = new UserDao(DbConnection.getConn());
        int currentUserId = userdao.getUserId(user.getUserEmail());
        
        OrderDao orderDao = new OrderDao(DbConnection.getConn());
        List<Order> orderItems = orderDao.getOrders(currentUserId); // Retrieve all cart items for the user
        
    %>
    
    <div class="container-fluid  text-center col-md-12" style="width:90%;">
    
    <h2 class=" p-3 font-weight-bold">

    Order History</h2><hr></div>
    
    <div class="container text-left mt-5 mb-5" style="width:90%;">
    	<h5>Total orders: <%= orderItems.size() %></h5>
    </div>
    
    
    
    <div class="container bg-white">
    
    <% if (orderItems.isEmpty()) { %>
    	<h3 class="text-center mt-5"><b>You have not made any order yet.</b></h3>
        <div class="text-center">
        	
            <img src="Images/empty_orders.jpeg" height="300px" width="550px">
        </div>
    <% } else { %> 
        <table class="table table-hover">
    
    <tbody>
    <!-- Loop through each order and generate a table row -->
    <% for (Order order : orderItems) { %>
        <tr>
        	<tr>
        		<td colspan="5"  class="font-weight-bold">Order Id: #<%= order.getOrderId() %></td>
        	</tr>
        	<tr>
        		<td colspan="5" class="font-weight-bold"><h3><%= order.getProductTitle() %></h3></td>   		
        	</tr>
        	
        	<tr>       		
        		<td>Ordered Date:<br>
        		<%= order.getDate() %></td>
        		<td>Qty:<br>
        		<%= order.getQuantity() %></td>
        		<td>Total:<br>
        		Rs.<%= order.getTotalPrice() %></td>
        		<td><button class="btn btn-outline-info">Cancel Order</button></td>
        		<tr><td><h6 class="text-warning">Your Order will be delivered within ... days.</h6></td></tr>
        		
        		<tr><td><a href="review.jsp?productId=<%= order.getProductId() %>&userId=<%=currentUserId %>">Write Review</a></td></tr>
        		
            <td>
                <div class="accordion" id="accordion<%= order.getOrderId() %>">
                    <div class="card bg-white">
                        <div class="card-header bg-white" id="heading<%= order.getOrderId() %>">
                            <h2 class="mb-0">
                                <a href="#collapse<%= order.getOrderId() %>" class="btn btn-primary"
                                   role="button" data-toggle="collapse"
                                   aria-expanded="false" aria-controls="collapse<%= order.getOrderId() %>">
                                    View Details
                                </a>
                            </h2>
                        </div>
                        <div id="collapse<%= order.getOrderId() %>" class="collapse"
                             aria-labelledby="heading<%= order.getOrderId() %>"
                             data-parent="#accordion<%= order.getOrderId() %>">
                            <div class="card-body">
                                
                                <table>
                                    <tr><td>Payment Mode: </td></tr>
                                    <tr><td>Payment Status: </td></tr>
                                    <tr><td>Track Order: </td></tr>
                                    <tr><td>Order Status: </td></tr>                                    
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        
    <% } %>
</tbody>

</table>

    <% } %>
</div>
	
	<%@include file="footer.jsp" %>
</body>
</html>