package com.mypackage.payment;
import java.io.BufferedReader;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Date;
import java.util.HashMap;
import com.mypackage.entity.Payment;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.db.DbConnection;
import com.mypackage.dao.PaymentDao;
import com.razorpay.*;

@SuppressWarnings("serial")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read the JSON data from the request
    	System.out.println("---------------------------------------------------------------");
        System.out.println("Entered YourServlet class....");

        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            String json = sb.toString();
            System.out.println("Received JSON data: " + json);

            // Convert the JSON data to a Map
            Map<String, Object> data = jsonToMap(json);

            // Handle the data as needed
            System.out.println("Data =" + data);

            // Check if the "amount" key exists in the map
            if (data.containsKey("amount")) {
                // Get the value associated with the "amount" key
                Object amountObj = data.get("amount");
                
                // Check if the value is not null
                if (amountObj != null) {
                    // Parse the amount as an integer
                    int amt = Integer.parseInt(amountObj.toString());
                    System.out.print("Amount=" + amt);

                    // Check if the "my_order_id" key exists in the map
                    if (data.containsKey("myorderid")) {
                        // Get the value associated with the "my_order_id" key
                        Object my_order_id_object = data.get("myorderid");
                        
                        // Check if the value is not null
                        if (my_order_id_object != null) {
                            // Parse my_order_id as an integer
                            int myOrderId = Integer.parseInt(my_order_id_object.toString());
                            System.out.println("My Order id : " + myOrderId);
                            
                            // Razorpay client setup
                            RazorpayClient client = new RazorpayClient("rzp_test_9NlQwnOUBr8xWJ", "QPkPgAbvVY5uKEX8XstWO9ld");

                            System.out.println("Razorpay client : " + client);

                            JSONObject ob = new JSONObject();
                            ob.put("amount", amt * 100);
                            ob.put("currency", "INR");

                            // Generate a unique receipt ID based on the current timestamp
                            String receiptId = "txn_" + System.currentTimeMillis();
                            ob.put("receipt", receiptId);

                            System.out.println("JSONObject : " + ob);

                            // creating a new order, which we send to Razorpay...it will return an order of type Order.
                            Order order = client.orders.create(ob);

                            System.out.println("Order returned by Razorpay : " + order);

                            // Store payment data to the database
                            Payment payment = new Payment();
                            payment.setAmount((int) order.get("amount"));
                            payment.setAmount_paid((int) order.get("amount_paid"));
                            payment.setReceiptId((String) order.get("receipt"));
                            payment.setStatus((String) order.get("status"));
                            payment.setMypaymentId((String) order.get("id"));
                            Date createdAtDate = (Date) order.get("created_at");
                            long createdAtTimestamp = createdAtDate.getTime();

                            Instant instant = Instant.ofEpochMilli(createdAtTimestamp);
                            LocalDateTime createdAtDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());

                            System.out.println("Order created at: " + createdAtDateTime);
                            
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            String formattedDateTime = createdAtDateTime.format(formatter);

                            System.out.println("Formatted date and time: " + formattedDateTime);


                            PaymentDao paymentDao = new PaymentDao(DbConnection.getConn());
                            
                            payment.setCreatedDate(formattedDateTime);
                            

                            System.out.println(payment);

                            paymentDao.addPayment(payment, myOrderId);

                            response.setContentType("application/json");
                            response.getWriter().write(order.toString()); // send data back to the Ajax method
                        } else {
                            // Handle the case where the "my_order_id" value is null
                            System.out.println("My Order Id is null");
                        }
                    } else {
                        // Handle the case where the "my_order_id" key is not present in the map
                        System.out.println("My Order Id key not found");
                    }
                } else {
                    // Handle the case where the "amount" value is null
                    System.out.println("Amount is null");
                }
            } else {
                // Handle the case where the "amount" key is not present in the map
                System.out.println("Amount key not found");
            }

        } catch (RazorpayException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Map<String, Object> jsonToMap(String jsonData) {
        Map<String, Object> data = new HashMap<>();

        // Convert the JSON data to a Map
        JSONObject jsonObject = new JSONObject(jsonData);

        // Populate the map with JSON key-value pairs
        for (String key : jsonObject.keySet()) {
            Object value = jsonObject.get(key);
            data.put(key, value);
        }
        System.out.println("Map method data object : " + data);
        return data;
    }
}

