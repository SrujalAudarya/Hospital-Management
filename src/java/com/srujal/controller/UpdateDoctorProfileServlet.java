
package com.srujal.controller;

import com.srujal.dao.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UpdateDoctorProfileServlet", urlPatterns = {"/UpdateDoctorProfileServlet"})
public class UpdateDoctorProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateDoctorProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDoctorProfileServlet at " + request.getContextPath() + "</h1>");
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
            HttpSession session = request.getSession(false); 
            
            if (session == null || session.getAttribute("doctor_id") == null) {
                response.sendRedirect("doctor/doctor_login.jsp");
                return;
            }
            
            int doctorId = (int) session.getAttribute("doctor_id");
            String doctorName = request.getParameter("doctor_name");
            String email = request.getParameter("email");
            String contact = request.getParameter("contact");
            
            Boolean result = DoctorDAO.UpdateProfile(doctorName, email, contact, doctorId);
        
            if (result) {
                session.setAttribute("doctor_name", doctorName);
                session.setAttribute("email", email);
                session.setAttribute("profileSuccess", "Profile updated successfully!");
            } else {
                session.setAttribute("profileError", "Profile update failed!");
            }
            response.sendRedirect("doctor/view_profile.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
