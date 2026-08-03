package com.donatenow;

import java.time.format.DateTimeFormatter;
import java.time.LocalTime;
import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/voice", "/requests"})
public class VoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public static ArrayList<String> requests = new ArrayList<>();
    public static ArrayList<String> statusList = new ArrayList<>();

    // 👉 Handles Python request
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String type = request.getParameter("type");
        String time = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));

        if (type != null) {

            if ("food".equals(type)) {
                requests.add(0, "🍛 Food request at " + time);
                statusList.add(0, "pending");
            } 
            else if ("clothes".equals(type)) {
                requests.add(0, "👕 Clothes request at " + time);
                statusList.add(0, "pending");
            }
        }

        response.getWriter().write("Success");
    }

    // 👉 Handles website display + Python status check
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String typeParam = request.getParameter("type");

        // ✅ For Python status check
        if ("latest".equals(typeParam)) {
            response.setContentType("text/plain");

            if (!statusList.isEmpty()) {
                response.getWriter().write(statusList.get(0));
            } else {
                response.getWriter().write("none");
            }
            return;
        }

        // ✅ For website display
        response.setContentType("text/html;charset=UTF-8");

        StringBuilder output = new StringBuilder();

        if (requests.isEmpty()) {
            output.append("<div class='card'>No requests yet...</div>");
        } else {

            for (int i = 0; i < requests.size(); i++) {

                output.append("<div class='card'>");

                output.append("<strong>")
                      .append(requests.get(i))
                      .append("</strong>");

                output.append(" — <span style='color:blue'>")
                      .append(statusList.get(i))
                      .append("</span>");

                if ("pending".equals(statusList.get(i))) {
                    output.append("<br><br>");

                    String contextPath = request.getContextPath();

                    output.append("<a href='")
                          .append(contextPath)
                          .append("/update?id=")
                          .append(i)
                          .append("&action=accept'>✅ Accept</a> ");

                    output.append(" | ");

                    output.append("<a href='")
                          .append(contextPath)
                          .append("/update?id=")
                          .append(i)
                          .append("&action=reject'>❌ Reject</a>");
                }

                output.append("</div>");
            }
        }

        response.getWriter().write(output.toString());
    }
}