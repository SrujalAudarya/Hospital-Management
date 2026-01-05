
package com.srujal.controller;

import com.srujal.dao.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BookAppointmentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookAppointmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookAppointmentServlet at " + request.getContextPath() + "</h1>");
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
        int patient_id = (int) session.getAttribute("PatientID");
        
        int doctor_id = Integer.parseInt(request.getParameter("doctor_id"));
        String appointment_date = request.getParameter("appointment_date");
        String appointment_time = request.getParameter("appointment_time");
        
        Boolean result = AppointmentDAO.BookAppointment(doctor_id, patient_id, appointment_date, appointment_time);
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
            
        if (result) {
            session.setAttribute("success", "Appointment booked successfully!");
            response.sendRedirect("patient/view_appointments.jsp");
        }else {
            session.setAttribute("error", "Failed to book appointment!");
            response.sendRedirect("patient/book_appointment.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
