<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("patient_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Prescriptions</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body{
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            font-family:'Segoe UI',sans-serif;
            color:#fff;
        }
        .card-box{
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(14px);
            border-radius:20px;
            padding:25px;
            box-shadow:0 25px 45px rgba(0,0,0,0.35);
        }
        .table th{
            color:#4dd0e1;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg mb-4"
     style="background: rgba(0,0,0,0.35); backdrop-filter: blur(12px);">
    <a class="navbar-brand text-info font-weight-bold" href="Patient_dashboard.jsp">
        Patient Panel
    </a>

    <div class="ml-auto text-white">
        <i class="fas fa-user-circle"></i>
        <b><%= session.getAttribute("PatientName") %></b>
        <a href="Patient_dashboard.jsp" class="btn btn-outline-info btn-sm ml-3">
            Dashboard
        </a>
    </div>
</nav>

<div class="container">
    <h3 class="text-center mb-4">📝 My Prescriptions</h3>

    <div class="card-box">

        <table class="table table-borderless table-hover text-center">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Doctor</th>
                    <th>Medicines</th>
                    <th>Notes</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>

            <%
                int patientId = (int) session.getAttribute("PatientID");
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DbConnection.getConnection();

                    String sql =
                        "SELECT p.prescription_id, p.medicines, p.notes, p.created_at, d.doctor_name " +
                        "FROM prescription p " +
                        "JOIN appointment a ON p.appointment_id = a.appointment_id " +
                        "JOIN doctor d ON a.doctor_id = d.doctor_id " +
                        "WHERE a.patient_id = ? " +
                        "ORDER BY p.created_at DESC";

                    ps = con.prepareStatement(sql);
                    ps.setInt(1, patientId);
                    rs = ps.executeQuery();

                    int i = 1;
                    boolean found = false;

                    while (rs.next()) {
                        found = true;
            %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= rs.getString("doctor_name") %></td>
                    <td><%= rs.getString("medicines") %></td>
                    <td><%= rs.getString("notes") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                </tr>
            <%
                    }

                    if (!found) {
            %>
                <tr>
                    <td colspan="5" class="text-warning">
                        No prescriptions available yet.
                    </td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
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
