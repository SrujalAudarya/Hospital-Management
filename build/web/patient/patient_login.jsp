<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("PatientID") != null){
        response.sendRedirect("Patient_dashboard.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Login</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 35px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            color: #fff;
        }

        .medical-icon {
            font-size: 46px;
            text-align: center;
            margin-bottom: 10px;
            color: #4dd0e1;
        }

        .glass-card h3 {
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
        }

        .form-control {
            border-radius: 30px;
            padding-left: 45px;
            height: 46px;
            background: rgba(255,255,255,0.95);
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 18px;
            transform: translateY(-50%);
            color: #555;
        }

        .form-group {
            position: relative;
        }

        .btn-login {
            border-radius: 30px;
            height: 46px;
            font-weight: 600;
            letter-spacing: 1px;
            background: linear-gradient(135deg, #1cb5e0, #000851);
            border: none;
        }

        .btn-login:hover {
            opacity: 0.9;
        }

        .link {
            color: #4dd0e1;
            font-size: 14px;
        }

        .link:hover {
            color: #ffffff;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="glass-card">

    <div class="medical-icon">
        <i class="fas fa-user-shield"></i>
    </div>

    <h3>Patient Login</h3>

    <form action="../PatientLoginServlet" method="post">

        <div class="form-group">
            <i class="fas fa-envelope input-icon"></i>
            <input type="email" class="form-control" name="email" placeholder="Email Address" required>
        </div>

        <div class="form-group">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" class="form-control" name="password" placeholder="Password" required>
        </div>
        
            <%
            String error = (String) session.getAttribute("loginError");
            if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show text-center" role="alert"
                 style="border-radius: 30px;">
                <i class="fas fa-exclamation-triangle"></i>
                <strong> Login Failed!</strong> <%= error %>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <%
               session.removeAttribute("loginError");
            }
            %>


        <button type="submit" class="btn btn-login btn-block mt-4">
            LOGIN
        </button>

        <div class="text-center mt-3">
            <a href="patient_register.jsp" class="link">New Patient? Register Here</a>
        </div>

    </form>

</div>

</body>
</html>
