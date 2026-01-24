<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("admin_id") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Hospital Management System</title>

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

        /* Navbar */
        .navbar {
            background: rgba(0,0,0,0.35);
            backdrop-filter: blur(12px);
        }

        .navbar-brand {
            font-weight: 700;
            color: #4dd0e1 !important;
        }

        /* Dashboard cards */
        .dashboard-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
        }

        .dashboard-card i {
            font-size: 42px;
            margin-bottom: 15px;
            color: #4dd0e1;
        }

        .dashboard-card h5 {
            font-weight: 600;
        }

        .dashboard-card p {
            font-size: 14px;
            opacity: 0.95;
        }

        .welcome-box {
            background: rgba(255,255,255,0.12);
            border-radius: 18px;
            padding: 25px;
            margin-bottom: 30px;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg mb-4">
    <a class="navbar-brand" href="#">
        🏥 Hospital Admin Panel
    </a>

    <div class="ml-auto text-white">
        Welcome, <strong><%= session.getAttribute("username") %></strong>
        <a href="logout.jsp" class="btn btn-outline-light btn-sm ml-3">Logout</a>
    </div>
</nav>

<div class="container">

    <!-- Welcome -->
    <div class="welcome-box text-center">
        <h4>Admin Dashboard</h4>
        <p>Manage hospital operations efficiently from one centralized panel.</p>
    </div>

    <!-- Dashboard Cards -->
    <div class="row">

        <!-- Departments -->
        <div class="col-md-4 mb-4">
            <a href="manage_departments.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-building"></i>
                    <h5>Manage Departments</h5>
                    <p>Add, update and organize hospital departments.</p>
                </div>
            </a>
        </div>

        <!-- Doctors -->
        <div class="col-md-4 mb-4">
            <a href="manage_doctors.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-user-md"></i>
                    <h5>Manage Doctors</h5>
                    <p>Register, update and monitor doctors.</p>
                </div>
            </a>
        </div>

        <!-- Patients -->
        <div class="col-md-4 mb-4">
            <a href="view_patients.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-users"></i>
                    <h5>View Patients</h5>
                    <p>See all registered patients in the system.</p>
                </div>
            </a>
        </div>

        <!-- Appointments -->
        <div class="col-md-4 mb-4">
            <a href="view_appointments.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-calendar-check"></i>
                    <h5>Monitor Appointments</h5>
                    <p>Track and manage all hospital appointments.</p>
                </div>
            </a>
        </div>

        <!-- Logs -->
        <div class="col-md-4 mb-4">
            <a href="activity_logs.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-clipboard-list"></i>
                    <h5>System Activity Logs</h5>
                    <p>Monitor system usage and actions.</p>
                </div>
            </a>
        </div>

        <!-- Security -->
        <div class="col-md-4 mb-4">
            <a href="admin_profile.jsp" class="text-white text-decoration-none">
                <div class="dashboard-card text-center">
                    <i class="fas fa-user-shield"></i>
                    <h5>Admin Profile</h5>
                    <p>View and manage admin profile & security.</p>
                </div>
            </a>
        </div>

    </div>

</div>

</body>
</html>
