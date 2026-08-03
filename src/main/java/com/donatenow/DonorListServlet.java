package com.donatenow;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet({"/donorList", "/myDonations"})
public class DonorListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/plain;charset=UTF-8");

        if (DonorData.donations.isEmpty()) {
            response.getWriter().write("none");
            return;
        }

        // Join all entries with || separator so JS can split them
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < DonorData.donations.size(); i++) {
            if (i > 0) sb.append("||");
            sb.append(DonorData.donations.get(i));
        }
        response.getWriter().write(sb.toString());
    }
}
