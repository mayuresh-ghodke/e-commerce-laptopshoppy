<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <title>Make Payment</title>
    <!-- Include the script.js file here -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

	

<script>
var paymentStart = () => {
    console.log("Payment started");

    let amount = $("#payment_field").val();
    let myorderid = $("#myorderid_field").val();
    
    console.log("amount", amount);
    console.log("myorderid", myorderid);

    if (amount == '' || amount == null) {
        swal("Failed !!", "Amount is required !!", "error");
        return;
    }

    // We will use ajax to send a request to the server to create an order
    $.ajax({
        type: 'POST',
        url: 'PaymentServlet',
        data: JSON.stringify({ amount: amount, myorderid: myorderid, info: 'order_request' }),
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            console.log("Success ....");
            console.log("Server Response: ", response);
            console.log("amount=", response.amount);
            console.log("Amount paid=", response.order);

            if (response.status == 'created') {
                // open payment Form
                let options = {
                    key: 'rzp_test_9NlQwnOUBr8xWJ',
                    amount: response.amount,
                    currency: 'INR',
                    name: 'laptopshoppy PVT.LTD',
                    description: 'Product Price',
                    image: 'https://cdn.shopify.com/static/shopify-favicon.png',
                    order_id: response.id,
                    handler: function (response) {
                        console.log(response.razorpay_payment_id);
                        console.log(response.razorpay_order_id);
                        console.log(response.razorpay_signature);
                        console.log("Payment successful!!");

                        updatePaymentOnServer(response.razorpay_payment_id, response.razorpay_order_id, "paid");
                        swal("Good job!", "Congrates !! Payment successful !!", "success");
                    },
                    prefill: {
                        name: "",
                        email: "",
                        contact: ""
                    },
                    notes: {
                        address: "Gaurav & Mayuresh Software"
                    },
                    theme: {
                        "color": "#3399cc"
                    },
                };

                let rzp = new Razorpay(options);

                rzp.on('payment.failed', function (response) {
                    console.log(response.error.code);
                    console.log(response.error.description);
                    console.log(response.error.source);
                    console.log(response.error.step);
                    console.log(response.error.reason);
                    console.log(response.error.metadata.order_id);
                    console.log(response.error.metadata.payment_id);
                    swal("Failed !!", "Oops payment failed !!", "error");
                });

                rzp.open();
            }
        },
        error: function (error) {
            console.log(error);
            alert("Something went wrong");
        }
    });
};

function updatePaymentOnServer(payment_id, order_id, statuss) {
    $.ajax({
        type: 'POST',
        url: 'PaymentServlet',
        data: JSON.stringify({
            payment_id: payment_id,
            order_id: order_id,
            status: statuss,
        }),
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            console.log("Good job!", "Congrats !! Payment successful !!", "successs");
            swal("Good job!", "Congrates !! Payment successful !!", "success");
        },
        error: function (error) {
            console.log("Failed !!", "Your payment is successful, but we did not get on the server, we will contact you as soon as possible !!", "error");
            swal("Failed !!", "Your payment is successful, but we did not get on the server, we will contact you as soon as possible !!", "error");
        }
    });
}
</script>
		

	<div class="container">
		<div class="card p-5 bg-white" style="width:50%;margin:100px;">
			<div class="card-header bg-white font-weight-bold text-center">Make Payment</div>
			<div class="card-body form-row">
				<%
					int price = Integer.parseInt(request.getParameter("productPrice"));
					int userId = Integer.parseInt(request.getParameter("productId"));
					int orderId = Integer.parseInt(request.getParameter("orderId"));
				%>
				<input type="text" id="myorderid_field" class="form-control mt-2" value="<%= orderId %>">
				INR: <input id="payment_field" class="form-control mt-2" value="<%= price %>" type="text" readonly>
			</div>
			<div class="card-footer bg-white">
				<button onclick="paymentStart()" style="width:100%;" class="btn btn-outline-success">PAY</button>
			</div>
		</div>
	</div>

	

	
	
    
	

</body>
</html>
