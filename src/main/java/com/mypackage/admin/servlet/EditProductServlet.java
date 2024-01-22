package com.mypackage.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DbConnection;
import com.mypackage.dao.ProductDao;

public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public EditProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
			
			
			
			
		doGet(req, res);
	}
	

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int productId = Integer.parseInt(req.getParameter("product_id"));
		String productTitle = req.getParameter("productTitle");
		String productDesc = req.getParameter("productDesc");
		int productPrice = Integer.parseInt(req.getParameter("productPrice"));
		int productQty = Integer.parseInt(req.getParameter("productQty"));
		
		System.out.println(productId);
		System.out.println(productTitle);
		System.out.println(productDesc);
		System.out.println(productPrice);
		System.out.println(productQty);
		
		ProductDao pDao = new ProductDao(DbConnection.getConn());
		
		pDao.editProduct(productId, productTitle, productDesc, productPrice, productQty);
		
		System.out.println("Done updation");
		
		res.getWriter().write("Success");
		
		
	}


}
