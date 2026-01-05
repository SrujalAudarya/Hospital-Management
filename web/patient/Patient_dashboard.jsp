<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("PatientID") == null) {
        response.sendRedirect("patient_login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.35);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 600;
            color: #4dd0e1 !important;
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
        }

        .nav-link:hover {
            color: #4dd0e1 !important;
        }

        .welcome-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 30px;
            color: #fff;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .dashboard-card {
            background: rgba(255, 255, 255, 0.18);
            backdrop-filter: blur(12px);
            border-radius: 18px;
            padding: 25px;
            color: #fff;
            text-align: center;
            box-shadow: 0 20px 35px rgba(0,0,0,0.3);
            transition: transform 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
        }

        .dashboard-card i {
            font-size: 36px;
            margin-bottom: 10px;
            color: #4dd0e1;
        }

        .dashboard-card a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
        }

        .dashboard-card a:hover {
            color: #4dd0e1;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="#">Patient Panel</a>

    <div class="ml-auto">
        <span class="text-white mr-3">
            Welcome, <b><%= session.getAttribute("PatientName") %></b>
        </span>
        <a href="logout.jsp" class="btn btn-outline-light btn-sm">
            Logout
        </a>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="container mt-5">

    <div class="welcome-card mb-4">
        <h4>Hello, <%= session.getAttribute("PatientName") %> 👋</h4>
        <p class="mb-0">
            Manage your appointments, doctors, and medical activities from here.
        </p>
    </div>

    <div class="row">

        <!-- Book Appointment -->
        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-calendar-plus"></i>
                <h5>Book Appointment</h5>
                <a href="book_appointment.jsp">Click Here</a>
            </div>
        </div>

        <!-- View Appointments -->
        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-calendar-check"></i>
                <h5>My Appointments</h5>
                <a href="view_appointments.jsp">Click Here</a>
            </div>
        </div>

        <!-- View Doctors -->
        <div class="col-md-4 mb-4">
            <div class="dashboard-card">
                <i class="fas fa-user-md"></i>
                <h5>View Doctors</h5>
                <a href="view_doctors.jsp">Click Here</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
