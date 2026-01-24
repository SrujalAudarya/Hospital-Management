<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.srujal.util.DbConnection"%>
<%@ include file="admin_header.jsp" %>

<div class="content-box">
<a href="admin_dashboard.jsp" class="btn btn-outline-info mb-3">← Back</a>

<h4>Manage Departments</h4>

<form method="post" action="../AdminServlet" class="mb-4">
    <input type="hidden" name="action" value="addDepartment">
    <input type="text" name="dept_name" class="form-control mb-2" placeholder="Department Name" required>
    <button class="btn btn-info">Add Department</button>
</form>

<table class="table table-dark table-bordered">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Action</th>
</tr>

<%
Connection con = DbConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM department");
while(rs.next()){
%>
<tr>
    <td><%=rs.getInt("dept_id")%></td>
    <td><%=rs.getString("dept_name")%></td>
    <td>
        <form method="post" action="../AdminServlet" style="display:inline">
            <input type="hidden" name="action" value="deleteDepartment">
            <input type="hidden" name="dept_id" value="<%=rs.getInt("dept_id")%>">
            <button class="btn btn-danger btn-sm">Delete</button>
        </form>
    </td>
</tr>
<% } %>
</table>
</div>

<%@ include file="admin_footer.jsp" %>
