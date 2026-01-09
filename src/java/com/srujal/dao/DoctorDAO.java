
package com.srujal.dao;

import com.srujal.model.Doctor;
import com.srujal.util.DbConnection;
import java.sql.*;

public class DoctorDAO {
    public static Doctor LoginDoctor(String email, String password){
        Doctor doctor = null;
        
        try{
            Connection con = DbConnection.getConnection();
            String sql = "SELECT * FROM doctor WHERE email = ? and password = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet res = pstmt.executeQuery();
            
            while(res.next()){
                doctor = new Doctor();
                doctor.setDoctor_id(res.getInt("doctor_id"));
                doctor.setDoctor_name(res.getString("doctor_name"));
                doctor.setContact(res.getString("contact"));
                doctor.setEmail(res.getString("email"));
                doctor.setDept_id(res.getInt("dept_id"));
            }
            
            System.out.println("Doctor Login Successfully");
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return doctor;
    }
    
    public static Boolean UpdateProfile(String doctorName, String email, String contact, int doctorId){
        Connection con = null;
        PreparedStatement ps = null;
        Boolean status = false;
        try {
            con = DbConnection.getConnection();

            String sql = "UPDATE doctor SET doctor_name=?, email=?, contact=? WHERE doctor_id=?";
            ps = con.prepareStatement(sql);

            ps.setString(1, doctorName);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setInt(4, doctorId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
                System.out.println("Doctor profile updated successfully");
            }
            
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return status;
    }
}
