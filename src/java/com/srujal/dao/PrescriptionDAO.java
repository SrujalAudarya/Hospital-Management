package com.srujal.dao;

import com.srujal.util.DbConnection;
import java.sql.*;

public class PrescriptionDAO {

    // Add new prescription
    public static boolean addPrescription(int appointmentId, String medicines, String notes) {
        boolean status = false;
        try (Connection con = DbConnection.getConnection()) {
            String sql = "INSERT INTO prescription (appointment_id, medicines, notes) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setString(2, medicines);
            ps.setString(3, notes);
            ps.executeUpdate();
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Check if prescription exists for an appointment
    public static boolean prescriptionExists(int appointmentId) {
        boolean exists = false;
        try (Connection con = DbConnection.getConnection()) {
            String sql = "SELECT * FROM prescription WHERE appointment_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) exists = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    public static boolean updatePrescription(int prescriptionId,
                                         String medicines,
                                         String notes) {
        boolean status = false;
        Connection con = DbConnection.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE prescription SET medicines=?, notes=? WHERE prescription_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, medicines);
            ps.setString(2, notes);
            ps.setInt(3, prescriptionId);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {}
        }
        return status;
    }
}
