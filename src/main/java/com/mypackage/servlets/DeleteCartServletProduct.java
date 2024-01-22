package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.db.DbConnection;
import com.mypackage.dao.CartDao;

public class DeleteCartServletProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public DeleteCartServletProduct() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		
		int productId = Integer.parseInt(req.getParameter("productId"));
		int userId = Integer.parseInt(req.getParameter("userId"));
		
		System.out.println("=== Delete product from cart === ");
		
		CartDao cartdao = new CartDao(DbConnection.getConn());
		
		cartdao.deleteProductFromCart(productId, userId);
		
		res.sendRedirect("cart.jsp");
		
		
	}

}
