package com.mypackage.entity;

//import java.time.LocalDateTime;
import java.util.Date;

public class Order extends Cart{
	private int orderId;
	private String contact;
	private String email;
	private String address;
	private String paymentOption;
	private Date date;
	private String orderStatus;
	
	private String orderPaymentOption;
	private int orderTotalPrice;
	private int orderQuantity;
	private String shippingAddress;
	
	
	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public String getOrderPaymentOption() {
		return orderPaymentOption;
	}

	public void setOrderPaymentOption(String orderPaymentOption) {
		this.orderPaymentOption = orderPaymentOption;
	}

	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	private Date orderDate;

	

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}

	public void setDate(Date date) {
        this.date = date;
    }

    public Date getDate() {
        return date;
    }
	
	
	
}
