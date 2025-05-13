package com.wheel_deal.util;

import java.sql.*;

public class UserConnect {

    public static boolean validateUser(String username, String password) {
        boolean isValid = false;

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wheeldeal", "root", "Skl2005?");
            
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            isValid = rs.next();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isValid;
    }
}

