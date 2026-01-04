
package com.srujal.controller;

import com.srujal.dao.PatientDAO;
import com.srujal.model.Patient;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PatientRegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PatientRegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PatientRegisterServlet at " + request.getContextPath() + "</h1>");
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
        
            String patient_name = request.getParameter("patient_name");            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String contact = request.getParameter("contact");
            String gender = request.getParameter("gender");            
            String address = request.getParameter("address");
            
            Patient p = new Patient();
            p.setPatient_name(patient_name);
            p.setEmail(email);
            p.setPassword(password);
            p.setContact(contact);
            p.setGender(gender);
            p.setAddress(address);
            
            PatientDAO.RegisterPatient(p);
            
            response.sendRedirect(request.getContextPath() + "/index.html");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
