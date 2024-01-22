package com.mypackage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mypackage.entity.Product;

public class ProductDao {

    private Connection conn;

    public ProductDao(Connection conn) {
        this.conn = conn;
    }

    public void addProduct(Product product) throws SQLException
    {     
        try
        {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO product (product_title,product_description,product_price,product_file,category_id, product_qty, instock_qty) VALUES (?,?,?,?,?,?,?)");
            
            
            ps.setString(1, product.getProductTitle());
            ps.setString(2, product.getProductDescription());
            ps.setInt(3, product.getProductPrice());
            ps.setString(4, product.getProductFile());     
            ps.setInt(5, product.getCategoryId());
            ps.setInt(6, product.getProductQty());
            ps.setInt(7, product.getProductQty());  
            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Product Successfully Added");
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
    
    public List<Product> getProducts()
    {
		List<Product> list = new ArrayList<Product>();
		Product product = null;

		try
		{
			String sql = "select * from product";
			
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				product = new Product();
				
				product.setProductId(rs.getInt(1));
				product.setProductTitle(rs.getString(2));
				product.setProductDescription(rs.getString(3));
				product.setProductPrice(rs.getInt(4));
				product.setProductFile(rs.getString(5));
				product.setProductQty(rs.getInt(6));
				product.setInStockQty(rs.getInt(7));
				list.add(product);
			}
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
    
    public Product getProductById(int productId) {
        Product product = null; 
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM product WHERE product_id = ?");
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Initialize the product only if there is a matching record
                product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductTitle(rs.getString("product_title"));
                product.setProductPrice(rs.getInt("product_price"));
                product.setProductDescription(rs.getString("product_description"));
                product.setProductFile(rs.getString("product_file"));
                product.setProductQty(rs.getInt("product_qty"));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e);
            e.printStackTrace();
        }
        System.out.println("on return: " + product);
        return product;
    }

    
    //get all  products of given category
    public List<Product> getAllProductsById(int cid) {
        List<Product> products = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM product WHERE category_id = ?");
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductTitle(rs.getString("product_title"));
                product.setProductPrice(rs.getInt("product_price"));
                product.setProductDescription(rs.getString("product_description"));
                product.setProductFile(rs.getString("product_file"));
                product.setProductQty(rs.getInt("product_qty"));
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error : " + e);
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getAllProducts(int userId) {
        List<Product> products = new ArrayList<>();

        try {
            String sql = "SELECT product_id, product_title, product_price, product_description FROM product";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductTitle(rs.getString("product_title"));
                product.setProductPrice(rs.getInt("product_price"));
                product.setProductDescription(rs.getString("product_description")); 
                products.add(product);
            }

            // Close the ResultSet and PreparedStatement after usage
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public void deleteProduct(int productId)
	{
		String sql = "DELETE FROM product WHERE product_id = ?";
	    
	    try 
	    {
	    	PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, productId);
	        
	        int rowsAffected = ps.executeUpdate();
	        
	        if (rowsAffected > 0) {
	            System.out.println("Product deleted.");
	        } else {
	            System.out.println("Product not deleted.");
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	
	}

    public int getProductInStockQtyById(int productId) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT instock_qty FROM product WHERE product_id = ?");
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int productQty = rs.getInt("instock_qty");
                return productQty;
            }
        } catch (SQLException e) {
            System.out.println("Error : " + e); 
            e.printStackTrace();
        }
        
        return 0; 
    }
    
    public boolean isProductInStockQty(int productId) {
        String sql = "SELECT instock_qty FROM product WHERE product_id = ?";
        
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int inStockQty = rs.getInt("instock_qty");
                return inStockQty > 0;
            }
        } catch (SQLException se) {
            System.out.println("Error : " + se);
            se.printStackTrace();
        }
        
        return false; // Default value if product is not found or in-stock quantity is not positive
    }

    public void editProduct(int productId, String productTitle, String productDesc, int productPrice, int productQty) {
        try {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE product SET product_title=?, product_description=?, product_price=?, product_qty=? WHERE product_id=?"
            );

            ps.setString(1, productTitle);
            ps.setString(2, productDesc);
            ps.setInt(3, productPrice);
            ps.setInt(4, productQty);
            ps.setInt(5, productId); 

            int i = ps.executeUpdate();

            if (i > 0) {
                System.out.println("Product Successfully Updated");
            } else {
                System.out.println("Something went wrong");
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e);
            e.printStackTrace();
        }
    }




	  	
}