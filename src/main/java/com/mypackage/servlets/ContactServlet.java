package com.mypackage.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public ContactServlet() {
        super();
        
    }
    
    

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String mobile = req.getParameter("mobile");
			String message = req.getParameter("message");
			
			PrintWriter out = res.getWriter();
			
			if (name.isEmpty() || email.isEmpty() || mobile.isEmpty() || message.isEmpty()) {
		        // Set the response content type
		        res.setContentType("text/html;charset=UTF-8");

		        // Display an alert message in the HTML response
		        out.println("<html>");
		        out.println("<head><title>Form Validation</title></head>");
		        out.println("<body>");
		        out.println("<script>alert('All information must be filled.');</script>");
		        out.println("</body>");
		        out.println("</html>");

		        return; // Stop further processing
		    }
		doGet(req, res);
	}

}
