package com.mypackage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.mypackage.entity.Payment;


public class PaymentDao {

	private Connection conn;

    public PaymentDao(Connection conn) {
        this.conn = conn;
    }
      
    public void addPayment(Payment payment, int orderId) throws SQLException
    {     
        try
        {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO laptopshopdb.payment (payment_amount, receipt_id, currency, amount_paid, created_at, payment_order_id, status, order_id) VALUES (?,?,?,?,?,?,?,?)");
            
            System.out.println("Add Payment()");
            System.out.println("Payment Amount : "+payment.getAmount());
            System.out.println("Payment mypayment id : "+payment.getMypaymentId());
            System.out.println("Payment receipt Id : "+payment.getreceiptId());
            System.out.println("Payment Status : "+payment.getStatus());
            
            ps.setInt(1, payment.getAmount());
            ps.setString(2, payment.getReceiptId());
            ps.setString(3, payment.getCurrency());
            ps.setInt(4, payment.getAmount_paid());
            ps.setString(5, payment.getCreatedDate());
            ps.setString(6, payment.getMypaymentId());
            ps.setString(7, payment.getStatus());
            ps.setInt(8, orderId);
           
            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Payment Successfully inserted in database");
            } 
            else {
            	System.out.println("got error to storing payment detais on database");
            }
          
        } 
        catch (SQLException e)
        {
        	System.out.println("Error : "+e);
            e.printStackTrace();
        }        
    }
}
