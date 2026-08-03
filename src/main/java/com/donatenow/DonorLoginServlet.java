package com.donatenow;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/donorLoginAction")
public class DonorLoginServlet extends HttpServlet {

    // Hardcoded credentials - change these as needed
    private static final String DONOR_USERNAME = "donor";
    private static final String DONOR_PASSWORD = "donor123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (DONOR_USERNAME.equals(username) && DONOR_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("donorUser", username);
            response.sendRedirect(request.getContextPath() + "/donorDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("donorLogin.jsp").forward(request, response);
        }
    }
}
