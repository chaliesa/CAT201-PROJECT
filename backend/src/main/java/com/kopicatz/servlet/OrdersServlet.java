package com.kopicatz.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/admin/orders")
public class OrdersServlet extends HttpServlet {
    
    // Use same path as InventoryServlet
    private static final String DATA_FILE_PATH = "C:\\Users\\HP\\Desktop\\kopicatz\\frontend\\src\\data\\productData.json";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Not authenticated\"}");
            return;
        }
        
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(DATA_FILE_PATH)));
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonContent);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to load orders data\"}");
        }
    }
}