<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("doctor_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>

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

        .navbar {
            background: rgba(0,0,0,0.35);
            backdrop-filter: blur(12px);
        }

        .dashboard-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            transition: transform 0.3s;
            text-align: center;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
        }

        .dashboard-card i {
            font-size: 36px;
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
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand text-info font-weight-bold" href="#">
        Doctor Panel
    </a>

    <div class="ml-auto d-flex align-items-center">
        <span class="text-white mr-3">
            <i class="fas fa-user-md"></i>
            <b><%= session.getAttribute("doctor_name") %></b>
        </span>

        <a href="logout.jsp" class="btn btn-outline-light btn-sm">
            Logout
        </a>
    </div>
</nav>

<div class="container mt-5">

    <!-- Doctor Info -->
    <div class="dashboard-card mb-4">
        <h4>Welcome Dr. <%= session.getAttribute("doctor_name") %></h4>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String deptName = "";

            try {
                con = DbConnection.getConnection();
                String sql = "SELECT dept_name FROM department WHERE dept_id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, (int) session.getAttribute("dept_id"));
                rs = ps.executeQuery();

                if (rs.next()) {
                    deptName = rs.getString("dept_name");
                    session.setAttribute("dept_name", deptName);
                }
            } catch (Exception e) {
                deptName = "Unknown Department";
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>

        <p class="mt-2">
            Department:
            <span class="dept-badge"><%= deptName %></span>
        </p>
    </div>

    <!-- Dashboard Actions -->
    <div class="row">

        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-calendar-alt"></i>
                <h5>My Appointments</h5>
                <a href="view_appointments.jsp" class="text-white">View Appointments</a>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-check-circle"></i>
                <h5>Approve Appointments</h5>
                <a href="manage_appointments.jsp" class="text-white">Manage</a>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-user-cog"></i>
                <h5>Profile</h5>
                <a href="view_profile.jsp" class="text-white">View Profile</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>
