<%@page import="com.mypackage.dao.admin.AdminDao"%>
<%@page import="com.mypackage.admin.entity.Admin"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="com.mypackage.entity.Order"%>
<%@page import="com.mypackage.dao.OrderDao"%>
<%@page import="com.db.DbConnection"%>
<%@page import="java.util.List"%>
<%@page import="com.mypackage.entity.User"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Admin: View Orders</title>
		<link rel="stylesheet"
			href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<script
			src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
		<link rel="stylesheet"
			href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
			integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
			crossorigin="anonymous">
		<script src='https://kit.fontawesome.com/a076d05399.js'
			crossorigin='anonymous'></script>
		<%@include file="../component/common-js-css.jsp"%>
		<style type="text/css">
			.card {
				cursor: pointer;
				border-radius: 30px;
			}
			#mytable:hover{
				cursor:pointer;
			}
		</style>
	</head>
	<body class="bg-light">
    <% 
    	UserDao userDao = new UserDao(DbConnection.getConn());
        OrderDao orderDao = new OrderDao(DbConnection.getConn());
        List<Order> orderItems = orderDao.getAllOrders(); 
        
        int count = orderItems.size();
    %>
    <div class="container">
        <div class="row">
            <div class="col-md-6"><h3 class="text-left font-weight-bold pt-5 pb-5 float-left">View Orders</h3></div>
            <div class="col-md-6"><h3 class="font-weight-bold pt-5 text-right" style="float:right;">Total Orders: <%= count %></h3></div>
        </div>
    </div>
    <div class="row">
        <div class="container bg-white">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ORDERID</th>
                        <th>CUSTOMER</th>
                        <th>ORDER PLACED DATE</th>
                        <th>PAYMENT MODE</th>
                        <th>ORDER STATUS</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Order order1 : orderItems){ %>
                    <tr id="mytable">
                        <td><%= order1.getOrderId() %></td>
                        <td>
                        	<% 
                        	
                        		int customerId = order1.getUserId();
                        		User user = userDao.getUserDetails(customerId);
                        	%>
                        	<%= user.getUserName() %>
                        </td>
                        <td><%= order1.getOrderDate() %></td>
                        <td><%= order1.getOrderPaymentOption() %></td>
                        <td><%= order1.getOrderStatus() %></td>
                        <td>
						    <button class="btn btn-primary" type="button" data-toggle="collapse" 
						            data-target="#collapseExample<%= order1.getOrderId() %>" 
						            aria-expanded="false" aria-controls="collapseExample<%= order1.getOrderId() %>">
						        View More
						    </button>
						</td>
    					<tr><td colspan="6"><div class="collapse" id="collapseExample<%= order1.getOrderId() %>">
						        <div class="card card-body">
						            <div class="">
						            	<div class="row">
						            		<div class="col-md-4">						            			
						            			<div class="card-body">
						            				<h6 class="font-weight-bold">Shipping Address</h6>
						            				<table>
						            					<tr>
						            						<td>Email: </td>
						            						<td><%= user.getUserEmail() %></td>
						            					</tr>
						            					<tr>
						            						<td>Contact: </td>
						            						<td><%= user.getUserPhone() %></td>
						            					</tr>
						            					<tr>
						            						<td>Address: </td>
						            						<td><%= order1.getShippingAddress() %></td>
						            					</tr>
						            				</table>
						            			</div>
						            		</div>
						            		<div class="col-md-4">
						            			<div class="card-body">
						            				<h6 class="font-weight-bold">Purchased Item</h6>
						            				<table>
						            					<tr>
						            						<td>Product: </td>
						            						<td><%= order1.getProductTitle() %></td>
						            					</tr>
						            					<tr>
						            						<td>Qty </td>
						            						<td><%= order1.getOrderQuantity() %></td>
						            					</tr>
						            					<tr>
						            						<td>Total: </td>
						            						<td><%= order1.getOrderTotalPrice() %></td>
						            					</tr>
						            				</table>
						            			</div>
						            		</div>
						            		<div class="col-md-4">
						            			<div class="card-body">
						            				<h6 class="font-weight-bold">Payment</h6>
						            				<table>
						            					<tr>
						            						<td>Amount Paid: </td>
						            						<td><%= order1.getProductTitle() %></td>
						            					</tr>
						            					<tr>
						            						<td>Payment Status </td>
						            						<td><%= order1.getOrderQuantity() %></td>
						            					</tr>
						            					
						            				</table>
						            			</div>
						            		</div>
						            	</div>
						            </div>
						        </div>
    							</div>
    						</td>
    					</tr>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>