package com.kopicatz;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductAddQuantityServlet")
public class ProductAddQuantityServlet extends HttpServlet {
    
    // The path you provided
    private static final String FILE_PATH = "C:\\Users\\HP\\Desktop\\kopicatz\\frontend\\src\\data\\productData.json";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        out.print("{\"status\":\"info\", \"message\":\"This endpoint requires POST method with productId and quantity parameters.\"}");
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // CORS Headers
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // Get data from React request
        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        try {
            // DEBUG LOG 1: What did React send?
            System.out.println("--- Incoming Request ---");
            System.out.println("React Sent ID: [" + productId + "]");
            System.out.println("React Sent Qty: [" + quantityStr + "]");

            int newQuantity = Integer.parseInt(quantityStr);
            ObjectMapper mapper = new ObjectMapper();
            File jsonFile = new File(FILE_PATH);

            // DEBUG LOG 2: Is the file found?
            System.out.println("Target File: " + FILE_PATH);
            System.out.println("File Exists: " + jsonFile.exists());

            JsonNode root = mapper.readTree(jsonFile);
            JsonNode products = root.get("products");

            boolean found = false;
            if (products.isArray()) {
                for (JsonNode product : products) {
                    String currentJsonId = product.get("id").asText();
                    
                    // DEBUG LOG 3: Show the comparison
                    System.out.println("Comparing JSON ID: [" + currentJsonId + "] with React ID: [" + productId + "]");

                    if (currentJsonId.equals(productId)) {
                        ((ObjectNode) product).put("stock", newQuantity);
                        found = true;
                        System.out.println("SUCCESS: Match found and updated!");
                        break;
                    }
                }
            }

            if (found) {
                mapper.writerWithDefaultPrettyPrinter().writeValue(jsonFile, root);
                out.print("{\"status\":\"success\", \"message\":\"JSON file updated successfully!\"}");
            } else {
                System.out.println("ERROR: No match found for ID: " + productId);
                out.print("{\"status\":\"error\", \"message\":\"Product ID not found in JSON.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}