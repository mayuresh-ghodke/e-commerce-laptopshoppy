<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Home</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	
		*{
			margin: 0px;
			padding: 0px;
		}
		
		.slider1{
				background-size: 100% 100%;
			}
		.slider2{
				background-size: 100% 100%;
			}
			
		.slider3{
				background-size: 100% 100%;
			}
		.slidersize{
				height: 400px;
			}
		
	</style>
</head>
<body>
	<div id="demo" class="carousel slide" data-ride="carousel">
		  	<!-- Indicators -->
		  	<ul class="carousel-indicators">
		    	<li data-target="#demo" data-slide-to="0" class="active"></li>
		    	<li data-target="#demo" data-slide-to="1"></li>
		    	<li data-target="#demo" data-slide-to="2"></li>
		  	</ul>

	  		<!-- The slide show -->
		  	<div class="carousel-inner">
		    	<div class="carousel-item slidersize active">
		      		<img src="Images/hp.jpg" alt="" class="h4 w-100">
		      		<div class="carousel-caption ">
        				<div class="row">
        					<div class="col-6">
        						<h1 class="text-dark font-weight-bold text-center mt-3">HP</h1>
        						<h3 class="text-dark text-justify text-center mt-4 ml-5"><i>Purchase and Get Complementary membership.<br>
		        				We are strong community builds products<br>to our beloved customers</i></h3>
		        			</div>
        				</div>
        				<div class="row"> 
        					<div class="col-6 col-md-6">
        						<div class="text-center text-light mt-5">
		        					<div class="btndemo">
		        						<button class="btn btn-dark btn-lg active">Shop Now</button>
		        						<button class="btn btn-dark btn-lg ml-5 active">More Info >></button> 
		        					</div>
		        				</div>
        					</div>
        				</div>
		    		</div>
		    	</div>

		    	<div class="carousel-item slidersize">
			      	<img src="Images/asus.jpg" alt="" class="h-5 w-100">
        		</div>

			    <div class="imgdemo">
			    	<div class="carousel-item slidersize">
				      	<img src="Images/firstslide.jpg" alt="" class="h-4 w-100">
			      		<div class="carousel-caption ">
	        				<div class="row">
	        					<div class="col-6">
	        						<h1 class="text-dark font-weight-bold text-center mt-5">Dell</h1>
	        						<h3 class="text-dark text-left">Purchase and Get Complementary membership.<br>
			        				We are strong community builds products<br>to our beloved customers.</h3>
			        			</div>
	        				</div>
	        				<div class="row">
	        					<div class="col-6">
	        						<div class="text-left text-light mr-5 mt-5">
			        					<button class="btn btn-dark btn-lg mr-4 active">Shop Now</button>
			        					<button class="btn btn-dark btn-lg active">More Info >></button> 
			        				</div>
	        					</div>
	        				</div>
			    		</div>
        			</div>
			    </div>
		 	</div>
		 	<!-- Left and right controls -->
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
			    <span class="carousel-control-prev-icon"></span>
			</a>
			<a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>
</body>
</html>