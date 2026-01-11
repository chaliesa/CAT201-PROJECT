package com.purrfectstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import com.purrfectstore.model.CartItem;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/products.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            resp.sendRedirect(req.getContextPath() + "/products.jsp");
            return;
        }

        String action = req.getParameter("action");
        String name = req.getParameter("name");

        if ("update".equals(action)) {
            String qtyStr = req.getParameter("qty");
            int qty = 0;
            try { qty = Integer.parseInt(qtyStr); } catch (NumberFormatException ignored) {}
            if (qty <= 0) {
                cart.remove(name);
            } else {
                CartItem it = cart.get(name);
                if (it != null) it.setQty(qty);
            }
        } else if ("remove".equals(action)) {
            cart.remove(name);
        } else if ("checkout".equals(action)) {
            // simple checkout: clear cart and redirect to thank-you (or products)
            session.removeAttribute("cart");
            resp.sendRedirect(req.getContextPath() + "/products.jsp?checkout=success");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }
}
