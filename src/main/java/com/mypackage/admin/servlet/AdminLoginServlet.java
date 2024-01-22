package com.mypackage.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DbConnection;
import com.mypackage.admin.entity.Admin;
import com.mypackage.dao.admin.AdminDao;


public class AdminLoginServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
    public AdminLoginServlet() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		try {
		    String username = req.getParameter("adminusername");
		    String password = req.getParameter("adminpassword");
		    
		    AdminDao adminDao = new AdminDao(DbConnection.getConn());
		    Admin admin = adminDao.login(username, password); // Assuming login() returns a boolean indicating success

		    if (admin != null) {
		    	
		        HttpSession session = req.getSession();
		        session.setAttribute("adminObject", admin);
		        res.sendRedirect("admin/admin-portal.jsp"); // Redirect to admin portal
		    } else {
		        HttpSession session = req.getSession();
		        session.setAttribute("failedMessage", "You are not an admin and cannot log in here!");
		        req.getRequestDispatcher("admin/admin-login.jsp").forward(req, res);
		    }
		} catch (Exception e) {
		    System.out.println("Error: " + e);
		    e.printStackTrace();
		}

		
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
