package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.db.DbConnection;
import com.mypackage.dao.UserDao;

public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public ChangePassword() {
        super();

    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String userEmail = req.getParameter("useremail");
		String currentPassword = req.getParameter("currentpassword");
		String newPassword = req.getParameter("newpassword");
		
		UserDao dao = new UserDao(DbConnection.getConn());
		HttpSession session = req.getSession();
		
		if(currentPassword.equals(newPassword))
		{
			System.out.println("New Password not be same as old passowrd");
			session.setAttribute("failedMessage", "New Password not be same as old passowrd");
			res.sendRedirect("change-password.jsp");
			return;
		}
		
		if (dao.checkOldPassword(userEmail, currentPassword)) {

			if (dao.changePassword(userEmail, newPassword))
			{
				System.out.println("Successful");
				session.setAttribute("successMessage", "Password Change Sucessfully");
				res.sendRedirect("change-password.jsp");
			} 
			else
			{
				session.setAttribute("successMessage", "Successful");
				res.sendRedirect("change-password.jsp");
			}
		} 
		else
		{
			session.setAttribute("failedMessage", "Old Password is Incorrect");
			res.sendRedirect("change-password.jsp");
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
