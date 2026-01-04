
package com.srujal.controller;

import com.srujal.dao.PatientDAO;
import com.srujal.model.Patient;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PatientLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PatientLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PatientLoginServlet at " + request.getContextPath() + "</h1>");
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
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Patient p = PatientDAO.LoginPatient(email, password);
        
        if(p != null){
            HttpSession session = request.getSession();
            session.setAttribute("PatientID", p.getPatient_id());
            session.setAttribute("PatientName", p.getPatient_name());
            response.sendRedirect("patient/Patient_dashboard.jsp");
        }else{
            out.println("<script> alert('Invalid Email/Password') </script>");
        }
        
    }

    public PatientLoginServlet() {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
