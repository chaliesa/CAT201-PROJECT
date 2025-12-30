<%@ page import="java.util.*, com.purrfectstore.model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Purrfect Store</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <div class="logo">
                <img src="icon/cat logo.png" alt="Purrfect Store" class="logo-icon">
                <h1>Purrfect Store</h1>
            </div>
            <ul class="nav-links">
                <li><a href="index.html">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="cart.jsp" class="active">Cart</a></li>
            </ul>
        </div>
    </nav>

    <section class="page-header">
        <div class="container">
            <h1>🛒 Shopping Cart</h1>
            <p>Review and manage your items</p>
        </div>
    </section>

    <section class="products">
        <div class="container">
            <div class="cart-container">
                <div class="cart-items">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            @SuppressWarnings("unchecked")
                            Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
                            double subtotal = 0.0;
                            if (cart != null && !cart.isEmpty()) {
                                for (CartItem it : cart.values()) {
                                    subtotal += it.getSubtotal();
                        %>
                            <tr>
                                <td>
                                    <div class="cart-item-details">
                                        <div class="cart-item-info">
                                            <h3><%= it.getName() %></h3>
                                        </div>
                                    </div>
                                </td>
                                <td class="price-column">RM <%= String.format("%.2f", it.getPrice()) %></td>
                                <td>
                                    <form method="post" action="update-cart" style="display:inline-block;">
                                        <input type="hidden" name="name" value="<%= it.getName() %>">
                                        <input type="number" name="qty" value="<%= it.getQty() %>" min="0" style="width:60px">
                                        <button type="submit" name="action" value="update">Update</button>
                                    </form>
                                </td>
                                <td class="price-column">RM <%= String.format("%.2f", it.getSubtotal()) %></td>
                                <td>
                                    <form method="post" action="update-cart" style="display:inline-block;">
                                        <input type="hidden" name="name" value="<%= it.getName() %>">
                                        <button type="submit" name="action" value="remove">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        <%  }
                            } else {
                        %>
                            <tr><td colspan="5" class="empty-cart">Your cart is empty. <a href="products.jsp">Shop now</a></td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="cart-summary">
                    <h2>Order Summary</h2>
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>RM <%= String.format("%.2f", subtotal) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span>RM <%= subtotal > 0 ? "15.00" : "0.00" %></span>
                    </div>
                    <div class="summary-row">
                        <span>Tax (8%):</span>
                        <span>RM <%= String.format("%.2f", subtotal * 0.08) %></span>
                    </div>
                    <div class="summary-row total">
                        <span>Total:</span>
                        <span class="total-price">RM <%= String.format("%.2f", subtotal + (subtotal > 0 ? 15.0 : 0.0) + subtotal * 0.08) %></span>
                    </div>

                    <form method="post" action="update-cart">
                        <button type="submit" name="action" value="checkout" class="checkout-btn">Proceed to Checkout</button>
                    </form>

                    <a href="products.jsp" class="continue-shopping">Continue Shopping</a>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Purrfect Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
