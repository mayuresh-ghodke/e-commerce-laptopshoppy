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
                	String cat1 = request.getParameter("category");                   
				    //out.println(cat);				        						
				 	ProductDao dao1 = new ProductDao(DbConnection.getConn());
				    List<Product> list1 = null;

				    if (cat1 == null || cat1.trim().equals("all"))
				    {
				       	list1 = dao1.getProducts();
				    }
				    else
				    {
                        int cid1 = Integer.parseInt(cat1.trim());
                        list1 = dao1.getAllProductsById(cid1);
                    }  					
				    
				    
				        						
                    CategoryDao cdao1 = new CategoryDao(DbConnection.getConn());
                    List<Category> categorylist1 = cdao1.getCategories();
     %>
	<!-- To Show Category From Database -->
	<%
		 int numCategories1 = categorylist1.size();
	%>
	<!-- To Show Products From Database -->
	<%
		 int numProducts1 = list1.size();
	%>

					<table class="card table table-hover table-bordered"
						id="product-table" style="display: none;">
						<thead class="font-weight text-left"
							style="display: table-header-group;">
							<tr>
								<th>Sr.no.</th>
								<th>Product Title</th>
								<th>Description</th>
								<th>Price</th>
								<th>In Stock</th>
								<th>Total Stock</th>
								<th>Edit</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody class="text-left">
							<%
			    			int np = 0;
			    			for (Product p1 : list1) 
			    			{
			    				np++;
					 	%>
							<tr>
								<td><%= np %></td>
								<td><%= p1.getProductTitle() %></td>
								<td><%= p1.getProductDescription() %></td>
								<td><%= p1.getProductPrice() %></td>
								<td><%= p1.getInStockQty() %>
								<td><%= p1.getProductQty() %></td>
								<td>
									<button class="btn btn-info ml-2" data-toggle="modal" data-target="#edit-product-modal-<%= p1.getProductId() %>">Edit</button>
    							</td>
								<td><a
									href="../ProductDelete?productId=<%= p1.getProductId() %>"
									class="btn btn-danger text-center">Delete</a></td>
							</tr>
							<%
				         	}
				         	if (list1.size() == 0)
				            {
				                out.println("<h3>No item in this category</h3>");
				            }
				      	%>
						</tbody>
					</table>
					
					<!-- Edit Product Details Start-->
<% for (Product p : list1) { %>
    <div class="modal fade" id="edit-product-modal-<%= p.getProductId() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"><div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Edit Product</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                	
                    <!--Form for product-->
                    <form class="form" action="../EditProductServlet" method="GET" enctype="multipart/form-data">
    <input type="hidden" name="product_id" value="<%= p.getProductId() %>">
    <div class="form-group">
        <label style="float:left;" class="font-weight-bold">Title:</label>
        <input type="text" name="productTitle" class="form-control" value="<%= p.getProductTitle() %>" required>
    </div>
    <div class="form-group">
        <label style="float:left;" class="font-weight-bold">Description:</label>
        <textarea name="productDesc" class="form-control" required><%= p.getProductDescription() %></textarea>
    </div>
    <div class="form-group">
        <label style="float:left;" class="font-weight-bold">Price:</label>
        <input type="text" name="productPrice" class="form-control" value="<%= p.getProductPrice() %>" required>
    </div>
    <div class="form-group">
        <label style="float:left;" class="font-weight-bold">Qty:</label>
        <input type="text" name="productQty" class="form-control" value="<%= p.getProductQty() %>" required>
    </div>

    <div class="row">
        <div class="col-6">
            <button type="submit" class="btn btn-info" style="width: 230px;">Update</button>
        </div>
    </div>
</form>

                </div>
            </div>
        </div>
    </div>
<% } %>
<!-- Edit Product Details End-->

	<!-- Product Modal Start -->
	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title font-weight-bold" id="exampleModalLabel" class="">Add
						Product</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!--Form for product-->
					<form class="form" action="../ProductServlet" method="post"
						enctype="multipart/form-data">


						<div class="form-group">
							<input type="text" name="productTitle" class="form-control"
								placeholder="Enter Product Title" required>
						</div>
						<!--product category-->
						<div class="form-group">
							<select name="catId" class="form-control" required>
								<option value="" selected disabled>Select Product
									Category</option>

								<% 
    CategoryDao cdao2 = new CategoryDao(DbConnection.getConn());
    List<Category> categorylist2 = cdao1.getCategories();
%>

								<% for (Category c1 : categorylist2) { %>
								<option value="<%= c1.getCategoryId() %>"><%= c1.getCategoryTitle() %></option>
								<% } %>

							</select>
						</div>
						<div class="form-group">
							<textarea type="text" style="height: 200px;"
								name="productDescription" class="form-control"
								placeholder="Enter Product Description" required></textarea>
						</div>



						<div class="form-group">
							<input type="file" name="productFile" class="form-control"
								placeholder="Upload Product Image" required>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<h6>Qty:</h6>
									<input type="text" name="productQty" class="form-control"
										placeholder="Enter Product Quantity" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<h6>Price:</h6>
									<input type="text" name="productPrice" class="form-control"
										placeholder="Enter Product Price" required>
								</div>
							</div>
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


	<!-- User Modal Start -->

	
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