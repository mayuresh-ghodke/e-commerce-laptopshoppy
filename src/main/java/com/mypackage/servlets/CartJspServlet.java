package com.mypackage.servlets;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.db.DbConnection;
import com.mypackage.dao.CartDao;
import com.mypackage.dao.UserDao;

public class CartJspServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;      
    
    public CartJspServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		
		int productId = Integer.parseInt(req.getParameter("productId"));
		String productTitle = req.getParameter("productTitle");
		int productPrice = Integer.parseInt(req.getParameter("productPrice"));
		String userEmail = req.getParameter("userEmail");
		String productDesc = req.getParameter("productDesc");
		int productQuantity = Integer.parseInt(req.getParameter("productQuantity"));
		String productFile = req.getParameter("productFile");
		String increase = req.getParameter("inc");
		
		System.out.println("User Email : "+userEmail);
		
        CartDao cartdao = new CartDao(DbConnection.getConn());
		
		UserDao userdao = new UserDao(DbConnection.getConn());
	    
	    int userId = userdao.getUserId(userEmail);  
	    
	    System.out.println("CartServlet is Called");
	   	    
	    System.out.println("Product ID : "+productId);
        System.out.println("Product Title : "+productTitle);
        System.out.println("Product Price : "+productPrice);  
        System.out.println("Product Description : "+productDesc);
        System.out.println("Product Quantity : +"+productQuantity);
        System.out.println("Product File : +"+productFile);
        System.out.println("CartServlet => User Id : "+userId);
        System.out.println("Action is : "+increase);
                                
        
        	try
        	{        		
        		if(productQuantity > 0) {
        		cartdao.updateQuantityAndPriceFromCart(productQuantity, userId, productId);
    		    HttpSession session = req.getSession();
    		    session.setAttribute("successMessage", "Product Quantity Updated Successfully!");
        	}
        	}
        	catch(SQLException se)
        	{
        		System.out.println("Error : "+se);
        	}
        
        	
		HttpSession session=req.getSession();		
		
		System.out.println("Session Started");
		
		session.setAttribute("successMessage", "Product Quantity Updated Successfully!");	
		
		res.sendRedirect("cart.jsp");          
	}

}
