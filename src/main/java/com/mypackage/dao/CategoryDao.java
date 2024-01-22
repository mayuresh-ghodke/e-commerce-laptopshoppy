package com.mypackage.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.mypackage.entity.Category;

public class CategoryDao { 

    private Connection conn;
 
    public CategoryDao(Connection conn) {
        this.conn = conn;
    }

    //Add Category 
    public void addCategory(Category category) throws SQLException
    {     
        try
        {
            PreparedStatement ps = conn.prepareStatement("insert into category(category_title,category_description) values (?,?)");            
            ps.setString(1, category.getCategoryTitle());
            ps.setString(2, category.getCategoryDescription());
            
            int i=ps.executeUpdate();            
            if(i>0) {
            	System.out.println("Successfully Added");
            }
            else {
            	System.out.println("Something error");
            }        
        } 
        catch (SQLException e)
        {
            e.printStackTrace();
        }        
    }
    
    
    
    //Delete category by name
    
    public List<Category> getCategories() {
		List<Category> list = new ArrayList<Category>();
		Category category = null;

		try
		{
			String sql = "select * from category";
			
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				category = new Category();
				
				category.setCategoryId(rs.getInt(1));
				category.setCategoryTitle(rs.getString(2));
				category.setCategoryDescription(rs.getString(3));
				
				list.add(category);
			}

		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
    
    //Get Category By CategoryId
    public Category getCategoryById(int catId)
    {
        Category category = null;
        try
        {
        	String sql = "SELECT c.category_id FROM category c JOIN product p ON c.category_id = p.category_id WHERE p.product_id = ?";
			
			PreparedStatement ps = conn.prepareStatement(sql);			
			ps.setInt(1, catId);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				category = new Category();			
				category.setCategoryId(rs.getInt(1));
			}
        }
        catch (SQLException e)
        {
        	System.out.println("Error : "+e);
            e.printStackTrace();
        }
        return category;
    }
    
    //Get Category By Id To Delete
    
    public void deleteCategory(int categoryId)
	{
		String sql = "DELETE FROM category WHERE category_id = ?";
	    
	    try 
	    {
	    	PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, categoryId);
	        
	        int rowsAffected = ps.executeUpdate();
	        
	        if (rowsAffected > 0) {
	            System.out.println("Category deleted.");
	        } else {
	            System.out.println("Category not deleted.");
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	
	}
    
}
