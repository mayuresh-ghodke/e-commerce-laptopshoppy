<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <title>SIGN UP</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .card {
      background: #fbfbfb;
      border-radius: 8px;
      box-shadow: 1px 2px 8px rgba(0, 0, 0, 0.65);
      max-width: 750px;
      margin: 0 auto; /* Center the card horizontally */
    }
    .card-content {
      padding: 12px 44px;
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
  </style>
</head>
<body class="bg-light">

  <%@include file="navbar.jsp" %> 
  
  

  <div class="mt-3 container mt-3">
  	<%@ include file="component/message.jsp" %>
    <div class="row justify-content-center">
      <div class="col-md-8">  
        <div class="card mt-2">
          <div class="card-content">
            <div class="card-body">
            
            	<h3 id="msg"></h3>
              
              <form action="RegisterServlet" method="post" id="registerform">
                <h2 class="card-header bg-white text-center font-weight-bold ">Sign up</h2>
                <div class="form-group mt-3">
                  <label for="name" class="font-weight-bold">Enter Your Name</label>
                  <input type="text" name="userName" id="name" placeholder="Enter Your Name" required>
                </div>
                <div class="form-group">
                  <label for="email" class="font-weight-bold">Enter Email</label>
                  <input type="email" name="userEmail" id="email" placeholder="Enter Your Email" required>
                </div>
                <div class="form-group">
                  <label for="pass" class="font-weight-bold">Create Password</label>
                  <input type="password" name="userPassword" id="pass" placeholder="Enter Your Password" required>
                </div>
                <div class="form-group">
                  <label for="phone" class="font-weight-bold">Enter Phone</label>
                  <input type="tel" name="userPhone" id="phone" placeholder="Enter Your Phone" required>
                </div>
                <div class="form-group">
                  <label for="address" class="font-weight-bold">Enter Address</label>
                  <input type="text" name="userAddress" id="address" placeholder="Enter Your Address" required>
                </div>
                
                <div class="row">
                  <div class="col-md-4">
                    <button>Signup</button>
                  </div>
                  <div class="col-md-8">
                    <button type="reset">Clear</button>
                  </div>
                </div>
                <p class="text-center mt-4">Already have an account, please <a href="login.jsp">Login here</a></p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div> 
  
  <%@include file="footer.jsp" %>
  
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  
  
  <script>
  function validateForm() {
      var userName = $("#name").val().trim();
      var userEmail = $("#email").val().trim();
      var userPassword = $("#pass").val().trim();
      var userPhone = $("#phone").val().trim();
      var userAddress = $("#address").val().trim();

      if (userName === "" || userEmail === "" || userPassword === "" || userPhone === "" || userAddress === "") {
          alert("All Information Must Be Filled.");
          return false; // Prevent form submission
      }
      return true; // Allow form submission
  }

    $(document).ready(function () {
        console.log("Page is ready....");
        
        

        $("#registerform").on('submit', function (event) {
            // stop the by default behavior
            event.preventDefault();
            var f = $(this).serialize();

            console.log("f: ", f);
            
            $("#name").attr("disabled", "true");
            $("#email").attr("disabled", "true");
            $("#pass").attr("disabled", "true");
            $("#phone").attr("disabled", "true");
            $("#address").attr("disabled", "true");

            $(".loader").show();
            $(".form").hide();

            $.ajax({
                url: 'RegisterServlet',
                data: f,
                type: 'POST',
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    
                    if(data.trim() === "RegisterSuccess"){
                    	$("#msg").load("component/message.jsp");
                    	alert("Successfuly Registerd.");
                    	window.location.href = "index.jsp";
                    }
                    else{
                    	$("#msg").load("component/message.jsp");
                    	
                    	alert("Registration Failed");
                    	window.location.href = "register.jsp";
                    	
                    }
                    
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText); // log the response text
                    console.log("Error");
                    
                    $("#msg").load("component/message.jsp");
                	
                	alert("Registration Failed");
                	window.location.href = "register.jsp";
	
                    $(".loader").hide();
                    $(".form").show();
                },
                
                theme: {
                    "color": "#3399cc"
                }
            });
        });
    });
</script>

</body>
</html>
