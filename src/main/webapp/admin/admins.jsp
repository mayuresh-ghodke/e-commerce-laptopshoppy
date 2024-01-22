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
	
	
	

	<!-- User Modal Start -->

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
		
</script>





</body>
</html>