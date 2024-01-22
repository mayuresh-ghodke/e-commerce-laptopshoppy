package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DbConnection;
import com.mypackage.dao.UserDao;

public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public ForgotPassword() {
        super();

    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String userEmail = req.getParameter("useremail");
		String userPassword = req.getParameter("newpassword");
		
		UserDao dao = new UserDao(DbConnection.getConn());
		HttpSession session = req.getSession();
		
		boolean val = dao.checkOldPassword(userEmail, userPassword);		
		if(val)
		{
			System.out.println("Try Another Password");
			session.setAttribute("failedMessage", "Try Another Password");
			res.sendRedirect("forgot-password.jsp");
		}
		else
		{
			dao.changePassword(userEmail, userPassword);
			System.out.println("Successful");
			session.setAttribute("successMessage", "Password Change Sucessfully");
			res.sendRedirect("forgot-password.jsp");
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
