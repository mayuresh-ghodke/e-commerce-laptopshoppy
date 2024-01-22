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