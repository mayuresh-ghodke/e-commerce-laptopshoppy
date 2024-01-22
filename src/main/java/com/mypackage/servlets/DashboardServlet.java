package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.db.DbConnection;
import com.mypackage.dao.UserDao;
import com.mypackage.entity.User;

public class DashboardServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
    public DashboardServlet() {
        super();
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
	
				String usernmae=req.getParameter("name");
		        String userPassword = req.getParameter("password");
		        String userPhone = req.getParameter("contact");
		        String userAddress = req.getParameter("address");
		       		        
		        User user = new User();
				
				user.setUserName(usernmae);
				user.setUserPassword(userPassword);
				user.setUserPhone(userPhone);
				user.setUserAddress(userAddress);
				
				System.out.println("creating user object for updation");
				System.out.println(user.toString()); // debug statement
				
				UserDao dao = new UserDao(DbConnection.getConn());

				dao.updateInformation(user);
				System.out.println("giving object to dao.updateInformation() method");
				
				HttpSession session=req.getSession();
				
				session.setAttribute("successMessage", "Information Updated Successfuly!");
				
				res.sendRedirect("dashboard.jsp");
		        	
	} 	
	


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
