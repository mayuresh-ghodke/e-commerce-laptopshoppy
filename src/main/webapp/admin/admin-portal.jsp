
<%@page import="com.mypackage.dao.admin.AdminDao"%>
<%@page import="com.mypackage.admin.entity.Admin"%>
<%@page import="com.mypackage.dao.CategoryDao"%>
<%@page import="com.mypackage.entity.Category"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="com.mypackage.entity.Order"%>
<%@page import="com.mypackage.dao.OrderDao"%>
<%@page import="com.db.DbConnection"%>
<%@page import="java.util.List"%>
<%@page import="com.mypackage.entity.User"%>
<%               	
    		User user = (User) session.getAttribute("userObject");	
        
        	if(user != null)
        	{       
				session.setAttribute("failedMessage", "Oops! User Logged in. ");
        		response.sendRedirect("admin-login.jsp");
        		return;
        	}
        	
        	Admin admin = (Admin) session.getAttribute("adminObject");
        	if(admin != null){
		%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Portal</title>
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
	padding:10px;
}
</style>
</head>
<body class="bg-light">

	<%@include file="../component/message.jsp"%>

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
                    
                    OrderDao odao = new OrderDao(DbConnection.getConn());
                    List<Order> orderlist = odao.getOrders();
                    
                    
                    AdminDao admindao = new AdminDao(DbConnection.getConn());
                	List<Admin> adminlist = admindao.getAdmins();
                	int numAdmins = adminlist.size();
                    
                    UserDao udao = new UserDao(DbConnection.getConn());
                	List<User> userlist = udao.getUsers();
                	int numUsers = userlist.size();
                %>
	<!-- To Show Category From Database -->
	<%
		    		int numCategories = categorylist.size();
				%>
	<!-- To Show Products From Database -->
	<%
		    		int numProducts = list.size();
				%>



	<div class="row text-center">
		<!-- First Col (col-md-3) -->
		<div class="col-md-2  bg-dark">
			<div class="text-center mt-5 font-weight-bold">
				<a href="../index.jsp">Go To Home Page</a>

			</div>
			<div class="text-center text-white p-5">
				<img src="../Images/admin-icon.jpg"
					style="color: white; height: 100px; width: 100px; border-radius: 10px;">
				<h3 class="font-weight-bold text-center">
					Welcome,
					<%= admin.getAdminName() %></h3>
			</div>



			<div class="row m-3">
				<button onclick="showUserTable()"
					class="btn text-white text-center ml-2">
					<i class="fa fa-user" aria-hidden="true"></i> <span class="ml-2">VIEW
						USERS</span>
				</button>
			</div>


			<div class="row m-3">
				<button onclick="showTable()"
					class="btn text-white text-center ml-2">
					<i class="fa fa-list-alt" aria-hidden="true"></i> <span
						class="ml-2">VIEW CATEGORIES</span>
				</button>
			</div>

			<div class="row m-3">

				<button id="view-products" class="btn text-white text-center ml-2">
					<i class="fa fa-list" aria-hidden="true"></i><span class="ml-2">VIEW
						PRODUCTS</span>
				</button>
			</div>

			<div class="row m-3">

				<button class="btn text-white text-center ml-2" data-toggle="modal"
					data-target="#add-category-modal">
					<i class="fa fa-plus" aria-hidden="true"></i><span class="ml-2">ADD
						CATEGORY</span>
				</button>
			</div>

			<div class="row m-3">
				<button class="btn text-white text-center ml-2" data-toggle="modal"
					data-target="#add-product-modal">
					<i class="fa fa-plus-square" aria-hidden="true"></i><span
						class="ml-2">ADD PRODUCT</span>
				</button>
			</div>

			<hr>

			<div class="row m-3">
				<button class="btn text-white text-center ml-2" data-toggle="modal"
					data-target="#add-user-modal">
					<i class="fa fa-user-plus" aria-hidden="true"></i><span
						class="ml-2">ADD ADMIN</span>
				</button>
			</div>
			<div class="row m-3">

				<a
					class="font-weight-bold text-danger btn btn-outline-danger text-center text-white ml-2 w-100"
					href="../UserLogout"> <span class="ml-2">LOGOUT</span></a>
			</div>
		</div>
		<div class="col-md-10">
			<!--Show all Products start-->
			<div class="row">
				<div class="container">
					<div class="row p-3">
						<div class="col-md-2 p-2">
							<div class="card bg-success font-weight-bold">
								<h3 class="text-white font-weight-bold">Products</h3>
								<h1 class=" font-weight-bold text-white"><%= numProducts %></h1>
							</div>
						</div>
						<div class="col-md-2 p-2">
							<div class="card bg-primary font-weight-bold">
								<h3 class="text-white font-weight-bold">Categories</h3>
								<h1 class=" font-weight-bold text-white"><%= numCategories %></h1>
							</div>
						</div>
						<div class="col-md-2 p-2">
							<div class="card bg-secondary font-weight-bold">
								<h3 class="text-white font-weight-bold">Users</h3>
								<h1 class=" font-weight-bold text-white"><%= numUsers %></h1>
							</div>
						</div>
						<div class="col-md-2 p-2">
							<div class="card bg-danger font-weight-bold">
								<h3 class="text-white font-weight-bold">Admins</h3>
								<h1 class=" font-weight-bold text-white"><%= numAdmins %></h1>
							</div>
						</div>
						<div class="col-md-2 p-2">
							<div class="card bg-info font-weight-bold">
								<h3 class="text-white font-weight-bold">Orders</h3>
								<h1 class=" font-weight-bold text-white"><%= numAdmins %></h1>
							</div>
						</div>
					</div>
					
					<!--  Product Details file Start -->
					<%@include file="products.jsp" %>
					<!--  Product Details file End -->

					<%@include file="category.jsp" %>
					
					<a href="orders.jsp">View Orders</a>

					<!-- To show user details -->
					<table class="card card-body table table-hover table-bordered"
						id="userTable" style="display: none;">
						<thead class="text-left" style="display: table-header-group;">
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Address</th>
							</tr>
						</thead>
						<tbody class="text-left">
							<% for (User user1 : userlist) { %>
							<tr>
								<td><%= user1.getUserName() %></td>
								<td><%= user1.getUserEmail() %></td>
								<td><%= user1.getUserPhone() %></td>
								<td><%= user1.getUserAddress() %></td>
							</tr>
							<% } if (userlist.size() == 0) { %>
							<tr>
								<td colspan="4"><h3>No user.</h3></td>
							</tr>
							<% } %>
						</tbody>
					</table>
					<!--  to show user details end -->
				</div>
			</div>
			<!-- Show all products end -->

			<%
        	}
