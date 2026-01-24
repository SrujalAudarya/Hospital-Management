<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Registration</title>

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
            max-width: 520px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
            color: #fff;
        }

        .glass-card h3 {
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
        }

        .medical-icon {
            font-size: 46px;
            text-align: center;
            margin-bottom: 10px;
            color: #4dd0e1;
        }

        .form-control {
            border-radius: 30px;
            padding-left: 45px;
            height: 46px;
            background: rgba(255,255,255,0.95);
        }

        textarea.form-control {
            border-radius: 16px;
            height: auto;
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

        .btn-register {
            border-radius: 30px;
            height: 46px;
            font-weight: 600;
            letter-spacing: 1px;
            background: linear-gradient(135deg, #1cb5e0, #000851);
            border: none;
            color: white;
        }

        .btn-register:hover {
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
        <i class="fas fa-user-injured"></i>
    </div>

    <h3>Patient Registration</h3>

    <form action="../PatientRegisterServlet" method="post">

        <div class="form-group">
            <i class="fas fa-user input-icon"></i>
            <input type="text" class="form-control" name="patient_name" placeholder="Patient Full Name">
        </div>

        <div class="form-group">
            <i class="fas fa-envelope input-icon"></i>
            <input type="email" class="form-control" name="email" placeholder="Email Address">
        </div>

        <div class="form-group">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" class="form-control" name="password" placeholder="Password">
        </div>

        <div class="form-group">
            <i class="fas fa-phone input-icon"></i>
            <input type="text" class="form-control" name="contact" placeholder="Contact Number" maxlength="12">
        </div>

        <div class="form-group">
            <i class="fas fa-venus-mars input-icon"></i>
            <select class="form-control" name="gender">
                <option value="">Select Gender</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>
        </div>

        <div class="form-group">
            <i class="fas fa-map-marker-alt input-icon"></i>
            <textarea class="form-control" name="address" rows="3" placeholder="Residential Address"></textarea>
        </div>

        <button type="submit" class="btn btn-register btn-block mt-4">
            REGISTER PATIENT
        </button>
        
        <div class="text-center mt-3">
            <a href="patient_login.jsp" class="link">Have Account? Login Here</a>
        </div>

    </form>
</div>

</body>
</html>
