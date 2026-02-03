<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@page import="com.srujal.dao.PrescriptionDAO"%>

<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("doctor_login.jsp");
        return;
    }

    List<Integer> prescriptionModalList = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor | View Appointments</title>

    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }

        .table-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.35);
        }

        .table thead th {
            background: rgba(0,0,0,0.35);
            color: #4dd0e1;
            border: none;
        }

        .table tbody tr:hover {
            background: rgba(255,255,255,0.1);
        }

        .badge {
            padding: 7px 12px;
            border-radius: 15px;
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

    <div class="ml-auto text-white">
        <i class="fas fa-user-md"></i>
        <b><%= session.getAttribute("doctor_name") %></b>

        <a href="doctor_dashboard.jsp"
           class="btn btn-outline-info btn-sm ml-3">
            Dashboard
        </a>
    </div>
</nav>

<div class="container">

    <h3 class="text-center mb-4">📅 Patient Appointments</h3>

    <div class="table-card">
        <table class="table table-borderless table-hover text-center">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Patient Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th>Prescription</th>
                </tr>
            </thead>
            <tbody>

            <%
                int doctorId = (int) session.getAttribute("doctor_id");
                int i = 1;

                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DbConnection.getConnection();
                    String sql =
                        "SELECT a.appointment_id, a.appointment_date, a.appointment_time, a.status, " +
                        "p.patient_name " +
                        "FROM appointment a " +
                        "JOIN patient p ON a.patient_id = p.patient_id " +
                        "WHERE a.doctor_id = ?";

                    ps = con.prepareStatement(sql);
                    ps.setInt(1, doctorId);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int appointmentId = rs.getInt("appointment_id");
                        String status = rs.getString("status");
            %>

                <tr>
                    <td><%= i++ %></td>
                    <td><%= rs.getString("patient_name") %></td>
                    <td><%= rs.getDate("appointment_date") %></td>
                    <td><%= rs.getString("appointment_time") %></td>

                    <td>
                        <% if ("Approved".equalsIgnoreCase(status)) { %>
                            <span class="badge badge-success">Approved</span>
                        <% } else if ("Cancelled".equalsIgnoreCase(status)) { %>
                            <span class="badge badge-danger">Cancelled</span>
                        <% } else { %>
                            <span class="badge badge-warning text-dark">Pending</span>
                        <% } %>
                    </td>

                    <td>
                        <% if ("Pending".equalsIgnoreCase(status)) { %>
                            <a href="../UpdateAppointmentStatusServlet?id=<%=appointmentId%>&status=Approved"
                               class="btn btn-success btn-sm">Approve</a>

                            <a href="../UpdateAppointmentStatusServlet?id=<%=appointmentId%>&status=Cancelled"
                               class="btn btn-danger btn-sm">Cancel</a>
                        <% } else { %>
                            —
                        <% } %>
                    </td>

                    <td>
                        <%
                            boolean hasPrescription =
                                PrescriptionDAO.prescriptionExists(appointmentId);

                            if (hasPrescription) {
                        %>
                            <a href="view_prescription.jsp?appointment_id=<%=appointmentId%>"
                               class="btn btn-info btn-sm">View</a>
                        <%
                            } else if ("Approved".equalsIgnoreCase(status)) {
                                prescriptionModalList.add(appointmentId);
                        %>
                            <button type="button" class="btn btn-success btn-sm"
                                    data-toggle="modal"
                                    data-target="#prescriptionModal<%=appointmentId%>">
                                Add
                            </button>
                        <%
                            } else {
                        %>
                            <span class="text-muted">—</span>
                        <%
                            }
                        %>
                    </td>
                </tr>

            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            %>

            </tbody>
        </table>
    </div>
</div>

<!-- ================= MODALS (OUTSIDE TABLE) ================= -->
<%
    for (int appointmentId : prescriptionModalList) {
%>
<div class="modal fade" id="prescriptionModal<%=appointmentId%>" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content text-dark">

            <form method="post" action="../AddPrescriptionServlet">
                <div class="modal-header">
                    <h5 class="modal-title">Add Prescription</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="appointment_id" value="<%=appointmentId%>">

                    <div class="form-group">
                        <label>Medicines</label>
                        <textarea name="medicines" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="form-group">
                        <label>Notes</label>
                        <textarea name="notes" class="form-control" rows="2"></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success btn-sm">Save</button>
                    <button type="button" class="btn btn-secondary btn-sm"
                            data-dismiss="modal">Cancel</button>
                </div>
            </form>

        </div>
    </div>
</div>
<%
    }
%>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
$(document).on('hidden.bs.modal', function () {
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
});
</script>

</body>
</html>
