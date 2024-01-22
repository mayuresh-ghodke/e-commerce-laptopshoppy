package com.mypackage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import com.mypackage.entity.Review;

public class ReviewDao {
	
	private Connection conn;

    public ReviewDao(Connection conn) {
        this.conn = conn;
    }

	public void saveReview(Review review) {
		
		
		
		try
        {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO review (product_id, comment, user_id, rating_count) VALUES (?,?,?,?)");
            
            
            ps.setInt(1, review.getProductId());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getUserId());
            ps.setInt(4, review.getRatingCount());     
            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Review Successfully Added");
            } 
            else {
            	System.out.println("Something error");
            }
          
        } 
        catch (SQLException e)
        {
        	System.out.println("Error : "+e);
            e.printStackTrace();
        } 
		
		
	}
	
	public Review getReviewByProductId(int productId) {
	    Review review = new Review(); // Initialize outside the try block

	    try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM review WHERE product_id = ?")) {
	        ps.setInt(1, productId);

	        try (ResultSet rs = ps.executeQuery()) {
	            int totalRatingCount = 0;
	            int reviewCount = 0;
	            StringBuilder comments = new StringBuilder(); // To accumulate comments

	            while (rs.next()) {
	                // Increment the review count
	                reviewCount++;

	                // Accumulate the rating count
	                totalRatingCount += rs.getInt("rating_count");

	                // Accumulate comments
	                comments.append(rs.getString("comment")).append("\n");

	                // Set other properties as needed
	                // Note: You might want to store the reviews in a list if needed
	                // reviewList.add(review);
	            }

	            // Calculate average rating only if there are reviews
	            if (reviewCount > 0) {
	                int averageRating = totalRatingCount / reviewCount;

	                // Set the average rating count and comments in the review object
	                review.setRatingCount(averageRating);
	                review.setComment(comments.toString());
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("Error: " + e);
	        e.printStackTrace();
	    }

	    System.out.println("on return: " + review);
	    return review;
	}



}
