package com.mypackage.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.db.DbConnection;
import com.mypackage.dao.ProductDao;
import com.mypackage.entity.Product;


@MultipartConfig
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
	    try
	    {  	
	         
	        String productTitle = req.getParameter("productTitle");
	        String productDescription = req.getParameter("productDescription");
	        int productPrice = Integer.parseInt(req.getParameter("productPrice"));        
	        Part part = req.getPart("productFile");        
	        int catId = Integer.parseInt(req.getParameter("catId"));
	        int productQty = Integer.parseInt(req.getParameter("productQty"));
	               	       
	        try
	        {
	        	Product product = new Product();
	       
	        	
	        	product.setProductTitle(productTitle);
	        	product.setProductDescription(productDescription);
	        	product.setProductPrice(productPrice);
	        	product.setProductFile(part.getSubmittedFileName());
                product.setCategoryId(catId);
                product.setProductQty(productQty);
	                	
	        	System.out.println("creating product object");
	        	
	        	System.out.println(product.toString()); // debug statement
	        	
				ProductDao pro_dao = new ProductDao(DbConnection.getConn());

				pro_dao.addProduct(product);
				
				System.out.println("giving object to pro_dao.addProduct() method");
				
				
				//pic upload
				//find out the path to upload photo
              
				String path = req.getRealPath("Images") + File.separator + "products" + File.separator + part.getSubmittedFileName();
                System.out.println(path);
	              //uploading code..
	              try
	              {
	
	                  FileOutputStream fos = new FileOutputStream(path);
	
	                  InputStream is = part.getInputStream();
	
	                  //reading data
	                  byte[] data = new byte[is.available()];
	
	                  is.read(data);
	
	                  //writing the data
	                  fos.write(data);
	
	                  fos.close();
	
	              }
	              catch (Exception e)
	              {
	            	  System.out.println("Error : "+e);
	                  e.printStackTrace();               
	              }
				
				HttpSession session=req.getSession();		
				
				System.out.println("Session Started");
				
				session.setAttribute("successMessage", "Product Added Successfuly!");	
				
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
