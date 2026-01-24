<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Portal | Hospital Management System</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
        }

        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 40px;
        }

        .glass-box {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 25px;
            padding: 50px;
            max-width: 700px;
            box-shadow: 0 30px 50px rgba(0,0,0,0.4);
        }

        .hero h1 {
            font-weight: 700;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 17px;
            opacity: 0.95;
        }

        .icon {
            font-size: 60px;
            color: #4dd0e1;
            margin-bottom: 15px;
        }

        .btn-main {
            margin-top: 25px;
            padding: 12px 35px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 30px;
            border: none;
            background: linear-gradient(135deg, #1cb5e0, #000851);
            color: #fff;
        }

        .btn-main:hover {
            opacity: 0.9;
        }

        .footer {
            text-align: center;
            padding: 15px;
            font-size: 14px;
            background: rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

<div class="hero">
    <div class="glass-box">

        <div class="icon">
            <i class="fas fa-user-md"></i>
        </div>

        <h1>Doctor Portal</h1>

        <p>
            Welcome to the Hospital Management System Doctor Portal.<br>
            Securely manage appointments, patients, and your professional profile
            from one centralized dashboard.
        </p>

        <a href="doctor_login.jsp" class="btn btn-main">
            <i class="fas fa-sign-in-alt"></i> Doctor Login
        </a>

    </div>
</div>

<div class="footer">
    © 2026 Hospital Management System | Doctor Panel
</div>

</body>
</html>
