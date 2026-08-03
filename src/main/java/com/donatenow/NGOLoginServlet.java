package com.donatenow;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ngoLoginAction")
public class NGOLoginServlet extends HttpServlet {

    // Hardcoded credentials - change these as needed
    private static final String NGO_USERNAME = "ngo";
    private static final String NGO_PASSWORD = "ngo123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (NGO_USERNAME.equals(username) && NGO_PASSWORD.equals(password)) {
            // Login success - set session
            HttpSession session = request.getSession();
            session.setAttribute("ngoUser", username);
            response.sendRedirect(request.getContextPath() + "/ngoDashboard.jsp");
        } else {
            // Login failed - show error
            request.setAttribute("error", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("ngoLogin.jsp").forward(request, response);
        }
    }
}
