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
    <title>Edit Doctor Profile</title>

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

        .edit-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .form-control {
            background: rgba(0,0,0,0.35);
            border: none;
            color: #fff;
            border-radius: 30px;
        }

        .form-control:focus {
            background: rgba(0,0,0,0.5);
            color: #fff;
            box-shadow: none;
        }

        .btn-save {
            background: linear-gradient(135deg, #1cb5e0, #000851);
            border: none;
            border-radius: 30px;
            padding: 10px 30px;
            font-weight: 600;
            color: #fff;
        }

        label {
            color: #4dd0e1;
            font-weight: 600;
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
        <a href="view_profile.jsp" class="btn btn-outline-info btn-sm mr-2">Back</a>
        <a href="logout.jsp" class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container">

    <h3 class="text-center mb-4">✏️ Edit Profile</h3>

    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="edit-card">

                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    String name = "";
                    String email = "";
                    String contact = "";
                    String dept = "";

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
                            name = rs.getString("doctor_name");
                            email = rs.getString("email");
                            contact = rs.getString("contact");
                            dept = rs.getString("dept_name");
                        }
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>" + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>

                <form action="../UpdateDoctorProfileServlet" method="post">

                    <div class="form-group">
                        <label>Doctor Name</label>
                        <input type="text" name="doctor_name" class="form-control"
                               value="<%= name %>" required>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control"
                               value="<%= email %>" required>
                    </div>

                    <div class="form-group">
                        <label>Contact</label>
                        <input type="text" name="contact" class="form-control"
                               value="<%= contact %>" required>
                    </div>

                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" class="form-control"
                               value="<%= dept %>" readonly>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-save">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>

                </form>

            </div>

        </div>
    </div>

</div>

</body>
</html>
