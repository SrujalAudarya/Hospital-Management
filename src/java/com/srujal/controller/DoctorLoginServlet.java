
package com.srujal.controller;

import com.srujal.dao.DoctorDAO;
import com.srujal.model.Doctor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorLoginServlet", urlPatterns = {"/DoctorLoginServlet"})
public class DoctorLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoctorLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorLoginServlet at " + request.getContextPath() + "</h1>");
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
        

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Doctor d =  DoctorDAO.LoginDoctor(email, password);

            if(d != null){
                HttpSession session = request.getSession();
                session.setAttribute("doctor_id", d.getDoctor_id());
                session.setAttribute("doctor_name", d.getDoctor_name());
                session.setAttribute("email", d.getEmail());
                session.setAttribute("contact", d.getContact());
                session.setAttribute("dept_id", d.getDept_id());
                response.sendRedirect("doctor/doctor_dashboard.jsp");
            }else{
               HttpSession session = request.getSession();
               session.setAttribute("loginError", "Invalid Email or Password!");
               response.sendRedirect("doctor/doctor_login.jsp");
            }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
