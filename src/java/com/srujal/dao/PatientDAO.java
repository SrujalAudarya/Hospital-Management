
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
}
