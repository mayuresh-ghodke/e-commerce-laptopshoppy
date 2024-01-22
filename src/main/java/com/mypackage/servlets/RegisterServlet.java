package com.mypackage.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;
import com.db.DbConnection;
import com.mypackage.dao.UserDao;
import com.mypackage.entity.User;


public class RegisterServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;    
    
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException
	{  
	    		
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		
		PrintWriter pw = res.getWriter();
	    
	    try
	    {  	
	        String userName = req.getParameter("userName");
	        String userEmail = req.getParameter("userEmail");
	        String userPassword = req.getParameter("userPassword");
	        String userPhone = req.getParameter("userPhone");
	        String userAddress = req.getParameter("userAddress");
	        
	        // validations
	        if (userName.isEmpty() || userEmail.isEmpty() || userPassword.isEmpty() || userPhone.isEmpty() || userAddress.isEmpty()) 
	        {
	        	pw.println("<script type='text/javascript'>");
	            pw.println("alert('All Information Must Be Filled.');");
	            pw.println("window.location.href = 'register.jsp';");  // Redirect to the registration page
	            pw.println("</script>");
	            
	            return;
	        }
	        
	        String phoneNumber = userPhone;

        	if (phoneNumber.startsWith("+91")) {
        	    
        	    phoneNumber = phoneNumber.substring(3);
        	}

        	System.out.println("Trimmed Phone Number: " + phoneNumber);
	         
	        try {
	            UserDao dao = new UserDao(DbConnection.getConn());
	            boolean forPhone = dao.checkPhoneExists(phoneNumber);
	            boolean forEmail = dao.checkEmailExists(userEmail);

	            if (!forPhone && !forEmail) {
	            	

	                User user = new User(userName, userEmail, userPassword, phoneNumber, userAddress);
	                System.out.println("creating user object");
	                System.out.println(user.toString()); // debug statement

	                dao.register(user);
	                System.out.println("giving object to dao.register() method");

	                HttpSession session = req.getSession();

	                session.setAttribute("userObject", user);

	                // res.sendRedirect("index.jsp");

	                if (user != null) {
	                    res.getWriter().write("RegisterSuccess");
	                    return;
	                }
	            }
	        } catch (SQLException exp) {
	            System.out.println("Error : " + exp);
	            res.getWriter().write("RegisterFailed" + exp);
	            exp.printStackTrace();
	        }

	        	
		} 
	    catch (Exception e) 
	    {
	    	System.out.println("Error : "+e);
			e.printStackTrace();
		}
		doGet(req, res);
	}
}

