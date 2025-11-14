/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Dimension;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Long0
 */
public class DimensionDAO {

    public static List<Dimension> getAllDimension() {
        List<Dimension> dimensions = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                            SELECT * FROM Dimension
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Dimension dimension = new Dimension(
                        rs.getInt("DimensionID"),
                        rs.getInt("SubjectID"),
                        rs.getString("DimensionName"),
                        rs.getString("Description")
                );
                dimensions.add(dimension);
            }
        } catch (Exception e) {
            return null;
        }
        return dimensions;
    }
    
    public static List<Dimension> getDimensionsByQuestionID(int questionID) {
        List<Dimension> dimensions = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         SELECT d.DimensionID, d.SubjectID, d.DimensionName, d.Description 
                         FROM Dimension d
                         JOIN QuestionDimension qd ON d.DimensionID = qd.DimensionID
                         WHERE qd.QuestionID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, questionID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Dimension dimension = new Dimension(
                        rs.getInt("DimensionID"),
                        rs.getInt("SubjectID"),
                        rs.getString("DimensionName"),
                        rs.getString("Description")
                );
                dimensions.add(dimension);
            }
        } catch (Exception e) {
            return null;
        }
        return dimensions;
    }
    
    public static boolean insertQuestionDimension(int questionID, int dimensionID) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO QuestionDimension (
                QuestionID, DimensionID
            ) VALUES (?, ?)
        """;

        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);

            stmt.setInt(1, questionID);
            stmt.setInt(2, dimensionID);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            // Có thể log lỗi chi tiết hơn ở đây
            return false;
        }
    }

}
