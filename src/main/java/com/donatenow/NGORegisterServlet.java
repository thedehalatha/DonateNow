package com.donatenow;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ngoRegister")
public class NGORegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String sql = "INSERT INTO ngos (name, email, phone, address) VALUES (?, ?, ?, ?)";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);

            ps.executeUpdate();

            // Get the newly created NGO ID
            PreparedStatement ps2 = con.prepareStatement(
                    "SELECT id FROM ngos WHERE email = ?");

            ps2.setString(1, email);

            var rs = ps2.executeQuery();

            int ngoId = 0;

            if (rs.next()) {
                ngoId = rs.getInt("id");
            }

            // Create NGO login account
            PreparedStatement ps3 = con.prepareStatement(
                    "INSERT INTO users (username, password, role, ngo_id) VALUES (?, ?, ?, ?)");

            ps3.setString(1, username);
            ps3.setString(2, password);
            ps3.setString(3, "NGO");
            ps3.setInt(4, ngoId);

            ps3.executeUpdate();

            rs.close();
            ps.close();
            ps2.close();
            ps3.close();
            con.close();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<h2>NGO Registration Successful!</h2>");
            out.println("<p>You can now login using your username and password.</p>");
            out.println("<a href='ngoLogin.jsp'>Go to NGO Login</a>");

        } catch (Exception e) {
            e.printStackTrace();

            response.setContentType("text/html");
            response.getWriter().println(
                    "<h2>Registration Failed</h2><p>" + e.getMessage() + "</p>");
        }
    }
}