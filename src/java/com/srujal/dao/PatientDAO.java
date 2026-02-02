
package com.srujal.dao;

import java.sql.*;
import com.srujal.model.Patient;
import com.srujal.util.DbConnection;

public class PatientDAO {
    
    public static void RegisterPatient(Patient p){
        
        try{
            Connection con = DbConnection.getConnection();
            String query = "insert into patient(patient_name, email, password, contact, gender, address)"
                + "values(?,?,?,?,?,?)";
            
            PreparedStatement pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, p.getPatient_name());            
            pstmt.setString(2, p.getEmail());
            pstmt.setString(3, p.getPassword());
            pstmt.setString(4, p.getContact());
            pstmt.setString(5, p.getGender());            
            pstmt.setString(6, p.getAddress());
            
            pstmt.executeUpdate();
            
            System.out.println("Patient Registered Successfully");

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public static Patient LoginPatient(String email, String password){
        Patient p = null;
        try{
            Connection con = DbConnection.getConnection();
            String query = "select * from patient where email = ? and password = ?";
            
            PreparedStatement pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()){
                p = new Patient();
                p.setPatient_id(rs.getInt("Patient_id"));
                p.setPatient_name(rs.getString("Patient_name"));
            }
            
            System.out.println("Patient Login Successfully");
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return p;
    }
    
    public static boolean updateProfile(int patientId, String name, String contact, String address) {
        boolean status = false;
        try (Connection con = DbConnection.getConnection()) {

            String sql = "UPDATE patient SET patient_name=?, contact=?, address=? WHERE patient_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, contact);
            ps.setString(3, address);
            ps.setInt(4, patientId);

            ps.executeUpdate();
            status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    public static boolean deletePendingAppointment(int appointmentId, int patientId) {
        boolean status = false;

        try (Connection con = DbConnection.getConnection()) {

            String sql =
                "DELETE FROM appointment " +
                "WHERE appointment_id = ? AND patient_id = ? AND status = 'Pending'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setInt(2, patientId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}
