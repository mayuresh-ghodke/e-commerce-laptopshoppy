package com.mypackage.entity;

public class Payment {

	
	
	private int paymentPrimaryId;
	
	private String mypaymentId;//payment_order_id
	
	private int amount;
	

	private String receiptId;
	
	private String status;
	
	private String createdDate;

	private int amount_paid;
	
	public Payment(){
		
		
	}
	
	public String getReceiptId() {
		return receiptId;
	}

	public void setReceiptId(String receiptId) {
		this.receiptId = receiptId;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String date) {
		this.createdDate = date;
	}

	public int getAmount_paid() {
		return amount_paid;
	}

	public void setAmount_paid(int amount_paid) {
		this.amount_paid = amount_paid;
	}

	public int getPaymentPrimaryId() {
		return paymentPrimaryId;
	}

	public String getCurrency() {
		return currency;
	}

	
	private final static String currency = "INR";

	public String getMypaymentId() {
		return mypaymentId;
	}

	public void setMypaymentId(String mypaymentId) {
		this.mypaymentId = mypaymentId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getreceiptId() {
		return receiptId;
	}

	public void setreceiptId(String receiptId) {
		this.receiptId = receiptId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public Payment(int paymentPrimaryId, String mypaymentId, int amount, String receiptId, String status,
			String createdDate, int amount_paid) {
		super();
		this.paymentPrimaryId = paymentPrimaryId;
		this.mypaymentId = mypaymentId;
		this.amount = amount;
		this.receiptId = receiptId;
		this.status = status;
		this.createdDate = createdDate;
		this.amount_paid = amount_paid;
	}

	@Override
	public String toString() {
		return "Payment [paymentPrimaryId=" + paymentPrimaryId + ", mypaymentId=" + mypaymentId + ", amount=" + amount
				+ ", receiptId=" + receiptId + ", status=" + status + ", createdDate=" + createdDate + ", amount_paid="
				+ amount_paid + "]";
	}
	
	
}