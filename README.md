Purrfect Store - JSP Cart Demo

This workspace contains a static front-end and a small JSP/Servlet implementation to provide server-side cart functionality without JavaScript.

How to build & run (Tomcat + Maven):

1. Install JDK 8+ and Apache Maven.
2. Build the WAR:

```bash
mvn package
```

3. Deploy the generated `target/purrfectstore-webapp.war` to Tomcat `webapps/` and start Tomcat.

4. Open `http://localhost:8080/purrfectstore-webapp/products.jsp`.

Notes:
- The servlets use `HttpSession` to store a `Map<String,CartItem>` as the cart.
- There is no JavaScript required for add/update/remove/checkout flows.
