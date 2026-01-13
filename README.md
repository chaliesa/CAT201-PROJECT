# Admin Panel - JSP & Servlet Demo

This project contains a simple admin panel backend using JSP and Java Servlets. It provides server-side functionality for admin login, inventory management, and order fulfillment without requiring any JavaScript.

## How to Build & Run (Tomcat + Maven)

Install JDK 8+ and Apache Maven.

Build the WAR file:

mvn package


Deploy the generated WAR (target/admin-panel-webapp.war) to Tomcat webapps/ and start Tomcat.

Open the admin login page in your browser:

http://localhost:8080/backend/admin/login

## Features

Admin Login & Logout
- Session-based authentication for admins, supporting normal form and AJAX login.

Inventory Management
- View inventory in JSON format and update stock manually via POST requests.

Order Management
- View orders in JSON format and fulfill orders, automatically deducting stock.
