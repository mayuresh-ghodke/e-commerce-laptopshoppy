package com.mypackage.servlets;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.db.DbConnection;
import com.mypackage.dao.CategoryDao;
import com.mypackage.entity.Category;

public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public CategoryServlet() {
        super();

    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
			doPost(req, res);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException
	{
	    try
	    {  	
	        
	        String categoryTitle = req.getParameter("categoryTitle");
	        String categoryDescription = req.getParameter("categoryDescription");
	        	       
	        try
	        {
	        	Category category = new Category();
	        	category.setCategoryTitle(categoryTitle);
	        	category.setCategoryDescription(categoryDescription);
	        	System.out.println(category.toString()); // debug statement
	        	
				CategoryDao cat_dao = new CategoryDao(DbConnection.getConn());

				cat_dao.addCategory(category);
				System.out.println("giving object to dao.register() method");
				
				HttpSession session=req.getSession();		
				
				session.setAttribute("successMessage", "Category Added Successfuly!");			
				res.sendRedirect("admin/admin-portal.jsp");
				return;      
	        }
	        catch(SQLException exp)
	        {
	        	System.out.println("Error : "+exp);
	        	
	        	exp.printStackTrace();
	        }
	        	
		} 
	    catch (Exception e) 
	    {
	    	System.out.println("Error : "+e);
			e.printStackTrace();
		}
	}
}


