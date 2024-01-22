package com.mypackage.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DbConnection;
import com.mypackage.dao.ProductDao;


public class ProductDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ProductDelete() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int productId = Integer.parseInt(req.getParameter("productId"));
		System.out.println("Product Id : "+productId);
		
		ProductDao proDao = new ProductDao(DbConnection.getConn());
		
		proDao.deleteProduct(productId);
		
		res.sendRedirect("admin/admin-portal.jsp");
		res.getWriter().append("Served at: ").append(req.getContextPath());
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		doGet(req, res);
	}

}
