/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.srujal.controller;

import com.srujal.dao.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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

        if (session == null || session.getAttribute("admin_id") == null) {
            response.sendRedirect("admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int adminId = (int) session.getAttribute("admin_id");
        
        if ("addDoctor".equals(action)) {

            String name = request.getParameter("doctor_name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String contact = request.getParameter("contact");
            int deptId = Integer.parseInt(request.getParameter("dept_id"));

            boolean status = AdminDAO.addDoctor(name, email, password, contact, deptId);

            if (status) {
                session.setAttribute("success", "Doctor added successfully!");
            } else {
                session.setAttribute("error", "Failed to add doctor!");
            }

            response.sendRedirect("admin/manage_doctors.jsp");
        }

        /* ================= ADD DEPARTMENT ================= */
        if ("addDepartment".equals(action)) {

            String deptName = request.getParameter("dept_name");

            boolean result = AdminDAO.addDepartment(deptName);

            if (result) {
                session.setAttribute("success", "Department added successfully!");
            } else {
                session.setAttribute("error", "Failed to add department!");
            }
            response.sendRedirect("admin/manage_departments.jsp");
        }
        
        try {

            /* ================= DEPARTMENT ================= */
            if ("addDepartment".equals(action)) {
                String deptName = request.getParameter("dept_name");
                AdminDAO.addDepartment(deptName);
                AdminDAO.insertLog("ADMIN", adminId, "Added department: " + deptName);
                response.sendRedirect("admin/manage_departments.jsp");
            }

            if ("updateDepartment".equals(action)) {
                int deptId = Integer.parseInt(request.getParameter("dept_id"));
                String deptName = request.getParameter("dept_name");
                AdminDAO.updateDepartment(deptId, deptName);
                AdminDAO.insertLog("ADMIN", adminId, "Updated department ID: " + deptId);
                response.sendRedirect("admin/manage_departments.jsp");
            }
            
            if ("deleteDepartment".equals(action)) {
                int deptId = Integer.parseInt(request.getParameter("dept_id"));
                AdminDAO.deleteDepartment(deptId);
                AdminDAO.insertLog("ADMIN", adminId, "Deleted department ID: " + deptId);
                response.sendRedirect("admin/manage_departments.jsp");
            }

            /* ================= DOCTOR ================= */
            if ("deleteDoctor".equals(action)) {
                int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
                AdminDAO.deleteDoctor(doctorId);
                AdminDAO.insertLog("ADMIN", adminId, "Deleted doctor ID: " + doctorId);
                response.sendRedirect("admin/manage_doctors.jsp");
            }
            
            if ("updateDoctor".equals(action)) {
                int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
                String name = request.getParameter("doctor_name");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                int deptId = Integer.parseInt(request.getParameter("dept_id"));

                AdminDAO.updateDoctor(doctorId, name, email, contact, deptId);
                AdminDAO.insertLog("ADMIN", adminId, "Updated doctor ID: " + doctorId);
                response.sendRedirect("admin/manage_doctors.jsp");
            }
            
             /* ================= APPOINTMENT ================= */
            if ("updateAppointment".equals(action)) {
                int appId = Integer.parseInt(request.getParameter("appointment_id"));
                String status = request.getParameter("status");

                AdminDAO.updateAppointmentStatus(appId, status);
                AdminDAO.insertLog("ADMIN", adminId,
                        "Updated appointment ID " + appId + " to " + status);

                response.sendRedirect("admin/view_appointments.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/admin_dashboard.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
