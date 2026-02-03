<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>

<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("doctor_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Prescription | Doctor</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body{
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            font-family:'Segoe UI',sans-serif;
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .card-box{
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(14px);
            border-radius:20px;
            padding:30px;
            width:500px;
            color:#fff;
            box-shadow:0 25px 45px rgba(0,0,0,0.35);
        }
    </style>
</head>

<body>
<div class="card-box">
    <h4 class="text-center mb-4">Add Prescription</h4>

    <form method="post" action="../AddPrescriptionServlet">
        <div class="form-group">
            <label>Appointment ID</label>
            <input type="number" name="appointment_id" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Medicines</label>
            <textarea name="medicines" class="form-control" rows="3" required></textarea>
        </div>

        <div class="form-group">
            <label>Notes</label>
            <textarea name="notes" class="form-control" rows="3"></textarea>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-success btn-block">Save Prescription</button>
            <a href="doctor_dashboard.jsp" class="btn btn-outline-light btn-block mt-2">Back</a>
        </div>
    </form>
</div>
</body>
</html>
