<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>CityCare Hospital</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0f2027;
            color: #fff;
        }

        /* HERO SECTION */
        .hero {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: 700;
        }

        .hero p {
            font-size: 18px;
            color: #d1ecf1;
        }

        .btn-main {
            border-radius: 30px;
            padding: 10px 30px;
            font-weight: 600;
        }

        /* SECTION */
        .section {
            padding: 80px 0;
        }

        .section-title {
            font-weight: 600;
            margin-bottom: 40px;
            text-align: center;
        }

        /* CARD */
        .glass-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        /* DOCTOR CARD */
        .doctor-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            object-position: top; 
            border-radius: 15px;
        }

        .doctor-card h5 {
            margin-top: 15px;
            font-weight: 600;
        }
        
        .doctor-img-box {
            width: 100%;
            height: 280px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb, #90caf9);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .doctor-img-box img {
            height: 100%;
            object-fit: contain;   /* keeps PNG fully visible */
        }

        footer {
            background: #0b1a20;
            padding: 20px 0;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>

<body>

<!-- HERO SECTION -->
<section class="hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1>CityCare Hospital</h1>
                <p>
                    Trusted healthcare services with expert doctors, modern facilities,
                    and compassionate care — available for you 24×7.
                </p>

                <a href="patient/patient_login.jsp" class="btn btn-info btn-main mr-3">
                    Patient Login
                </a>

                <a href="patient/patient_register.jsp" class="btn btn-outline-light btn-main">
                    Patient Registration
                </a>
            </div>

            <div class="col-md-6 text-center">
                <img src="https://images.unsplash.com/photo-1586773860418-d37222d8fce3"
                     class="img-fluid rounded"
                     alt="Hospital Image">
            </div>
        </div>
    </div>
</section>

<!-- ABOUT HOSPITAL -->
<section class="section">
    <div class="container">
        <h3 class="section-title">About Our Hospital</h3>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="glass-card text-center">
                    <i class="fas fa-hospital fa-3x mb-3 text-info"></i>
                    <h5>Modern Infrastructure</h5>
                    <p>
                        State-of-the-art facilities with advanced medical technology.
                    </p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="glass-card text-center">
                    <i class="fas fa-user-md fa-3x mb-3 text-info"></i>
                    <h5>Expert Doctors</h5>
                    <p>
                        Highly qualified specialists across all major departments.
                    </p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="glass-card text-center">
                    <i class="fas fa-heartbeat fa-3x mb-3 text-info"></i>
                    <h5>24×7 Emergency</h5>
                    <p>
                        Round-the-clock emergency and intensive care services.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- DOCTORS SECTION -->
<section class="section" style="background:#132b35;">
    <div class="container">
        <h3 class="section-title">Our Doctors</h3>

        <div class="row">

            <div class="col-md-4 mb-4">
                <div class="glass-card doctor-card text-center">
                    <img src="https://www.fortishealthcare.com/drupal-data/doctors/dr-amit-sharma-308.jpg " alt="Doctor">
                    <h5>Dr. Amit Sharma</h5>
                    <p>Cardiologist</p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="glass-card doctor-card text-center">
                    <div class="doctor-img-box">
                        <img src="https://www.drnehaarora.com/wp-content/uploads/2023/08/neha-arora.png"
                             alt="Dr Neha Arora">
                    </div>
                    <h5>Dr. Neha Verma</h5>
                    <p>Neurologist</p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="glass-card doctor-card text-center">
                    <img src="https://images.unsplash.com/photo-1622253692010-333f2da6031d" class="image-fluid" alt="Doctor">
                    <h5>Dr. Rahul Mehta</h5>
                    <p>Orthopedic Surgeon</p>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- FOOTER -->
<footer>
    © 2026 CityCare Hospital | All Rights Reserved
</footer>

</body>
</html>
