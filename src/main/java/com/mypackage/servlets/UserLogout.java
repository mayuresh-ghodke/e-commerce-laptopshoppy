package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class UserLogout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public UserLogout() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		HttpSession session = req.getSession();
		session.removeAttribute("userObject");
		System.out.println("User object removed");
		session.setAttribute("message", "User Logout Sucessfully");
		res.sendRedirect("index.jsp");
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
