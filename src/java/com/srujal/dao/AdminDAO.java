
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
    
}
