<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@ include file="admin_header.jsp" %>

<div class="content-box">
<a href="admin_dashboard.jsp" class="btn btn-outline-info mb-3">← Back</a>

<h4>Appointments</h4>

<table class="table table-dark table-bordered">
<tr>
    <th>ID</th>
    <th>Patient</th>
    <th>Doctor</th>
    <th>Date</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
String sql =
"SELECT a.appointment_id,p.patient_name,d.doctor_name,a.appointment_date,a.status " +
"FROM appointment a JOIN patient p ON a.patient_id=p.patient_id " +
"JOIN doctor d ON a.doctor_id=d.doctor_id";

Connection con = DbConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(sql);

while(rs.next()){
%>
<tr>
<td><%=rs.getInt(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getDate(4)%></td>
<td><%=rs.getString(5)%></td>
<td>
<form method="post" action="../AdminServlet">
<input type="hidden" name="action" value="updateAppointment">
<input type="hidden" name="appointment_id" value="<%=rs.getInt(1)%>">
<select name="status" class="form-control form-control-sm mb-1">
<option>Approved</option>
<option>Cancelled</option>
<option>Pending</option>
</select>
<button class="btn btn-success btn-sm">Update</button>
</form>
</td>
</tr>
<% } %>
</table>
</div>

<%@ include file="admin_footer.jsp" %>
