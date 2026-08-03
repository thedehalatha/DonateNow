package com.donatenow;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/status")
public class StatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;  // ✅ removes warning

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        if (!VoiceServlet.statusList.isEmpty()) {
            String latest = VoiceServlet.statusList.get(0); // latest request
            response.getWriter().write(latest);
        } else {
            response.getWriter().write("none");
        }
    }
}