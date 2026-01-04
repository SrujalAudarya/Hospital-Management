
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
}
