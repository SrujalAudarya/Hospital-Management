<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    int patientId = (Integer) session.getAttribute("PatientID");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Prescriptions</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            font-family: "Segoe UI", sans-serif;
            color:#fff;
        }

        .card-glass {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 18px;
            box-shadow: 0 25px 40px rgba(0,0,0,.4);
            padding: 25px;
        }

        table {
            color: #fff;
        }

        th {
            color: #4dd0e1;
        }

        .btn-view {
            background: #17a2b8;
            border: none;
        }

        .btn-view:hover {
            background: #138496;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg mb-4"
     style="background: rgba(0,0,0,0.35); backdrop-filter: blur(12px);">

    <a class="navbar-brand text-info font-weight-bold"
       href="patient_dashboard.jsp">
        Patient Panel
    </a>

    <div class="ml-auto">
        <a href="patient_dashboard.jsp"
           class="btn btn-outline-info btn-sm">
            Dashboard
        </a>
    </div>
</nav>

<div class="container">
    <h3 class="text-center mb-4">📄 My Prescriptions</h3>

    <div class="card-glass">

        <table class="table table-borderless table-hover">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Doctor</th>
                    <th>Appointment Date</th>
                    <th>Prescription Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int count = 1;

    try {
        con = DbConnection.getConnection();
        String sql =
            "SELECT pr.prescription_id, pr.created_at, " +
            "a.appointment_id, a.appointment_date, " +
            "d.doctor_name " +
            "FROM prescription pr " +
            "JOIN appointment a ON pr.appointment_id = a.appointment_id " +
            "JOIN doctor d ON a.doctor_id = d.doctor_id " +
            "WHERE a.patient_id = ? " +
            "ORDER BY pr.created_at DESC";

        ps = con.prepareStatement(sql);
        ps.setInt(1, patientId);
        rs = ps.executeQuery();

        if (!rs.isBeforeFirst()) {
%>
                <tr>
                    <td colspan="5" class="text-center text-warning">
                        No prescriptions found
                    </td>
                </tr>
<%
        } else {
            while (rs.next()) {
%>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= rs.getString("doctor_name") %></td>
                    <td><%= rs.getDate("appointment_date") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                    <td>
                        <a href="view_prescription.jsp?appointment_id=<%= rs.getInt("appointment_id") %>"
                           class="btn btn-view btn-sm text-white">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </td>
                </tr>
<%
            }
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='5'>" + e.getMessage() + "</td></tr>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

            </tbody>
        </table>

    </div>
</div>

</body>
</html>
