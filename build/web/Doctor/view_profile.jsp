<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Profile</title>

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

        .profile-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .profile-icon {
            font-size: 80px;
            color: #4dd0e1;
        }

        .label {
            color: #4dd0e1;
            font-weight: 600;
        }

        .btn-edit {
            border-radius: 30px;
            padding: 10px 30px;
            font-weight: 600;
            background: linear-gradient(135deg, #1cb5e0, #000851);
            border: none;
            color: #fff;
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

    <div class="ml-auto">
        <a href="doctor_dashboard.jsp" class="btn btn-outline-info btn-sm mr-2">Dashboard</a>
        <a href="logout.jsp" class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container">

    <h3 class="text-center mb-4">👨‍⚕️ Doctor Profile</h3>

    <div class="row justify-content-center">
        <div class="col-md-6">
            
            <%
                if (session.getAttribute("profileSuccess") != null) {
            %>
                <div class="alert alert-success text-center">
                    <%= session.getAttribute("profileSuccess") %>
                </div>
            <%
                    session.removeAttribute("profileSuccess");
                }

                if (session.getAttribute("profileError") != null) {
            %>
                <div class="alert alert-danger text-center">
                    <%= session.getAttribute("profileError") %>
                </div>
            <%
                    session.removeAttribute("profileError");
                }
            %>

            <div class="profile-card text-center">

                <div class="profile-icon mb-3">
                    <i class="fas fa-user-md"></i>
                </div>

                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    String doctorName = "";
                    String email = "";
                    String contact = "";
                    String deptName = "";

                    try {
                        con = DbConnection.getConnection();
                        String sql =
                          "SELECT d.doctor_name, d.email, d.contact, dep.dept_name " +
                          "FROM doctor d JOIN department dep ON d.dept_id = dep.dept_id " +
                          "WHERE d.doctor_id = ?";

                        ps = con.prepareStatement(sql);
                        ps.setInt(1, (int) session.getAttribute("doctor_id"));
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            doctorName = rs.getString("doctor_name");
                            email = rs.getString("email");
                            contact = rs.getString("contact");
                            deptName = rs.getString("dept_name");
                        }
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>" + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>

                <p><span class="label">Name:</span> <%= doctorName %></p>
                <p><span class="label">Email:</span> <%= email %></p>
                <p><span class="label">Contact:</span> <%= contact %></p>
                <p>
                    <span class="label">Department:</span>
                    <span class="badge badge-info"><%= deptName %></span>
                </p>

                <!-- Edit Profile Button -->
                <a href="edit_profile.jsp" class="btn btn-edit mt-4">
                    <i class="fas fa-edit"></i> Edit Profile
                </a>

            </div>

        </div>
    </div>

</div>

</body>
</html>
