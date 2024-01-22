package com.mypackage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.mypackage.entity.Order;


public class OrderDao
{
	private Connection conn;

    public OrderDao(Connection conn) {
		this.conn = conn;		
	}
    
    public void addOrder(Order order) throws SQLException {         	
        try {       	
            PreparedStatement ps = conn.prepareStatement("INSERT INTO `order` (product_id, user_id, product_title, product_description, product_price, quantity, total_price, product_file, contact, email, address, payment_option,date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
            
            ps.setInt(1, order.getProductId());
            ps.setInt(2, order.getUserId());
            ps.setString(3, order.getProductTitle());
            ps.setString(4, order.getProductDescription());
            ps.setInt(5, order.getProductPrice());
            ps.setInt(6, order.getQuantity());
            ps.setInt(7, order.getTotalPrice());
            ps.setString(8, order.getProductFile());
            ps.setString(9, order.getContact());
            ps.setString(10, order.getEmail());
            ps.setString(11, order.getAddress());
            ps.setString(12, order.getPaymentOption());
            
         // Set Date object
            ps.setDate(13, new java.sql.Date(order.getDate().getTime()));
            
            int i = ps.executeUpdate();
            
            if (i > 0) {
                System.out.println("Order Successfully Added");
            } else {
                System.out.println("Something error");
            }          
        } catch (SQLException e) {
            System.out.println("Error : " + e);
            e.printStackTrace();
        }        
    }
    
    public List<Order> getOrders(int userId) {
        List<Order> orderItems = new ArrayList<>();
        String sql = "SELECT order_id, product_id, product_title, product_description, product_price, quantity, product_file, date, total_price, payment_option" +
                     " FROM `order` " +
                     "WHERE user_id = ?";
        
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery())
            {
                while (rs.next()) {
                    Order orderItem = new Order();
                    orderItem.setOrderId(rs.getInt("order_id"));
                    orderItem.setProductId(rs.getInt("product_id"));
                    orderItem.setProductTitle(rs.getString("product_title"));
                    orderItem.setProductDescription(rs.getString("product_description"));
                    orderItem.setProductPrice(rs.getInt("product_price"));
                    orderItem.setTotalPrice(rs.getInt("total_price"));
                    orderItem.setQuantity(rs.getInt("quantity"));
                    orderItem.setProductFile(rs.getString("product_file"));
                    orderItem.setPaymentOption(rs.getString("payment_option"));
                    orderItem.setDate(rs.getDate("date"));
                    
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            // Handle or log the exception here
            e.printStackTrace();
        }
        
        return orderItems;
    }
    
    public List<Order> getOrders() {
        List<Order> orderItems = new ArrayList<>();
        String sql = "SELECT product_id, product_title, product_description, product_price, quantity, product_file, date, total_price, payment_option" +
                     " FROM `order` ";
        
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            
            try (ResultSet rs = ps.executeQuery())
            {
                while (rs.next()) {
                    Order orderItem = new Order();
                    orderItem.setProductId(rs.getInt("product_id"));
                    orderItem.setProductTitle(rs.getString("product_title"));
                    orderItem.setProductDescription(rs.getString("product_description"));
                    orderItem.setProductPrice(rs.getInt("product_price"));
                    orderItem.setTotalPrice(rs.getInt("total_price"));
                    orderItem.setQuantity(rs.getInt("quantity"));
                    orderItem.setProductFile(rs.getString("product_file"));
                    orderItem.setPaymentOption(rs.getString("payment_option"));
                    orderItem.setDate(rs.getDate("date"));
                    
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) { 
            // Handle or log the exception here
            e.printStackTrace();
        }
        
        return orderItems;
    }

    public void updateInStockQty(int productId, int inStock) {
        String sql = "UPDATE product SET instock_qty = ? WHERE product_id = ?";
        
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, inStock);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException se) {
            System.out.println("Error : " + se);
            se.printStackTrace();
        }
    }

    public int getOrderId(int productId, int userId) {
        
    	int orderId = -1;
        String sql = "SELECT order_id" +
                     " FROM `order` " +
                     " WHERE user_id = ? AND product_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orderId = rs.getInt("order_id");
                    
                }
            }
        } catch (SQLException e) {
            // Handle or log the exception here
            e.printStackTrace();
        }

        return orderId;
    }

    public List<Order> getAllOrders() {
    	
        List<Order> orderItems = new ArrayList<>();
        String sql = "SELECT order_id, user_id, product_id, product_title, quantity, date, total_price, payment_option, order_status, address" +
                     " FROM `order` ";
        
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            
            try (ResultSet rs = ps.executeQuery())
            {
                while (rs.next()) {
                	Order orderItem = new Order();
                    orderItem.setOrderId(rs.getInt("order_id"));
                    orderItem.setUserId(rs.getInt("user_id"));
                    orderItem.setProductId(rs.getInt("product_id"));
                    orderItem.setProductTitle(rs.getString("product_title"));
                    orderItem.setOrderQuantity(rs.getInt("quantity"));
                    orderItem.setOrderDate(rs.getDate("date"));
                    orderItem.setOrderTotalPrice(rs.getInt("total_price"));
                    orderItem.setOrderPaymentOption(rs.getString("payment_option"));                   
                    orderItem.setOrderStatus(rs.getString("order_status"));
                    orderItem.setShippingAddress(rs.getString("address"));
                    orderItems.add(orderItem);
                    System.out.println("OrderItems: "+orderItems.toString());
                }
            }
        } catch (SQLException e) { 
            // Handle or log the exception here
            e.printStackTrace();
        }
        
        return orderItems;
    }

    


}
