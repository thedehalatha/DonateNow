package com.donatenow;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet({"/donorSubmit", "/donorLogout"})
public class DonorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("donorUser") == null) {
            response.sendRedirect(request.getContextPath() + "/donorLogin.jsp");
            return;
        }

        String name    = request.getParameter("donorName");
        String phone   = request.getParameter("donorPhone");
        String address = request.getParameter("donorAddress");
        String notes   = request.getParameter("donorNotes");
        String[] types = request.getParameterValues("donateType");
        String time    = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));

        // Build donation type string
        String donateTypes = "Nothing selected";
        if (types != null && types.length > 0) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < types.length; i++) {
                if (i > 0) sb.append(", ");
                sb.append(types[i]);
            }
            donateTypes = sb.toString();
        }

        // Build entry and store in shared list
        String entry = name + " | " + phone + " | " + address + " | Donating: " + donateTypes
                     + (notes != null && !notes.trim().isEmpty() ? " | Note: " + notes : "")
                     + " | at " + time;

        DonorData.donations.add(0, entry);

        // Set success message and redirect
        session.setAttribute("donorSuccess", "true");
        response.sendRedirect(request.getContextPath() + "/donorDashboard.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Handle logout
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
