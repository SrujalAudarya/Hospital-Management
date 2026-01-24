
package com.srujal.dao;

import com.srujal.model.Admin;
import com.srujal.util.DbConnection;
import java.sql.*;

public class AdminDAO {
    
    public static Admin LoginAdmin(String username, String password){
        Admin admin = null;
        
        try{
            
            Connection con = DbConnection.getConnection();
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet result = pstmt.executeQuery();
            
            while(result.next()){
                admin = new Admin();
                admin.setAdmin_id(result.getInt("admin_id"));
                admin.setUsername(result.getString("username"));
                admin.setPassword(result.getString("password"));
            }
            
            System.out.println("Admin Login Successfully!");
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return admin;
    }
    
    public static void insertLog(String role, int userId, String action) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "INSERT INTO user_logs(user_role, user_id, action) VALUES (?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, role);
            ps.setInt(2, userId);
            ps.setString(3, action);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public static boolean addDepartment(String deptName){
        
        boolean status = false;
        
        try(Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO department(dept_name) VALUES(?)")){

            ps.setString(1, deptName);
            int rows = ps.executeUpdate();
            if(rows > 0) status = true;

        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public static boolean deleteDepartment(int deptId) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "DELETE FROM department WHERE dept_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, deptId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateDepartment(int deptId, String deptName) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "UPDATE department SET dept_name=? WHERE dept_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, deptName);
            ps.setInt(2, deptId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public static boolean addDoctor(String name, String email, String password,
                                String contact, int deptId) {

        boolean status = false;

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO doctor (doctor_name, email, password, contact, dept_id) VALUES (?,?,?,?,?)")) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, contact);
            ps.setInt(5, deptId);

            int rows = ps.executeUpdate();
            if (rows > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    // DELETE DOCTOR
    public static boolean deleteDoctor(int doctorId) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "DELETE FROM doctor WHERE doctor_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // UPDATE DOCTOR
    public static boolean updateDoctor(int id, String name, String email, String contact, int deptId) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "UPDATE doctor SET doctor_name=?, email=?, contact=?, dept_id=? WHERE doctor_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setInt(4, deptId);
            ps.setInt(5, id);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static boolean updateAppointmentStatus(int appId, String status) {
        try (Connection con = DbConnection.getConnection()) {
            String sql = "UPDATE appointment SET status=? WHERE appointment_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, appId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
