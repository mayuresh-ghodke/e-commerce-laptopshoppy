 package com.mypackage.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DbConnection;
import com.mypackage.dao.OrderDao;
import com.mypackage.dao.ProductDao;
import com.mypackage.entity.Order;

public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderServlet() {
        super();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // Extracting parameters from the request
            int userId = Integer.parseInt(req.getParameter("userId"));
            String contact = req.getParameter("contact");
            String email = req.getParameter("email");
            String address = req.getParameter("address");
            String paymentOption = req.getParameter("paymentOption");
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productDescription = req.getParameter("productDescription");
            String productTitle = req.getParameter("productTitle");
            String productFile = req.getParameter("productFile");
            int productPrice = Integer.parseInt(req.getParameter("productPrice"));
            int totalPrice = Integer.parseInt(req.getParameter("totalPrice"));
            int quantity = Integer.parseInt(req.getParameter("productQuantity"));

            Date currentDate = new Date();

            // Creating an Order object
            Order order = new Order();
            order.setProductId(productId);
            order.setProductDescription(productDescription);
            order.setProductTitle(productTitle);
            order.setProductFile(productFile);
            order.setProductPrice(productPrice);
            order.setTotalPrice(totalPrice);
            order.setQuantity(quantity);
            order.setUserId(userId);
            order.setContact(contact);
            order.setEmail(email);
            order.setAddress(address);
            order.setPaymentOption(paymentOption);
            order.setDate(currentDate);

            // Printing order details for debugging
            System.out.println("Order Details:");
            System.out.println("Product ID: " + order.getProductId());
            System.out.println("User ID: " + order.getUserId());
            System.out.println("Contact: " + order.getContact());
            System.out.println("Email: " + order.getEmail());
            System.out.println("Address: " + order.getAddress());
            System.out.println("Payment Option: " + order.getPaymentOption());
            System.out.println("Product Price: " + order.getProductPrice());
            System.out.println("Total Price: " + order.getTotalPrice());
            System.out.println("Quantity: " + order.getQuantity());
            System.out.println("Description : " + order.getProductDescription());
            System.out.println("Date : " + currentDate);

            // Adding order to the database
            OrderDao orderDao = new OrderDao(DbConnection.getConn());
            orderDao.addOrder(order);
            
          

            // Updating product stock quantity
            ProductDao productDao = new ProductDao(DbConnection.getConn());
            int totalInStockQty = productDao.getProductInStockQtyById(productId);
            int inStock = totalInStockQty - order.getQuantity();
            orderDao.updateInStockQty(productId, inStock);

            // Setting a success message in the session
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Order has been placed successfully!");

            // Redirecting based on payment option
            if ("Online".equals(paymentOption)) {
                
                int price = productPrice; // Replace this with the actual product price
                res.sendRedirect("paymentForm.jsp?productPrice=" + price+"&orderId="+orderDao.getOrderId(productId, userId)+"&productId="+productId);
            } else if ("Cash On Delivery".equals(paymentOption)) {
            	
                res.sendRedirect("order-view.jsp?orderId="+orderDao.getOrderId(productId, userId)+"&productTitle="+order.getProductTitle()+"&orderQty="+order.getQuantity()+"&orderPrice="+order.getProductPrice());
            }
        } catch (NumberFormatException | SQLException e) {
            
            System.out.println("Error: " + e);
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Error processing the order. Please try again.");
            res.sendRedirect("errorPage.jsp");
        }
    }
}
