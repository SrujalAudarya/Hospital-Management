<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@ include file="admin_header.jsp" %>

<div class="content-box">

    <a href="admin_dashboard.jsp" class="btn btn-outline-info back-btn">
        ← Back to Dashboard
    </a>

    <h4 class="mb-3">Registered Patients</h4>

    <table class="table table-dark table-bordered table-hover">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Gender</th>
            <th>Age</th>            
            <th>Registration Date</th>
        </tr>

        <%
            Connection con = DbConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM patient");

            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("patient_id") %></td>
            <td><%= rs.getString("patient_name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("contact") %></td>
            <td><%= rs.getString("gender") %></td>            
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("reg_date") %></td>
        </tr>
        <% } %>
    </table>

</div>

<%@ include file="admin_footer.jsp" %>
