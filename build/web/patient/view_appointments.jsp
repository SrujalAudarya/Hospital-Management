<%@page import="com.srujal.util.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("patient_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Appointments</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }

        .table-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .table thead th {
            background: rgba(0,0,0,0.35);
            color: #4dd0e1;
            border: none;
        }

        .table tbody tr {
            color: #fff;
        }

        .table tbody tr:hover {
            background: rgba(255,255,255,0.1);
        }

        .badge-status {
            padding: 7px 12px;
            border-radius: 15px;
            font-size: 13px;
        }

        .badge-pending {
            background: #ffc107;
            color: #000;
        }

        .badge-approved {
            background: #28a745;
        }

        .badge-cancelled {
            background: #dc3545;
        }
        

    </style>
</head>

<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg mb-4"
         style="background: rgba(0,0,0,0.35); backdrop-filter: blur(12px);">

        <a class="navbar-brand text-info font-weight-bold" href="patient_dashboard.jsp">
            Patient Panel
        </a>

        <div class="ml-auto d-flex align-items-center">
            <span class="text-white mr-3">
                <i class="fas fa-user-circle"></i>
                <b><%= session.getAttribute("PatientName") %></b>
            </span>

            <a href="Patient_dashboard.jsp" class="btn btn-outline-info btn-sm mr-2">
                Dashboard
            </a>

        </div>
    </nav>

<div class="container mt-5">

    <h3 class="mb-4 text-center">📅 Appointment List</h3>
    
    <%
        String success = (String) session.getAttribute("success");
        if (success != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show text-center"
             role="alert" style="border-radius: 30px;">
            <i class="fas fa-check-circle"></i>
            <strong> Success!</strong> <%= success %>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <%
            session.removeAttribute("success");
        }
    %>

    <div class="table-card">
        <table class="table table-borderless table-hover text-center">
            <thead>
                <tr>
                    <th>Sr. </th>
                    <th>Appointment Date</th>
                    <th>Time</th>
                    <th>Doctor Name</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>

            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int patient_id = (int) session.getAttribute("PatientID");

                try {
                    con = DbConnection.getConnection();

                    String sql = "SELECT a.appointment_date, a.appointment_time, " +
                                 "d.doctor_name, a.status " +
                                 "FROM appointment a " +
                                 "JOIN doctor d ON a.doctor_id = d.doctor_id "
                                 + "WHERE a.patient_id = ?";
                                 
                    ps = con.prepareStatement(sql);
                    ps.setInt(1, patient_id);
                    
                    rs = ps.executeQuery();

                    int i = 1;
                    while (rs.next()) {
            %>

                <tr>
                    <td><%= i++ %></td>
                    <td><%= rs.getDate("appointment_date") %></td>
                    <td><%= rs.getString("appointment_time") %></td>
                    <td><%= rs.getString("doctor_name") %></td>
                    <td>
                        <%
                            String status = rs.getString("status");
                            if ("Approved".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge badge-status badge-approved">Approved</span>
                        <%
                            } else if ("Cancelled".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge badge-status badge-cancelled">Cancelled</span>
                        <%
                            } else {
                        %>
                            <span class="badge badge-status badge-pending">Pending</span>
                        <%
                            }
                        %>
                    </td>
                </tr>

            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
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
