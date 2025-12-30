<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kopicatz Admin - Inventory</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f4; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; background: white; margin-top: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
<h2>Kopicatz Administration Dashboard</h2>
<p>Manage your cat product inventory below.</p>

<table>
    <tr>
        <th>ID</th>
        <th>Product Name</th>
        <th>Category</th>
        <th>Price (RM)</th>
        <th>Stock Count</th>
    </tr>
    <%
        try {
            // 1. Load the Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Establish Connection
            // Database: kopicatz_db | User: root | Password: admin456
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/kopicatz_db", "root", "admin456");

            // 3. Execute Query
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM products");

            // 4. Display Results
            while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("category") %></td>
        <td><%= String.format("%.2f", rs.getDouble("price")) %></td>
        <td><%= rs.getInt("stock") %></td>
    </tr>
    <%
            }
            con.close();
        } catch(Exception e) {
            out.println("<tr><td colspan='5' class='error'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>
</table>
</body>
</html>
