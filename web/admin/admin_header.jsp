<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("admin_id") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel | Hospital Management System</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

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

        .navbar-brand {
            font-weight: 700;
            color: #4dd0e1 !important;
        }

        .content-box {
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            margin-top: 30px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .back-btn {
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg mb-4">
    <a class="navbar-brand" href="admin_dashboard.jsp">
        Hospital Admin Panel
    </a>

    <div class="ml-auto text-white">
        Welcome, <strong><%= session.getAttribute("username") %></strong>
        <a href="logout.jsp" class="btn btn-outline-light btn-sm ml-3">Logout</a>
    </div>
</nav>

<div class="container">
