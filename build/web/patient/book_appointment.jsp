<%@page import="com.srujal.util.DbConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("patient_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>

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

        .glass-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .form-control {
            border-radius: 30px;
            height: 45px;
        }

        .btn-book {
            border-radius: 30px;
            height: 45px;
            font-weight: 600;
            background: linear-gradient(135deg, #1cb5e0, #000851);
            border: none;
        }

        .btn-book:hover {
            opacity: 0.9;
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

        <a href="logout.jsp" class="btn btn-outline-light btn-sm">
            Logout
        </a>
    </div>
</nav>

<div class="container">

    <h3 class="text-center mb-4">📅 Book Appointment</h3>
    
    <%
        String error = (String) session.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger alert-dismissible fade show text-center"
             role="alert" style="border-radius: 30px;">
            <i class="fas fa-exclamation-triangle"></i>
            <strong> Error!</strong> <%= error %>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <%
            session.removeAttribute("error");
        }
    %>

    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="glass-card">

                <form action="../BookAppointmentServlet" method="post">

                    <!-- Doctor -->
                    <div class="form-group">
                        <label>Select Doctor</label>
                        <select name="doctor_id" class="form-control" required>
                            <option value="">-- Select Doctor --</option>

                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;

                                try {
                                    con = DbConnection.getConnection();
                                    String sql =
                                      "SELECT d.doctor_id, d.doctor_name, dep.dept_name " +
                                      "FROM doctor d JOIN department dep ON d.dept_id = dep.dept_id";
                                    ps = con.prepareStatement(sql);
                                    rs = ps.executeQuery();

                                    while (rs.next()) {
                            %>
                                <option value="<%= rs.getInt("doctor_id") %>">
                                    <%= rs.getString("doctor_name") %>
                                    ( <%= rs.getString("dept_name") %> )
                                </option>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<option>Error loading doctors</option>");
                                } finally {
                                    if (rs != null) rs.close();
                                    if (ps != null) ps.close();
                                    if (con != null) con.close();
                                }
                            %>

                        </select>
                    </div>

                    <!-- Date -->
                    <div class="form-group">
                        <label>Appointment Date</label>
                        <input type="date" name="appointment_date" class="form-control" required>
                    </div>

                    <!-- Time -->
                    <div class="form-group">
                        <label>Appointment Time</label>
                        <input type="time" name="appointment_time" class="form-control" required>
                    </div>

                    <!-- Submit -->
                    <button type="submit" class="btn btn-book btn-block mt-4">
                        Book Appointment
                    </button>

                </form>

            </div>

        </div>
    </div>

</div>

</body>
</html>
