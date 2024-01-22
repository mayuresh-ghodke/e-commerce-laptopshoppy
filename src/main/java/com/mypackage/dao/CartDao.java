package com.mypackage.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.mypackage.entity.Cart;


public class CartDao {
    
	private Connection conn;

    public CartDao(Connection conn) {
		this.conn = conn;		
	}
       
    public void addCart(Cart cart) throws SQLException
    {         	
        try
        {       	
            PreparedStatement ps = conn.prepareStatement("INSERT INTO cart (product_id, user_id, product_title, product_description, product_price, quantity, product_file) VALUES (?,?,?,?,?,?,?)");
            
            ps.setInt(1, cart.getProductId());
            ps.setInt(2, cart.getUserId());
            ps.setString(3, cart.getProductTitle());
            ps.setString(4, cart.getProductDescription());
            ps.setInt(5, cart.getProductPrice());
            ps.setInt(6, cart.getQuantity());
            ps.setString(7, cart.getProductFile());                    
            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Cart Successfully Added");
            } 
            else {
            	System.out.println("Something error");
            }          
        } 
        catch (SQLException e)
        {
        	System.out.println("Error : "+e);
            e.printStackTrace();
        }        
    }
    
    public void updateQuantity(int quantity, int userId, int productId) throws SQLException {
        try {
            // Check if the product already exists in the cart for the user
        	System.out.println("1. this is update quantity()");
            PreparedStatement checkPs = conn.prepareStatement("SELECT * FROM cart WHERE user_id = ? AND product_id = ?");
            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();
        	System.out.println("2. this is update quantity()");

            if (rs.next()) {
            	
                // Product exists in the cart, update its quantity
            	System.out.println("rs.next()");
                int existingQuantity = rs.getInt("quantity");
                int existingPrice = rs.getInt("product_price");
                System.out.println("Existing Quantity : " + existingQuantity);
                System.out.println("Existing Price : " + existingPrice);
                quantity += existingQuantity; // Increment the existing quantity
                int newPrice = quantity * existingPrice;
                System.out.println("Updated Existing Price : " + newPrice);
            	System.out.println("3. this is update quantity()");

                // Update the cart item with the new quantity
                PreparedStatement updatePs = conn.prepareStatement("UPDATE cart SET quantity = ?, total_price = ? WHERE user_id = ? AND product_id = ?");
                updatePs.setInt(1, quantity);
                updatePs.setInt(2, newPrice);
                updatePs.setInt(3, userId);
                updatePs.setInt(4, productId);
                int rowsAffected = updatePs.executeUpdate();

                if (rowsAffected > 0) {
                    System.out.println("Cart Quantity Successfully Updated");
                } else {
                    System.out.println("No rows were updated");
                }
                updatePs.close();
            }

            rs.close();
            checkPs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error: " + e);
        }
    }



    
    public List<Cart> getCartItems(int userId)
    {
        List<Cart> cartItems = new ArrayList<>();
        try
        {
            String sql = "SELECT product_id, user_id, product_title, product_description, product_price, quantity, product_file " +
                         "FROM cart " +
                         "WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart cartItem = new Cart();
                cartItem.setProductId(rs.getInt("product_id"));
                cartItem.setProductTitle(rs.getString("product_title"));
                cartItem.setProductDescription(rs.getString("product_description"));
                cartItem.setProductPrice(rs.getInt("product_price"));
                cartItem.setQuantity(rs.getInt("quantity"));
                cartItem.setProductFile(rs.getString("product_file"));
                cartItems.add(cartItem);
            }
            rs.close();
            ps.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return cartItems;
    }
    
    //to check product of a user and product is already there in cart or not

    public boolean checkProductAvailability(int userId, int productId) {
        boolean productFound = false;

        try {
            String sql = "SELECT product_id, user_id " +
                         "FROM cart " +
                         "WHERE user_id = ? AND product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            // If there's a result in the ResultSet, the product is already in the cart
            productFound = rs.next();

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        System.out.println("Product Found Result : "+productFound);
        return productFound;
    }

	public void deleteProductFromCart(int productId, int userId)
	{
		String sql = "DELETE FROM cart WHERE product_id = ? AND user_id = ?";
	    
	    try 
	    {
	    	PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, productId);
	        ps.setInt(2, userId);
	        
	        int rowsAffected = ps.executeUpdate();
	        
	        if (rowsAffected > 0) {
	            System.out.println("Product deleted from cart.");
	        } else {
	            System.out.println("Product not found in the cart.");
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	
	}
	
	public int getCartSize(int userId)
	{
		int count = 0;
			
		try
		{
			String sql = "SELECT * from cart where user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
            	count++;
            }

            rs.close();
            ps.close();
        }
		catch (SQLException e)
		{
            e.printStackTrace();
            System.out.println("Error : "+e);
        }
		
		System.out.println("Cart count is : "+count);
		return count;
	}
	
	public int getProductTotalPrice(int productId, int quantity) {
	    int totalPrice = 1; 
	    
	    try {
	        String sql = "SELECT product_price from cart where product_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ps.setInt(1, productId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            int productPrice = rs.getInt("product_price"); 
	            totalPrice += productPrice * quantity; 
	        }

	        rs.close();
	        ps.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("Error: " + e);
	    }

	    System.out.println("Total Price is: " + totalPrice);
	    return totalPrice;
	}
	
	public void updateQuantityAndPriceFromCart(int quantity, int userId, int productId) throws SQLException {
        try {
            // Check if the product already exists in the cart for the user
        	System.out.println("1. this is update quantity()");
            PreparedStatement checkPs = conn.prepareStatement("SELECT * FROM cart WHERE user_id = ? AND product_id = ?");
            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();
        	System.out.println("2. this is update quantity()");

            if (rs.next()) {
            	
                // Product exists in the cart, update its quantity
            	System.out.println("rs.next()");                
                int existingPrice = rs.getInt("product_price");
                System.out.println("Existing Quantity : " + quantity);
                System.out.println("Existing Price : " + existingPrice);
                int newPrice = quantity * existingPrice;
                System.out.println("Updated Existing Price : " + newPrice);
            	System.out.println("3. this is update quantity()");

                // Update the cart item with the new quantity
                PreparedStatement updatePs = conn.prepareStatement("UPDATE cart SET quantity = ?, total_price = ? WHERE user_id = ? AND product_id = ?");
                updatePs.setInt(1, quantity);
                updatePs.setInt(2, newPrice);
                updatePs.setInt(3, userId);
                updatePs.setInt(4, productId);
                int rowsAffected = updatePs.executeUpdate();

                if (rowsAffected > 0) {
                    System.out.println("Cart Quantity Successfully Updated");
                } else {
                    System.out.println("No rows were updated");
                }
                updatePs.close();
            }

            rs.close();
            checkPs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error: " + e);
        }
    }
}
