package com.donatenow;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// Ensure this matches the <a> href in VoiceServlet exactly
@WebServlet("/update") 
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String action = request.getParameter("action");

        try {
            if (idStr != null && action != null) {
                int id = Integer.parseInt(idStr);
                
                // Safety check to ensure index exists in the static list
                if (id >= 0 && id < VoiceServlet.statusList.size()) {
                    if ("accept".equals(action)) {
                        VoiceServlet.statusList.set(id, "accepted");
                    } else if ("reject".equals(action)) {
                        VoiceServlet.statusList.set(id, "rejected");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to index.jsp
        // Using request.getContextPath() ensures it finds the right folder
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}