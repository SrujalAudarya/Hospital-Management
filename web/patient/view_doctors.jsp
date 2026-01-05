<%@page import="com.srujal.util.DbConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Doctors</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }

        .doctor-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            transition: transform 0.3s;
        }

        .doctor-card:hover {
            transform: translateY(-8px);
        }

        .doctor-icon {
            font-size: 45px;
            color: #4dd0e1;
            margin-bottom: 10px;
        }

        .dept-badge {
            background: #4dd0e1;
            color: #000;
            padding: 6px 14px;
            border-radius: 15px;
            font-size: 13px;
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

<div class="container">

    <h3 class="text-center mb-4">👨‍⚕️ Our Doctors</h3>

    <div class="row">

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DbConnection.getConnection();

                String sql = "SELECT d.doctor_name, d.email, d.contact, dep.dept_name " +
                             "FROM doctor d " +
                             "JOIN department dep ON d.dept_id = dep.dept_id";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>

        <div class="col-md-4 mb-4">
            <div class="doctor-card text-center">
                <div class="doctor-icon">
                    <i class="fas fa-user-md"></i>
                </div>

                <h5><%= rs.getString("doctor_name") %></h5>

                <span class="dept-badge mb-2 d-inline-block">
                    <%= rs.getString("dept_name") %>
                </span>

                <p class="mt-3 mb-1">
                    <i class="fas fa-envelope"></i>
                    <%= rs.getString("email") %>
                </p>

                <p>
                    <i class="fas fa-phone"></i>
                    <%= rs.getString("contact") %>
                </p>
            </div>
        </div>

        <%
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>" + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>

    </div>
</div>

</body>
</html>
