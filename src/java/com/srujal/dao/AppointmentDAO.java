
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
    
    public static boolean updateAppointmentStatus(int appointmentId, String status) {
        boolean result = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DbConnection.getConnection();
            String sql = "UPDATE appointment SET status=? WHERE appointment_id=?";
            ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, appointmentId);

            ps.executeUpdate();
            result = true;

            System.out.println("Appointment status updated to: " + status);

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
        return result;
    }

}
