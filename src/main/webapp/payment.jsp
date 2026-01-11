<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Secure Payment - Purrfect Store</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .payment-box { max-width: 500px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 10px; background: #fff; }
        .input-group { margin-bottom: 15px; }
        .input-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .input-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .payment-btn { width: 100%; padding: 12px; background-color: #ff9900; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .payment-btn:hover { background-color: #e68a00; }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-box">
            <h2 style="text-align: center;">💳 Payment Details</h2>
            <hr>
            <p style="font-size: 18px;">Amount to Pay: <strong>RM ${param.total}</strong></p>
            
            <form action="update-cart" method="post">
                <input type="hidden" name="action" value="checkout">
                
                <div class="input-group">
                    <label>Cardholder Name</label>
                    <input type="text" placeholder="John Doe" required>
                </div>
                <div class="input-group">
                    <label>Card Number</label>
                    <input type="text" placeholder="1234 5678 9101 1121" maxlength="16" required>
                </div>
                <div class="input-group" style="display: flex; gap: 10px;">
                    <div style="flex: 1;">
                        <label>Expiry Date</label>
                        <input type="text" placeholder="MM/YY" maxlength="5" required>
                    </div>
                    <div style="flex: 1;">
                        <label>CVV</label>
                        <input type="password" placeholder="***" maxlength="3" required>
                    </div>
                </div>
                
                <button type="submit" class="payment-btn">Pay Now & Complete Order</button>
            </form>
            <p style="text-align: center; font-size: 12px; color: #777; margin-top: 15px;">🔒 Your payment is secured and encrypted.</p>
        </div>
    </div>
</body>
</html>