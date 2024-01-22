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
			}
		</style>
	</head>
	<body class="bg-light">

	<%                
                	String cat2 = request.getParameter("category");                   
				        						
                    CategoryDao cdao3 = new CategoryDao(DbConnection.getConn());
                    List<Category> categorylist3 = cdao3.getCategories();
     %>
	<!-- To Show Category From Database -->
	<%
		 int numCategories3 = categorylist3.size();
	%>
	
		<table class="card card-body table table-hover table-bordered"
						id="categoryTable" style="display: none;">
						<thead class="text-left" style="display: table-header-group;">
							<tr>
								<th>Sr.No.</th>
								<th>Category Title</th>
								<th>Category Description</th>
								<th>Delete Category</th>
							</tr>
						</thead>
						<tbody class="text-left">
							<%
				    			int cn =0;
				    			for (Category c3 : categorylist3) 
				    			{
				    				cn++;
				    			
						 	%>
							<tr>
								<td><%= cn %></td>
								<td><%= c3.getCategoryTitle() %></td>
								<td><%= c3.getCategoryDescription() %></td>
								<td><a
									href="../CategoryDelete?categoryId=<%= c3.getCategoryId() %>"
									class="btn btn-danger text-center">Delete</a></td>
							</tr>
							<%
					         	}
					         	if (categorylist3.size() == 0)
					            {
					                out.println("<h3>Categories are not avialble.</h3>");
					            }
					      	%>
						</tbody>
					</table>
					
					<!-- Category Modal Start -->
	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">CATEGORY</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Form for category -->
					<form class="form" action="../CategoryServlet" method="post">

						<div class="form-group">
							<input type="text" name="categoryTitle" class="form-control"
								placeholder="Enter Category Title" required>
						</div>
						<div class="form-group">
							<input type="text" name="categoryDescription"
								class="form-control" placeholder="Enter Category Description"
								" required>
						</div>
						<div class="row">
							<div class="col-6">
								<button type="submit" class="btn btn-primary"
									style="width: 100%">Add</button>
							</div>
							<div class="col-6">
								<button type="reset" class="btn btn-outline-secondary"
									style="width: 100%">Clear</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Category Modal End -->
					
					
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