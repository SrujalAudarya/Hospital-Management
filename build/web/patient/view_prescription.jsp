<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("PatientID")==null){
        response.sendRedirect("../index.jsp");
        return;
    }
    int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
%>

<!DOCTYPE html>
<html>
<head>
<title>My Prescription</title>

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body{
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:#fff;
}
.card-glass{
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(14px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 25px 40px rgba(0,0,0,.4);
}
.label{
    color:#4dd0e1;
    font-weight:600;
}
.data{
    background: rgba(0,0,0,.35);
    padding:15px;
    border-radius:12px;
    white-space:pre-line;
}

@media print {
    body {
        background:#fff;
        color:#000;
    }
    .btn, nav {
        display:none;
    }
}
</style>
</head>

<body>
    
    <!-- Navbar -->
<nav class="navbar navbar-expand-lg mb-4"
     style="background: rgba(0,0,0,0.35); backdrop-filter: blur(12px);">

    <a class="navbar-brand text-info font-weight-bold" href="doctor_dashboard.jsp">
        Doctor Panel
    </a>

    <div class="ml-auto text-white">
        <i class="fas fa-user-md"></i>
        <b><%= session.getAttribute("doctor_name") %></b>

        <a href="doctor_dashboard.jsp"
           class="btn btn-outline-info btn-sm ml-3">
            Dashboard
        </a>
    </div>
</nav>

<div class="container mt-5 col-md-8">

<h3 class="text-center mb-4">📝 Prescription</h3>

<%
Connection con = DbConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
"SELECT pr.medicines, pr.notes, pr.created_at, d.doctor_name " +
"FROM prescription pr " +
"JOIN appointment a ON pr.appointment_id=a.appointment_id " +
"JOIN doctor d ON a.doctor_id=d.doctor_id " +
"WHERE pr.appointment_id=?"
);
ps.setInt(1, appointmentId);
ResultSet rs = ps.executeQuery();

if(rs.next()){
%>

<div class="card-glass">

<p class="label">Doctor</p>
<div class="data"><%=rs.getString("doctor_name")%></div>

<p class="label mt-3">Medicines</p>
<div class="data"><%=rs.getString("medicines")%></div>

<p class="label mt-3">Notes</p>
<div class="data"><%=rs.getString("notes")%></div>

<p class="text-muted mt-3">
    Issued on: <%=rs.getTimestamp("created_at")%>
</p>

<div class="text-right mt-4">
    <a href="../DownloadPrescriptionPDF?appointment_id=<%=appointmentId%>"
       class="btn btn-success btn-sm">⬇ Download PDF</a>

    <button onclick="window.print()"
            class="btn btn-info btn-sm ml-2">🖨 Print</button>

    <a href="Patient_dashboard.jsp"
       class="btn btn-outline-light btn-sm ml-2">⬅ Back</a>
</div>

</div>

<% } %>

</div>

</body>
</html>