%>
		</div>

	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="add-user-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel" class="">Add
						User As Admin</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!--Form for product-->
					<form class="form" action="../AddAdminServlet" method="get"
						enctype="multipart/form-data">
						<div class="form-group">
							<input type="text" name="adminName" class="form-control"
								placeholder="Admin Name" required>
						</div>
						<div class="form-group">
							<input type="text" name="adminMobile" class="form-control"
								placeholder="Admin Mobile" required>
						</div>
						<div class="form-group">
							<input type="email" name="adminEmail" class="form-control"
								placeholder="Admin Email" required>
						</div>

						<div class="form-group">
							<input type="password" name="adminPass" class="form-control"
								placeholder="Set Password" required>
						</div>

						<div class="row">
							<div class="col-6">
								<button type="submit" class="btn btn-primary"
									style="width: 230px">Add</button>
							</div>
							<div class="col-6">
								<button type="reset" class="btn btn-secondary"
									style="width: 225px">Clear</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Product Modal End -->
	<!-- User Modal End -->


	<script>
		  // Get the product table element
		  const productTable = document.getElementById("product-table");
		
		  // Hide the product table by default
		  productTable.style.display = "none";
		
		  // Add an event listener to the "VIEW" button
		  const viewProductsButton = document.getElementById("view-products");
		  viewProductsButton.addEventListener("click", () => {
		    // Show the product table when the button is clicked
		    productTable.style.display = "table";
		  });
		  
		  function showTable()
		  {
			  var table = document.getElementById("categoryTable");
			  if (table.style.display === "none")
			  {
			    table.style.display = "table"; // change "none" to "table" to show the table
			  }
		  }
		  
		  function showUserTable() {
			    var table = document.getElementById("userTable");
			    if (table.style.display === "none") {
			        table.style.display = "table"; // change "none" to "table" to show the table
			    }
			}
		  
		  function closeModalAndShowTable() {
			    // Close the currently displayed modal
			    $('#add-category-modal').modal('hide');
			    
			    // Call the showTable() function
			    showTable();
			}
		
		  function editProduct(productId) {
			    // Show the corresponding Edit Product modal
			    $('#edit-product-modal-' + productId).modal('show');
			}
</script>

</body>
</html>