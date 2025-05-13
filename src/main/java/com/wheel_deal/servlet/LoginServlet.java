package com.wheel_deal.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.wheel_deal.util.UserConnect;



@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isAuthenticated = UserConnect.validateUser(username, password);

        if ("Savina".equals(username) && "admin123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("inventory"); // Success: Redirect to inventory
        }
        else if ("Chetiya".equals(username) && "chetiyapass".equals(password)){
        	HttpSession session = request.getSession();
        	session.setAttribute("username", username);
        	response.sendRedirect("faqs");
        }
        else if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("HomePage.jsp"); // Redirect to home page
        }
        else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response); // Forward back to login page
        }
    }
}


