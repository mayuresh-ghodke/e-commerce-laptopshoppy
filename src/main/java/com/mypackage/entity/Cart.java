package com.mypackage.entity;

public class Cart extends Product
{
    private int cartId;
    private int quantity;
    private int userId;
	private int totalPrice;
    
    public Cart() {}
   
	public Cart(int cartId, int quantity, int userId, int totalPrice)
    {
        this.cartId = cartId;
        this.quantity = quantity; 
        this.userId = userId;
        this.totalPrice = totalPrice;
    }
	

	// Getters and setters

    public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}   
	
	public void setTotalPrice(int price)
	{
		this.totalPrice = price;
	}
	public int getTotalPrice()
	{
		return totalPrice;
	}
}
