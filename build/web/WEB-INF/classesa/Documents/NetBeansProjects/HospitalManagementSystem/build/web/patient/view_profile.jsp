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
    <title>View Profile | Patient</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body{
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            font-family:'Segoe UI',sans-serif;
        }
        .profile-card{
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(14px);
            border-radius:20px;
            padding:30px;
            width:420px;
            color:#fff;
            box-shadow:0 25px 45px rgba(0,0,0,0.35);
        }
        .profile-card h4{
            text-align:center;
            margin-bottom:20px;
            color:#4dd0e1;
        }
        .profile-row{
            margin-bottom:10px;
        }
        .profile-label{
            font-weight:600;
            color:#b2ebf2;
        }
    </style>
</head>

<body>

<%
    int pid = (int) session.getAttribute("PatientID");
    Connection con = DbConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM patient WHERE patient_id=?"
    );
    ps.setInt(1, pid);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>

<div class="profile-card">
    <h4>Patient Profile</h4>

    <div class="profile-row">
        <span class="profile-label">Name:</span>
        <div><%= rs.getString("patient_name") %></div>
    </div>

    <div class="profile-row">
        <span class="profile-label">Email:</span>
        <div><%= rs.getString("email") %></div>
    </div>

    <div class="profile-row">
        <span class="profile-label">Contact:</span>
        <div><%= rs.getString("contact") %></div>
    </div>

    <div class="profile-row">
        <span class="profile-label">Gender:</span>
        <div><%= rs.getString("gender") %></div>
    </div>

    <div class="profile-row">
        <span class="profile-label">Address:</span>
        <div><%= rs.getString("address") %></div>
    </div>

    <div class="text-center mt-4">
        <a href="edit_profile.jsp" class="btn btn-info">Edit Profile</a>
        <a href="Patient_dashboard.jsp" class="btn btn-outline-light ml-2">Back</a>
    </div>
</div>

</body>
</html>
