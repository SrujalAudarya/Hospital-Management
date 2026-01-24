<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | Hospital Management System</title>

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
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 22px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 30px 50px rgba(0,0,0,0.4);
            color: #fff;
        }

        .admin-icon {
            font-size: 52px;
            text-align: center;
            color: #4dd0e1;
            margin-bottom: 10px;
        }

        .glass-card h3 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .form-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 18px;
            transform: translateY(-50%);
            color: #555;
        }

        .form-control {
            border-radius: 30px;
            padding-left: 45px;
            height: 46px;
            background: rgba(255,255,255,0.95);
        }

        .btn-login {
            margin-top: 20px;
            height: 46px;
            border-radius: 30px;
            font-weight: 600;
            letter-spacing: 1px;
            border: none;
            background: linear-gradient(135deg, #1cb5e0, #000851);
        }

        .btn-login:hover {
            opacity: 0.9;
        }

        .link {
            font-size: 14px;
            color: #4dd0e1;
        }

        .link:hover {
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="glass-card">

    <div class="admin-icon">
        <i class="fas fa-user-shield"></i>
    </div>

    <h3>Admin Login</h3>

    <!-- Error Message -->
    <%
        if (session.getAttribute("loginError") != null) {
    %>
        <div class="alert alert-danger text-center">
            <%= session.getAttribute("loginError") %>
        </div>
    <%
            session.removeAttribute("loginError");
        }
    %>

    <form action="../AdminLoginServlet" method="post">

        <div class="form-group">
            <i class="fas fa-user input-icon"></i>
            <input type="text" class="form-control" name="username"
                   placeholder="Admin Username" required>
        </div>

        <div class="form-group">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" class="form-control" name="password"
                   placeholder="Password" required>
        </div>

        <button type="submit" class="btn btn-login btn-block">
            LOGIN
        </button>

        <div class="text-center mt-3">
            <a href="../index.jsp" class="link">← Back to Home</a>
        </div>

    </form>

</div>

</body>
</html>
