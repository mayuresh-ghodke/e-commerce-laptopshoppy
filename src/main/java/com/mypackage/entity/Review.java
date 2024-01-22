package com.mypackage.entity;

public class Review {
	
	private int reviewId;
	
	private int ratingCount;
	
	private String comment;
	
	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", ratingCount=" + ratingCount + ", comment=" + comment + ", userId="
				+ userId + ", productId=" + productId + "]";
	}
	
	public Review() {}

	public Review(int reviewId, int ratingCount, String comment, int userId, int productId) {
		super();
		this.reviewId = reviewId;
		this.ratingCount = ratingCount;
		this.comment = comment;
		this.userId = userId;
		this.productId = productId;
	}
	
	
	public int getReviewId() {
		return reviewId;
	}

	public int getRatingCount() {
		return ratingCount;
	}

	public String getComment() {
		return comment;
	}

	public int getUserId() {
		return userId;
	}

	public int getProductId() {
		return productId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public void setRatingCount(int ratingCount) {
		this.ratingCount = ratingCount;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	private int userId;
	
	private int productId;

}
