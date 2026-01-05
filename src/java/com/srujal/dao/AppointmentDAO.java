
package com.srujal.dao;

import com.srujal.util.DbConnection;
import java.sql.*;

public class AppointmentDAO {
    
    public static boolean BookAppointment(int doctor_id, int patient_id, String appointment_date, String appointment_time){
        Boolean status = false;
        Connection con = DbConnection.getConnection();
        PreparedStatement pstmt = null;
        try{
            String sql = "insert into appointment(appointment_date, appointment_time, doctor_id, patient_id) "
                    + "values(?, ?, ?, ?)";
            
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, appointment_date);
            pstmt.setString(2, appointment_time);
            pstmt.setInt(3, doctor_id);
            pstmt.setInt(4, patient_id);

            pstmt.executeUpdate();
            
            System.out.println("Appointment Booked Successfully!");
            status = true;
            
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
            
            }
        }
        return status;
    }
}
