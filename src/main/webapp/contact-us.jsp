<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Contact us</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
        

        
        section {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input,
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }
        
       	.box{
       		height:140px;
       		width:350px;
       		margin-top:15px;
       		border:1px solid blue;
       		background-color:black;
       		color:orange;
       		
       		padding:20px;
       	}
    </style>
</head>
<body class="bg-light">

	<%@include file="navbar.jsp" %>

    <header>
        <h1 class="font-weight-bold text-center p-4">Contact Us</h1>
    </header>

    <div class="container">
    	<div class="row">
    		<div class="col-md-5">
    		<div class="box">
    			<h2>Address: </h2>
    			<h6>Here is my address.</h6>
    		</div>
    		<div class="box">
    			<h2>Phone: </h2>
    			<h6>7559200000</h6>
    		</div>
    		<div class="box">
    			<h2>Email: </h2>
    			<h6>ghodkemayuresh86@gmail.com</h6>
    		</div>
    	</div>
    	<div class="col-md-6">
    		<section>
		        <form action="ContactServlet" method="post" id="contactForm">
		            <label for="name">Your Name:</label>
		            <input type="text" id="name" name="name" required>
		
		            <label for="email">Your Email:</label>
		            <input type="email" id="email" name="email" required>
		            
		            <label for="tel">Your Phone:</label>
		            <input type="tel" id="tel" name="mobile" required>
		
		            <label for="message">Your Message:</label>
		            <textarea id="message" name="message" rows="4" required></textarea>
		
		            <button type="submit">Submit</button>
		        </form>
    		</section>
    	</div>
    	</div>
    </div>
    
    <%@include file="footer.jsp" %>
	
	<script>
    $(document).ready(function () {
        $("#contactForm").submit(function (event) {
            // Prevent the default form submission
            event.preventDefault();

            // Get form data
            var formData = $(this).serialize();

            // Make the AJAX request
            $.ajax({
                type: "POST",
                url: "ContactServlet", // Replace with the actual URL to your servlet
                data: formData,
                success: function (response) {
                    // Handle the successful response here
                    console.log(response);
                    alert("Form submitted successfully!");
                },
                error: function (error) {
                    // Handle the error response here
                    console.error(error);
                    alert("Error submitting the form. Please try again later.");
                }
            });
        });
    });
</script>
	

</body>
</html>