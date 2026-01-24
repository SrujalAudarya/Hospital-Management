<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Unauthorized Access</title>

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
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }

        .error-box {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            max-width: 450px;
            width: 100%;
        }

        .error-box i {
            font-size: 60px;
            color: #ff6b6b;
            margin-bottom: 15px;
        }

        .error-box h3 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .error-box p {
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .btn-home {
            background: #4dd0e1;
            color: #000;
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
        }

        .btn-home:hover {
            background: #3bb8c8;
            color: #000;
        }
    </style>
</head>

<body>

<div class="error-box">
    <i class="fas fa-ban"></i>
    <h3>Unauthorized Access</h3>
    <p>
        You do not have permission to access this page.<br>
        Please login with the correct account.
    </p>

    <a href="index.jsp" class="btn btn-home">
        Go to Home
    </a>
</div>

</body>
</html>
