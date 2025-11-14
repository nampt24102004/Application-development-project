/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import model.Subject;
import java.sql.*;
import java.util.*;

/**
 *
 * @author khain
 */
public class SubjectMediaDAO extends DBContext {

    public void insertMedia(int subjectId, String mediaUrl, String mediaType, String name) {
        String sql = "INSERT INTO SubjectMedia (SubjectID, MediaURL, MediaType, MediaName) VALUES (?, ?, ?, ?)";
        Connection conn = DBContext.getInstance().getConnection();
        PreparedStatement ps = null;
        try {
            if (conn == null || conn.isClosed()) {
                // Mở lại connection bằng tay
                String user = "sa";
                String password = "123";
                String url = "jdbc:sqlserver://localhost:1433;databaseName=OLIT;TrustServerCertificate=true";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(url, user, password);
            }

            ps = conn.prepareStatement(sql);
            ps.setInt(1, subjectId);
            ps.setString(2, mediaUrl);
            ps.setString(3, mediaType);
            ps.setString(4, name);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
            }
            // KHÔNG đóng conn nhé
        }
    }

}
