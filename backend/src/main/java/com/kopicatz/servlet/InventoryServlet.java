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

@WebServlet("/admin/inventory")
public class InventoryServlet extends HttpServlet {
    
    // Option A: Use same path as ProductAddQuantityServlet
    private static final String DATA_FILE_PATH = "C:\\Users\\HP\\Desktop\\kopicatz\\frontend\\src\\data\\productData.json";
    
    // Option B: Use WEB-INF (comment out Option A and uncomment this if copying file to WEB-INF)
    // private static final String DATA_FILE = "productData.json";
    
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
            // Option A: Direct file path
            String jsonContent = new String(Files.readAllBytes(Paths.get(DATA_FILE_PATH)));
            
            // Option B: WEB-INF path (uncomment if using WEB-INF)
            // String dataPath = getServletContext().getRealPath("/WEB-INF/data/" + DATA_FILE);
            // String jsonContent = new String(Files.readAllBytes(Paths.get(dataPath)));
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonContent);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to load inventory data\"}");
        }
    }
}