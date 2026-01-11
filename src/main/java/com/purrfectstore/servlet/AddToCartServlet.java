package com.purrfectstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import com.purrfectstore.model.CartItem;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        
        @SuppressWarnings("unchecked")
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }

        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String qtyStr = req.getParameter("qty");
        if (name == null || priceStr == null) {
            resp.sendRedirect(req.getContextPath() + "/products.jsp");
            return;
        }

        double price = 0;
        int qty = 1;
        try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) {}
        try { qty = Integer.parseInt(qtyStr == null ? "1" : qtyStr); } catch (NumberFormatException ignored) { qty = 1; }

        CartItem existing = cart.get(name);
        if (existing == null) {
            cart.put(name, new CartItem(name, price, qty));
        } else {
            existing.setQty(existing.getQty() + qty);
        }

        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }
}
