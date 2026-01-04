package com.srujal.util;

import java.sql.*;
public class DbConnection {
    public static Connection getConnection(){
        Connection con = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/hospitaldb";
            String username = "root";
            String password = "root";
            
            con = DriverManager.getConnection(url, username, password);
            
            System.out.println("Connected!");
        }catch(Exception e){
            e.printStackTrace();
        }
        return con;
    }
}
