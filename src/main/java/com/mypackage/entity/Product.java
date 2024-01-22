package com.mypackage.entity;

public class Product {
	
	private int productId;
	
	private String productTitle;
	
	private String productDescription;
	
	private int productPrice;
	
	private String productFile;
	
	private int productQty;
	
	private int inStockQty;
	
	

	public int getInStockQty() {
		return inStockQty;
	}

	public void setInStockQty(int inStockQty) {
		this.inStockQty = inStockQty;
	}

	public int getProductQty() {
		return productQty;
	}

	public void setProductQty(int pruductQty) {
		this.productQty = pruductQty;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice){
		this.productPrice = productPrice;
	}

	public String getProductFile() {
		return productFile;
	}

	public void setProductFile(String productFile) {
		this.productFile = productFile;
	}
	
	public Product() {
		
	}
	
	private Category category;
	
	
	private int categoryId;
	
	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}


	//Constructor with Category category
	public Product(int productId, String productTitle, String productDescription, int productPrice, String productFile,
			Category category) {
		super();
		this.productId = productId;
		this.productTitle = productTitle;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productFile = productFile;
		this.category = category;
	}


	public Product(int productId, String productTitle, String productDescription, int productPrice,
			String productFile) {
		super();
		this.productId = productId;
		this.productTitle = productTitle;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productFile = productFile;
	}

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productTitle=" + productTitle + ", productDescription="
				+ productDescription + ", productPrice=" + productPrice + ", productFile=" + productFile
				+ ", categoryId=" + categoryId + ", category=" + category + "]";
	}

	

	
	
}
