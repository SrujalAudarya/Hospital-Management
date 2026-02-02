<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>


<%
    if (session.getAttribute("doctor_id") == null) {
        response.sendRedirect("doctor_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor | View Appointments</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

    <!-- Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>


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
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= rs.getString("patient_name") %></td>
                <td><%= rs.getDate("appointment_date") %></td>
                <td><%= rs.getString("appointment_time") %></td>

                <td>
                    <%
                        String status = rs.getString("status");
                        if ("Approved".equalsIgnoreCase(status)) {
                    %>
                        <span class="badge badge-success">Approved</span>
                    <% } else if ("Cancelled".equalsIgnoreCase(status)) { %>
                        <span class="badge badge-danger">Cancelled</span>
                    <% } else { %>
                        <span class="badge badge-warning text-dark">Pending</span>
                    <% } %>
                </td>

                <td>
                    <% if ("Pending".equalsIgnoreCase(status)) { %>
                        <a href="../UpdateAppointmentStatusServlet?id=<%= rs.getInt("appointment_id") %>&status=Approved"
                           class="btn btn-success btn-sm">
                            Approve
                        </a>

                        <a href="../UpdateAppointmentStatusServlet?id=<%= rs.getInt("appointment_id") %>&status=Cancelled"
                           class="btn btn-danger btn-sm">
                            Cancel
                        </a>
                    <% } else { %>
                        —
                    <% } %>
                </td>
                
                <td>
                    <%
                        boolean hasPrescription = com.srujal.dao.PrescriptionDAO.prescriptionExists(appointmentId);
                        if(hasPrescription){
                    %>
                        <a href="view_prescription.jsp?appointment_id=<%=appointmentId%>"
                           class="btn btn-info btn-sm">View</a>
                    <%
                        } else if("Approved".equalsIgnoreCase(status)) {
                    %>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" 
                                data-target="#prescriptionModal<%=appointmentId%>">
                            Add
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="prescriptionModal<%=appointmentId%>" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
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
                                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
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
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
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

</body>
</html>
