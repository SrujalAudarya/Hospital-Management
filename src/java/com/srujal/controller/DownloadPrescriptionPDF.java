/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.srujal.controller;

import com.srujal.util.DbConnection;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

/**
 *
 * @author sruja
 */
public class DownloadPrescriptionPDF extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DownloadPrescriptionPDF</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DownloadPrescriptionPDF at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int appointmentId = Integer.parseInt(req.getParameter("appointment_id"));
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=Prescription.pdf");

        Document document = new Document();
        try {
            PdfWriter.getInstance(document, resp.getOutputStream());
            document.open();

            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT pr.medicines, pr.notes, p.patient_name, d.doctor_name " +
                "FROM prescription pr " +
                "JOIN appointment a ON pr.appointment_id=a.appointment_id " +
                "JOIN patient p ON a.patient_id=p.patient_id " +
                "JOIN doctor d ON a.doctor_id=d.doctor_id " +
                "WHERE pr.appointment_id=?"
            );
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                document.add(new Paragraph("HOSPITAL PRESCRIPTION\n\n"));
                document.add(new Paragraph("Patient: " + rs.getString("patient_name")));
                document.add(new Paragraph("Doctor: " + rs.getString("doctor_name")));
                document.add(new Paragraph("\nMedicines:\n" + rs.getString("medicines")));
                document.add(new Paragraph("\nNotes:\n" + rs.getString("notes")));
            }
            document.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
