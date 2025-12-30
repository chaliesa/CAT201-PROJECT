<!-- filepath: c:\Users\HP\Downloads\Telegram Desktop\CAT201 PROJECT-CHALIE\CAT201-PROJECT\cart.jsp -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Purrfect Store</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Your Cart</h1>

    <%
        // Retrieve the cart from the session or create a new one
        List<String> cart = (List<String>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Check if an item was added
        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        if (itemId != null && itemName != null) {
            cart.add(itemName); // Add the item to the cart
            session.setAttribute("cart", cart); // Save the cart in the session
        }
    %>

    <ul>
        <%
            if (cart.isEmpty()) {
        %>
            <li>Your cart is empty.</li>
        <%
            } else {
                for (String item : cart) {
        %>
            <li><%= item %></li>
        <%
                }
            }
        %>
    </ul>

    <form action="cart.jsp" method="post">
        <input type="hidden" name="itemId" value="101">
        <input type="hidden" name="itemName" value="Cat Food - Premium">
        <button type="submit">Add to Cart</button>
    </form>

    <a href="products.html">Continue Shopping</a>
</body>
</html>