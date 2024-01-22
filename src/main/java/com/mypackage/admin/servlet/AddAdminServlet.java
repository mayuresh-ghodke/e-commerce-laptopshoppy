package com.mypackage.admin.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DbConnection;
import com.mypackage.admin.entity.Admin;
import com.mypackage.dao.admin.AdminDao;


public class AddAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddAdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		String adminName = req.getParameter("adminName");
		String adminEmail = req.getParameter("adminEmail");
		String adminMobile = req.getParameter("adminMobile");
		String adminPassword = req.getParameter("adminPass");

		System.out.println("Admin Name: " + adminName);
		System.out.println("Admin Email: " + adminEmail);
		System.out.println("Admin Mobile: " + adminMobile);
		System.out.println("Admin Password: " + adminPassword);

		// Perform further processing, such as adding the admin to a database, etc.

		// Optionally, redirect or respond to the client
		res.sendRedirect("admin/admin-portal.jsp");

		
		System.out.println("Admin Name: " + adminName);
		System.out.println("Admin Email: " + adminEmail);
		System.out.println("Admin Mobile: " + adminMobile);
		System.out.println("Admin Password: " + adminPassword);
		
		Admin admin = new Admin();
		
		AdminDao adminDao = new AdminDao(DbConnection.getConn());
		
		admin.setAdminEmail(adminEmail);
		admin.setAdminName(adminName);
		admin.setAdminMobile(adminMobile);
		admin.setAdminPassword(adminPassword);
		
		try {
			adminDao.register(admin);
		} catch (SQLException e) {
			System.out.println("Error : "+e);
			e.printStackTrace();
		}
		res.getWriter().append("Served at: ").append(req.getContextPath());
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		
		doGet(req, res);
	}

}
