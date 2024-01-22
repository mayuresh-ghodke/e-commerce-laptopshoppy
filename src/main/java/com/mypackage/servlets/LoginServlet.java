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

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String email = req.getParameter("username");
		String password = req.getParameter("userpassword");
	
		try
		{		
			HttpSession session = req.getSession();
			if(email.isEmpty() || password.isEmpty()) {
				session.setAttribute("failedMessage", "Login Failed, Invalid email or password.\nTry Again");
				System.out.println("Failed");
				//res.sendRedirect("login.jsp");
				res.getWriter().write("LoginFailed");
				return;
			}
			
			UserDao dao = new UserDao(DbConnection.getConn());				
									
			User user = dao.login(email, password);							
			if (user != null) 
			{			
				session.setAttribute("userObject", user);
				System.out.println("User :"+user.getUserName());
				System.out.println("Login Successfull");
				res.sendRedirect("index.jsp");
				
				return;
			}
			else
			{
				session.setAttribute("failedMessage", "Login Failed, Invalid email or password.\nTry Again");
				System.out.println("Failed");
				//res.sendRedirect("login.jsp");
				
				res.getWriter().write("LoginFailed");
				
			}
		}
		catch(Exception exp)
		{
			System.out.println("Error : "+exp);
		}				
	}		
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
