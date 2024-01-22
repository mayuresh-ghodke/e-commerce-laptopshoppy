<%@page import="com.mypackage.entity.Product"%>
<%@page import="com.mypackage.dao.ProductDao"%>
<%@page import="com.mypackage.entity.User"%>
<%@page import="com.mypackage.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mypackage.dao.CartDao"%>
<%@page import="com.db.DbConnection"%>
<%@ page import="com.mypackage.entity.Cart" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cart Page</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://kit.fontawesome.com/b982f6e503.js" crossorigin="anonymous"></script>
<!-- Other scripts and your custom script go here -->
</head>
<body class="bg-light">
    <%@include file="navbar.jsp" %>
    
    <div class="container"><h1 class=" p-3 font-weight-bold">Shopping Cart</h1></div>
    
    <div id="msg"></div>
    
    <% 
        User currentUser = (User) session.getAttribute("userObj");
        
        
        UserDao userdao = new UserDao(DbConnection.getConn());
        int currentUserId = userdao.getUserId(user.getUserEmail());
        
        CartDao cartDao = new CartDao(DbConnection.getConn());
        List<Cart> cartItems = cartDao.getCartItems(currentUserId); // Retrieve all cart items for the user
        
        ProductDao pdao = new ProductDao(DbConnection.getConn());
    %>
    
    <div class="container bg-white">
        <% if(cartItems.isEmpty()) { %>
            <div class="text-center">
            	<img src="Images/empty_shopping_cart.jpeg" height="500px" width="550px">
            </div>
        <% } else { %>
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 40%"><h4 class="font-weight-bold">Item</h4></th>
                        <th style="width: 20%"><h4 class="font-weight-bold">Price</h4></th>
                        <th style="width: 20%"><h4 class="font-weight-bold">Quantity</h4></th>
                        <th style="width: 20%"><h4 class="font-weight-bold">Total Price</h4></th>
                        <th style="width: 15%"><h4 class="font-weight-bold">Actions</h4></th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    int n = 0;
                    for (Cart cartItem : cartItems) { 
                        n += 1;
                    %>
                    <tr class="mt-3">
                        <td style="width: 25%">
                            <div class="d-flex align-items-center">
                                <img src="Images/<%= cartItem.getProductFile() %>" class="card-img-top" style="height:120px;width:120px" alt="...">
                                <span class="ml-4"><%= cartItem.getProductTitle() %></span>
                            </div>
                        </td>
                        <td>
                            <div class="mt-5"><%= cartItem.getProductPrice() %></div>
                        </td>
                        <td>
                            <form action="CartJspServlet" method="post" id="cartform">
                                <input type="hidden" name="userEmail" value="<%= user.getUserEmail() %>">
                                <input type="hidden" name="productId" value="<%= cartItem.getProductId() %>">
                                <input type="hidden" name="productDesc" value="<%= cartItem.getProductDescription() %>">
                                <input type="hidden" name="productTitle" value="<%= cartItem.getProductTitle() %>">
                                <input type="hidden" name="productPrice" value="<%= cartItem.getProductPrice() %>">
                                <input type="hidden" name="productFile" value="<%= cartItem.getProductFile() %>">
                                <div class="d-flex mt-5">
                                    <button type="button" class="btn btn-sm btn-decre" onclick="removeQuantity('quantity<%= cartItem.getProductId() %>');">
                                        <i class="fas fa-minus-square"></i>
                                    </button>
                                    <input type="text" style="width: 30%;" name="productQuantity" value="<%= cartItem.getQuantity() %>" class="form-inline text-center" id="quantity<%= cartItem.getProductId() %>" readonly>
                                    <button type="button" name="inc" class="btn btn-sm btn-decre" onclick="addQuantity('quantity<%= cartItem.getProductId() %>');">
                                        <i class="fas fa-plus-square"></i>
                                    </button>
                                </div>
                                <% if(pdao.isProductInStockQty(cartItem.getProductId())) { %>
                                    <button class="btn btn-dark mt-3 ml-2" style="width: 60%;border-radius:30px;">Update</button>
                                <% } %>
                            </form>
                        </td>
                        <td>
                            <div class="mt-5"><%= cartItem.getProductPrice() * cartItem.getQuantity() %></div>
                        </td>
                        <td>
                            <div class="d-flex flex-column mt-5">
                                <% if (pdao.isProductInStockQty(cartItem.getProductId())) { %>
                                    <a href="checkout.jsp?productId=<%= cartItem.getProductId() %>&productDescription=<%= cartItem.getProductDescription() %>&productTitle=<%= cartItem.getProductTitle() %>&productPrice=<%= cartItem.getProductPrice() %>&productQuantity=<%= cartItem.getQuantity() %>&productFile=<%= cartItem.getProductFile() %>" class="btn btn-outline-primary mb-2">Buy</a>
                                <% } else { %>
                                    <p class="text-center text-danger">Product Not Available.</p>
                                <% } %>
                                <form action="DeleteCartServletProduct" method="post">
                                    <input type="hidden" value="<%= cartItem.getProductId() %>" name="productId">
                                    <input type="hidden" value="<%= currentUserId %>" name="userId">
                                    <div class="text-center mt-2">
                                        <button type="submit" class="btn bg-white text-danger fa fa-trash" aria-hidden="true"></button>
                                    </div>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <script>
        function addQuantity(inputId) {
            var quantityInput = document.getElementById(inputId);
            var currentQuantity = parseInt(quantityInput.value);
            quantityInput.value = currentQuantity + 1;
        }

        function removeQuantity(inputId) {
            var quantityInput = document.getElementById(inputId);
            var currentQuantity = parseInt(quantityInput.value);
            if (currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
            } else {
                alert('Quantity Must Be Minimum 1');
            }
        }

        jQuery(document).ready(function () {
            console.log("cart Page is ready....");

            jQuery("#cartform").on('submit', function (event) {
                // stop the default behavior
                event.preventDefault();
                var f = $(this).serialize();

                console.log("f: ", f);

                $.ajax({
                    url: 'CartJspServlet',
                    data: f,
                    type: 'POST',
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        console.log("Successs");
                        $("#msg").load("component/message.jsp");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText); // log the response text
                        console.log("Error");
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
