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
    <title>Edit Profile | Patient</title>

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
            width:450px;
            color:#fff;
            box-shadow:0 25px 45px rgba(0,0,0,0.35);
        }
        .profile-card h4{
            text-align:center;
            margin-bottom:20px;
            color:#4dd0e1;
        }
        label{
            font-weight:600;
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
    <h4>Edit Profile</h4>

    <form method="post" action="../UpdatePatientProfileServlet">

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="patient_name" class="form-control"
                   value="<%= rs.getString("patient_name") %>" required>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" class="form-control"
                   value="<%= rs.getString("email") %>" disabled>
        </div>

        <div class="form-group">
            <label>Contact</label>
            <input type="text" name="contact" class="form-control"
                   value="<%= rs.getString("contact") %>" required>
        </div>

        <div class="form-group">
            <label>Address</label>
            <textarea name="address" class="form-control" rows="3" required>
<%= rs.getString("address") %>
            </textarea>
        </div>

        <div class="text-center mt-4">
            <button class="btn btn-success">Update</button>
            <a href="view_profile.jsp" class="btn btn-outline-light ml-2">Cancel</a>
        </div>

    </form>
</div>

</body>
</html>
