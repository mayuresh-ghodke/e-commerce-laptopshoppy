
<%               	
    		User user = (User) session.getAttribute("userObject");	    		    	
		%>
<%@page import="com.mypackage.entity.Category"%>
<%@page import="com.mypackage.dao.CategoryDao"%>
<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mypackage.dao.CartDao"%>
<%@page import="com.db.DbConnection"%>
<%@ page import="com.mypackage.entity.Cart"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="path/to/font-awesome/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<%@include file="component/common-js-css.jsp"%>
<style>
.navdemo:hover {
	color: orange;
}

.user-dropdown {
	position: relative;
	display: inline-block;
}

.dropdemo {
	padding: 10px;
	cursor: pointer;
}

.dropdown-content {
	position: absolute;
	z-index: 1;
}

.dropdown-content a {
	padding: 10px;
	text-decoration: none;
	display: block;
	cursor: default;
}

.user-dropdown:hover .dropdown-content {
	display: block;
	text-decoration: none;
	background-color: blue; 
}

.pointer {
	cursor: pointer;
}

i {
	margin-right: 10px;
}

.no-pointer {
	cursor: context-menu;
}

/* Custom Styles for Navbar */
.navbar-brand {
	font-size: 24px;
	font-weight: bold;
}

.navbar-toggler {
	color: #fff;
	border: none;
}

.navbar-toggler-icon {
	background-color: #fff;
}

.navbar-nav .nav-link {
	color: #fff;
}

.navbar-nav .nav-link:hover {
	color: orange;
}

.navbar-collapse {
	justify-content: flex-end;
}

.navbar .btn {
	margin-left: 10px;
}

@media ( max-width : 767px) {
	.navbar-nav {
		margin-top: 20px;
	}
	.navbar .btn {
		margin-left: 0;
	}
	.navbar-toggler-icon {
		display: block; 
		color: white;
	}
}
</style>
</head>
<body>

	<% 	
    if (user != null) {
        UserDao userdao = new UserDao(DbConnection.getConn());
        int currentUserId = userdao.getUserId(user.getUserEmail());

        CartDao cartDao = new CartDao(DbConnection.getConn());
        List<Cart> cartItems = cartDao.getCartItems(currentUserId); // Retrieve all cart items for the user
    }
%>

	<nav class="navbar sticky-top navbar-expand-lg"
		style="background-color: black;">
		<div class="container-fluid ml-3" style="background-color: black;">
			<img src="Images/logo.png" height="50px" width="50px">
			<a class="navbar-brand" href="index.jsp"
				style="font-size: 30px; color: orange;"><i>laptopshoppy</i></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav font-weight-bold ml-auto">
					<li class="nav-item active"><a class="nav-link"
						href="index.jsp">HOME</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> TOP BRANDS </a>
						<div class="dropdown-menu"
							aria-labelledby="navbarDropdownMenuLink">
							<%                
						    String cat = request.getParameter("category");                   
						    //out.println(cat);
						        						
						    ProductDao dao = new ProductDao(DbConnection.getConn());
						    List<Product> list = null;
						
						    if (cat == null || cat.trim().equals("all"))
						    {
						        list = dao.getProducts();
						    }
						    else
						    {
						        int cid = Integer.parseInt(cat.trim());
						        list = dao.getAllProductsById(cid);
						    }  										        						
						        						
						    CategoryDao cdao = new CategoryDao(DbConnection.getConn());
						    List<Category> categorylist = cdao.getCategories();
						    
				     	%>
							<% for (Category c : categorylist) { %>
							<a id="categoryFilter" href="index.jsp?category=<%= c.getCategoryId()%>"
								class="dropdown-item font-weight-bold"> <% String catTitle = c.getCategoryTitle(); %>
								<%= catTitle.toUpperCase() %>
							</a>
							<% } %>
						</div></li>
					<li class="nav-item"><a class="nav-link" href="about.jsp"
						class="btn btn-primary" data-toggle="modal"
						data-target="#exampleModalCenter">ABOUT US</a></li>
					<li class="nav-item"><a class="nav-link" href="contact-us.jsp">CONTACT
							US</a></li>
					<% if (user != null) { %>
					<li class="nav-item dropdown">
						<div class="nav-link dropdown-toggle" id="navbarDropdownMenuLink"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<a href="" class="text-white" style="text-decoration: none;"><i
								class="fa fa-user" aria-hidden="true"></i>Welcome, <%= user.getUserName() %></a>
						</div>

						<div class="dropdown-menu"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item font-weight-bold"
								href="my-order-history.jsp">VIEW ORDERS</a> <a
								class="dropdown-item font-weight-bold" href="dashboard.jsp">DASHBOARD</a>
							<a class="dropdown-item font-weight-bold text-danger"
								href="UserLogout">LOGOUT</a>

						</div>
					</li>

					<li class="nav-item"><a href="cart.jsp"
						class="btn  btn-outline-warning"> <i
							class="fa fa-shopping-cart" aria-hidden="true"></i> <% 	
			    			if (user != null) {
			        			UserDao userdao = new UserDao(DbConnection.getConn());
			        			int currentUserId = userdao.getUserId(user.getUserEmail());
			
			        			CartDao cartDao = new CartDao(DbConnection.getConn());
			        			List<Cart> cartItems = cartDao.getCartItems(currentUserId); // Retrieve all cart items for the user
			            %> <span class="badge badge-warning"><%= cartDao.getCartSize(currentUserId) %>
								<% } %></span>
					</a></li>

					<% } else { %>
					<li class="nav-item mt-2 ml-3"><a href="login.jsp"
						style="text-decoration: none;" class="text-white"> LOGIN </a></li>
					<li class="nav-item mt-1 ml-3"><a href="register.jsp"
						class="btn btn-outline-warning">SIGN UP</a></li>
					<% } %>
				</ul>
			</div>
		</div>
	</nav>




	<!-- Modal -->
	<div class="modal" id="exampleModalCenter" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title font-weight-bold" id="exampleModalLongTitle">About
						Us</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h4 class="font-weight-bold">
						<i>laptopshoppy</i> - Your Trusted IT Partner
					</h4>
					<p style="text-align: justify;">At Laptop Shoppy, we're not
						just a store; we're your trusted IT partner on your journey to
						finding the perfect technology solutions. With a deep commitment
						to providing unparalleled service and a wide selection of
						high-quality products, we have become a go-to destination for all
						your IT needs. At Laptop Shoppy, our dedication to customer
						satisfaction goes beyond the purchase.</p>
					<h4 class="font-weight-bold">A World of Laptops</h4>
					<p style="text-align: justify;">Discover a world of laptops at
						Laptop Shoppy. We take pride in curating a diverse selection of
						laptops from some of the most trusted brands in the industry. From
						the sleek and powerful designs of Dell and Lenovo to the
						innovation-driven creations of Asus, HP, Acer, and many more, we
						have the perfect laptop to match your needs and style. Whether
						you're a creative professional, a student, a business executive,
						or a casual user, our collection caters to all preferences and
						requirements.</p>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>
	
</body>
</html>







