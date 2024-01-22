package com.mypackage.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DbConnection;
import com.mypackage.dao.CategoryDao;


public class CategoryDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public CategoryDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		System.out.println("CategoryId : "+categoryId);
		
		CategoryDao  catDao = new CategoryDao(DbConnection.getConn());
		
		catDao.deleteCategory(categoryId);
		
		response.sendRedirect("admin/admin-portal.jsp");
		
		
		
		
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
