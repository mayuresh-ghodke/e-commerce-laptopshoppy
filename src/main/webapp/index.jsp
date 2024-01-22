


<%@page import="com.mypackage.dao.CategoryDao"%>
<%@page import="com.mypackage.entity.Category"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.CartDao"%>
<%@page import="com.mypackage.entity.Cart"%>
<%@page import="com.db.DbConnection"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<%@include file="component/common-js-css.jsp"%>
<link rel="stylesheet" type="text/css" href="landingpage.css"></link>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<style>
</style>
</head>
<body class="bg-white">

	<div class="" style="height: 30px;"><%@include file="header.jsp"%></div>

	<%@include file="navbar.jsp"%>

	<section class="p-0">
		<div id="demo" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0"></li>
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2" class="active"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item position-relative">
					<img src="Images/first.jpg" alt="HP" class="d-block w-100"
						style="height: 450px;">
				</div>

				<div class="carousel-item ">
					<img src="Images/asus.jpg" alt="Asus" class="d-block w-100"
						style="height: 450px;">
				</div>

				<div class="carousel-item active">
					<img src="Images/slider2.jpg" alt="Dell" class="d-block w-100"
						style="height: 450px;">
				</div>
			</div>

			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>
	</section>

	<!-- Category and Product contenct Start Here -->
	<section id="sectionId"><%@include file="show.jsp"%></section>


	<!-- Category and Product contenct End Here -->


	<div class="mt-5 container">
		<hr>
	</div>


	<section class="container-fluid bg-white mt-3 p-5 ">
		<h4 class="container-fluid ml-5 font-weight-bold mt-3 ">Ready to
			embark on a journey through the future of laptops ?</h4>
		<br>
		<p class=" container-fluid ml-5 font-weight-bold ">Click play now
			and unlock a world of unparalleled features and possibilities! Your
			ultimate laptop experience awaits.</p>
		<div class="d-flex align-items-center justify-content-center"
			style="overflow: hidden;">
			<iframe src="https://www.youtube.com/embed/fGrpes9EIgg" height="500"
				width="90%" frameborder="0" allowfullscreen></iframe>
		</div>
	</section>

	<!-- Our Products Start-->
	<section class="container-fluid mt-5 bg-light p-5">

		<div class="row">
			<div class="col-md-12">
				<h1 class="text-center font-weight-bold mt-5">We Sold All
					Brands Of Laptops</h1>
			</div>
		</div>
		<div class="row mt-5">
			<div class="col-md-12">
				<div class="media border bg-white">

					<div class="col-md-2 mt-5">
						<img src="Images/a.jpg" class="img-fluid">
					</div>
					<div class="col-md-2 mt-5">
						<img src="Images/b.jpg" class="img-fluid">
					</div>
					<div class="col-md-2 mt-5">
						<img src="Images/c.jpg" class="img-fluid">
					</div>
					<div class="col-md-2 mt-4">
						<img src="Images/f.jpg" class="img-fluid">
					</div>
					<div class="col-md-2 mt-5">
						<img src="Images/d.jpg" class="img-fluid">
					</div>
					<div class="col-md-2 mt-5">
						<img src="Images/e2.jpg" class="img-fluid"
							style="max-height: 80px;">
					</div>

				</div>
			</div>
		</div>
	</section>



	<%@include file="footer.jsp"%>



</body>
</html>