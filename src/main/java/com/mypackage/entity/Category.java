package com.mypackage.entity;

import java.util.ArrayList;
import java.util.List;

public class Category {
	
	private int categoryId;
	
	private String categoryTitle;
	
	private String categoryDescription;
	
	public Category(int categoryId, String categoryTitle, String categoryDescription, List<Product> products) {
		super();
		this.categoryId = categoryId;
		this.categoryTitle = categoryTitle;
		this.categoryDescription = categoryDescription;
		this.products = products;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	private List<Product> products = new ArrayList<>();
	
	public Category() {
		
	}
		
	public Category(int categoryId,String categoryTitle, String categoryDescription)
	{
		super();
		this.categoryId=categoryId;
		this.categoryTitle = categoryTitle;
		this.categoryDescription = categoryDescription;
	}
	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getCategoryDescription() {
		return categoryDescription;
	}

	public void setCategoryDescription(String categoryDescription) {
		this.categoryDescription = categoryDescription;
	}

	@Override
	public String toString() {
		return "Category [categoryTitle=" + categoryTitle + ", categoryDescription=" + categoryDescription + "]";
	}
	
	
}
