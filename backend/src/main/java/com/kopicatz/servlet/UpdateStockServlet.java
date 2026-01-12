package com.kopicatz.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.json.JSONArray;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

@WebServlet("/admin/updateStock")
public class UpdateStockServlet extends HttpServlet {
    
    // Use same path as ProductAddQuantityServlet
    private static final String DATA_FILE_PATH = "C:\\Users\\HP\\Desktop\\kopicatz\\frontend\\src\\data\\productData.json";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Not authenticated\"}");
            return;
        }
        
        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productId == null || quantityStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Missing parameters\"}");
            return;
        }
        
        try {
            int newQuantity = Integer.parseInt(quantityStr);
            
            String jsonContent = new String(Files.readAllBytes(Paths.get(DATA_FILE_PATH)));
            JSONObject data = new JSONObject(jsonContent);
            
            JSONArray products = data.getJSONArray("products");
            boolean found = false;
            
            for (int i = 0; i < products.length(); i++) {
                JSONObject product = products.getJSONObject(i);
                if (product.getString("id").equals(productId)) {
                    product.put("stock", newQuantity);
                    found = true;
                    break;
                }
            }
            
            if (!found) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Product not found\"}");
                return;
            }
            
            Files.write(Paths.get(DATA_FILE_PATH), 
                       data.toString(4).getBytes(), 
                       StandardOpenOption.TRUNCATE_EXISTING);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Stock updated successfully");
            jsonResponse.put("productId", productId);
            jsonResponse.put("newStock", newQuantity);
            response.getWriter().write(jsonResponse.toString());
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid quantity\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to update stock\"}");
        }
    }
}
