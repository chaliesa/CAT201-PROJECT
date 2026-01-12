package com.kopicatz.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "123";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        String contentType = request.getContentType();
        boolean isAjax = "application/json".equals(contentType) || 
                        "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("adminUsername", username);
            session.setMaxInactiveInterval(30 * 60);
            
            if (isAjax) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Login successful");
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            }
        } else {
            if (isAjax) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                PrintWriter out = response.getWriter();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid username or password");
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
            }
        }
    }
}