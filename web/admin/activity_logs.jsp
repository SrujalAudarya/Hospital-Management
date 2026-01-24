<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@ include file="admin_header.jsp" %>

<div class="content-box">
<a href="admin_dashboard.jsp" class="btn btn-outline-info mb-3">← Back</a>

<h4>Activity Logs</h4>

<table class="table table-dark table-bordered">
<tr>
    <th>ID</th>
    <th>Role</th>
    <th>User</th>
    <th>Action</th>
    <th>Time</th>
</tr>

<%
Connection con = DbConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM user_logs ORDER BY log_time DESC");
while(rs.next()){
%>
<tr>
<td><%=rs.getInt("log_id")%></td>
<td><%=rs.getString("user_role")%></td>
<td><%=rs.getInt("user_id")%></td>
<td><%=rs.getString("action")%></td>
<td><%=rs.getTimestamp("log_time")%></td>
</tr>
<% } %>
</table>
</div>

<%@ include file="admin_footer.jsp" %>
