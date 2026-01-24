<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@ include file="admin_header.jsp" %>

<div class="content-box container mt-4">
    <a href="admin_dashboard.jsp" class="btn btn-outline-info mb-3">← Back</a>

    <h4 class="mb-3">Manage Doctors</h4>

    <!-- Add Doctor Form -->
    <form method="post" action="../AdminServlet">
        <input type="hidden" name="action" value="addDoctor">
        <div class="form-row mb-2">
            <div class="col">
                <input type="text" name="doctor_name" class="form-control" placeholder="Doctor Name" required>
            </div>
            <div class="col">
                <input type="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="col">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
        </div>

        <div class="form-row mb-3">
            <div class="col">
                <input type="text" name="contact" class="form-control" placeholder="Contact" required>
            </div>
            <div class="col">
                <select name="dept_id" class="form-control" required>
                    <option value="">Select Department</option>
                    <%
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet depRs = null;
                        try {
                            con = DbConnection.getConnection();
                            stmt = con.createStatement();
                            depRs = stmt.executeQuery("SELECT * FROM department");
                            while(depRs.next()){
                    %>
                    <option value="<%= depRs.getInt("dept_id") %>">
                        <%= depRs.getString("dept_name") %>
                    </option>
                    <%      }
                        } catch(Exception e) {
                            out.println("<option>Error loading departments</option>");
                        } finally {
                            if(depRs != null) depRs.close();
                            if(stmt != null) stmt.close();
                            if(con != null) con.close();
                        }
                    %>
                </select>
            </div>
            <div class="col">
                <button class="btn btn-info btn-block" type="submit">Add Doctor</button>
            </div>
        </div>
    </form>

    <!-- Doctors Table -->
    <table class="table table-dark table-bordered mt-4">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Department</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con2 = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    con2 = DbConnection.getConnection();
                    String q = "SELECT d.*, dep.dept_name FROM doctor d JOIN department dep ON d.dept_id=dep.dept_id";
                    st = con2.createStatement();
                    rs = st.executeQuery(q);

                    while(rs.next()){
            %>
            <tr>
                <td><%= rs.getInt("doctor_id") %></td>
                <td><%= rs.getString("doctor_name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("dept_name") %></td>
                <td>
                    <form method="post" action="../AdminServlet">
                        <input type="hidden" name="action" value="deleteDoctor">
                        <input type="hidden" name="doctor_id" value="<%= rs.getInt("doctor_id") %>">
                        <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='6'>Error loading doctors</td></tr>");
                } finally {
                    if(rs != null) rs.close();
                    if(st != null) st.close();
                    if(con2 != null) con2.close();
                }
            %>
        </tbody>
    </table>
</div>
