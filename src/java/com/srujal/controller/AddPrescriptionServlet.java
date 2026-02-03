
package com.srujal.controller;

import com.srujal.dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddPrescriptionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPrescriptionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPrescriptionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("doctor_id") == null) {
            response.sendRedirect("doctor_login.jsp");
            return;
        }

        int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
        String medicines = request.getParameter("medicines");
        String notes = request.getParameter("notes");

        boolean added = PrescriptionDAO.addPrescription(appointmentId, medicines, notes);

        if (added) {
            session.setAttribute("success", "Prescription added successfully!");
        } else {
            session.setAttribute("error", "Failed to add prescription!");
        }

        response.sendRedirect("doctor/view_appointments.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
