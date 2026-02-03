<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>

<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("doctor_login.jsp");
        return;
    }
    int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor | Prescription</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body{
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            font-family: "Segoe UI", sans-serif;
            color:#fff;
        }

        .prescription-card{
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 18px;
            box-shadow: 0 25px 40px rgba(0,0,0,.4);
            padding: 30px;
        }

        .label-title{
            font-weight:600;
            color:#4dd0e1;
        }

        .data-box{
            background: rgba(0,0,0,0.35);
            border-radius: 12px;
            padding: 15px;
            white-space: pre-line;
        }

        .btn-back{
            background:#17a2b8;
            border:none;
        }
        
        /* ===== Modal Theme (Doctor Panel Style) ===== */
        .modal-content {
            background: rgba(15, 32, 39, 0.95);
            backdrop-filter: blur(14px);
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.15);
            color: #fff;
            box-shadow: 0 25px 45px rgba(0,0,0,0.6);
        }

        .modal-header {
            border-bottom: 1px solid rgba(255,255,255,0.15);
        }

        .modal-footer {
            border-top: 1px solid rgba(255,255,255,0.15);
        }

        .modal-title {
            color: #4dd0e1;
            font-weight: 600;
        }

        .modal .close {
            color: #fff;
            opacity: 0.8;
        }

        .modal .close:hover {
            opacity: 1;
        }

        /* Form controls inside modal */
        .modal .form-control {
            background: rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.2);
            color: #fff;
            border-radius: 10px;
        }

        .modal .form-control:focus {
            background: rgba(0,0,0,0.5);
            color: #fff;
            border-color: #4dd0e1;
            box-shadow: none;
        }

        .modal label {
            color: #4dd0e1;
            font-weight: 500;
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
    </div>
</nav>

<div class="container d-flex justify-content-center align-items-center mt-5">
    <div class="col-md-8">

        <h3 class="text-center mb-4">📝 Prescription Details</h3>

        <%
            Connection con=null;
            PreparedStatement ps=null;
            ResultSet rs=null;

            try{
                con = DbConnection.getConnection();
                String sql =
                    "SELECT pr.prescription_id, pr.medicines, pr.notes, pr.created_at, " +
                    "p.patient_name, d.doctor_name " +
                    "FROM prescription pr " +
                    "JOIN appointment a ON pr.appointment_id=a.appointment_id " +
                    "JOIN patient p ON a.patient_id=p.patient_id " +
                    "JOIN doctor d ON a.doctor_id=d.doctor_id " +
                    "WHERE pr.appointment_id=?";

                ps=con.prepareStatement(sql);
                ps.setInt(1,appointmentId);
                rs=ps.executeQuery();

                if(rs.next()){
        %>

        <div class="prescription-card">

            <div class="row mb-3">
                <div class="col-md-6">
                    <p class="label-title">👤 Patient</p>
                    <div class="data-box"><%=rs.getString("patient_name")%></div>
                </div>
                <div class="col-md-6">
                    <p class="label-title">🩺 Doctor</p>
                    <div class="data-box"><%=rs.getString("doctor_name")%></div>
                </div>
            </div>

            <div class="mb-3">
                <p class="label-title">💊 Medicines</p>
                <div class="data-box"><%=rs.getString("medicines")%></div>
            </div>

            <div class="mb-3">
                <p class="label-title">🗒 Notes</p>
                <div class="data-box"><%=rs.getString("notes")%></div>
            </div>

            <p class="text-muted small">
                Created At: <%=rs.getTimestamp("created_at")%>
            </p>

            <div class="text-right">
                <button class="btn btn-warning btn-sm"
                        data-toggle="modal"
                        data-target="#editPrescriptionModal">
                    ✏ Edit
                </button>

                <a href="view_appointments.jsp"
                   class="btn btn-back btn-sm ml-2 text-white">
                    ⬅ Back
                </a>
            </div>
        </div>

        <!-- ================= EDIT MODAL ================= -->
        <div class="modal fade" id="editPrescriptionModal">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">

                    <form action="../EditPrescriptionServlet" method="post">

                        <div class="modal-header">
                            <h5>Edit Prescription</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" name="prescription_id"
                                   value="<%=rs.getInt("prescription_id")%>">

                            <div class="form-group">
                                <label>Medicines</label>
                                <textarea class="form-control" name="medicines"
                                          rows="4" required><%=rs.getString("medicines")%></textarea>
                            </div>

                            <div class="form-group">
                                <label>Notes</label>
                                <textarea class="form-control" name="notes"
                                          rows="3"><%=rs.getString("notes")%></textarea>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="btn btn-success btn-sm">Update</button>
                            <button class="btn btn-secondary btn-sm"
                                    data-dismiss="modal">Cancel</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>

        <%
                } else {
                    out.println("<div class='alert alert-danger'>Prescription not found</div>");
                }
            }catch(Exception e){
                out.println(e.getMessage());
            }finally{
                if(rs!=null) rs.close();
                if(ps!=null) ps.close();
                if(con!=null) con.close();
            }
        %>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
