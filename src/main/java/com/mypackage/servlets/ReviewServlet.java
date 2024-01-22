package com.mypackage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DbConnection;
import com.mypackage.dao.ReviewDao;
import com.mypackage.entity.Review;

public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		int productId = Integer.parseInt(request.getParameter("productId"));
		String comment = request.getParameter("comment");
	    int rating = Integer.parseInt(request.getParameter("rating"));
	    
	    System.out.println("Review : ");
	    
	    System.out.println(userId);
	    System.out.println(productId);
	    System.out.println(comment);
	    System.out.println(rating);

	    // Perform database operations to store the data using your DAO
	    ReviewDao reviewDao = new ReviewDao(DbConnection.getConn());
	    
	    Review review = new Review();
	    
	    review.setProductId(productId);
	    review.setRatingCount(rating);
	    review.setComment(comment);
	    review.setUserId(userId);
	    
	    reviewDao.saveReview(review);
	    
		doGet(request, response);
		
		
	}

}
