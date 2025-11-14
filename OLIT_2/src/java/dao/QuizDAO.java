
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class QuizDAO extends DBContext {
    public Quiz getQuizBySectionId(int sectionId) {
        String query = "SELECT * FROM Quiz WHERE SectionID = ? AND Status = 1";
        try (
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(query);) {
            ps.setInt(1, sectionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuizID(rs.getInt("QuizID"));
                    quiz.setSectionID(rs.getInt("SectionID"));
                    quiz.setQuizName(rs.getString("QuizName"));
                    quiz.setPassRate(rs.getDouble("PassRate"));
                    quiz.setQuizType(rs.getString("QuizType"));
                    quiz.setQuizDuration(rs.getInt("QuizDuration"));
                    quiz.setQuizLevel(rs.getString("QuizLevel"));
                    quiz.setStatus(rs.getBoolean("Status"));
                    return quiz;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
