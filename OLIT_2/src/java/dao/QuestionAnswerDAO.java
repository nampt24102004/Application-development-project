/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.QuestionAnswer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Long0
 */
public class QuestionAnswerDAO {

    public static List<QuestionAnswer> getQuestionAnswerByQuestionID(int questionID) {
        List<QuestionAnswer> questionAnswers = new ArrayList<QuestionAnswer>();
        DBContext db = new DBContext().getInstance();
        String sql = """
                     SELECT * FROM QuestionAnswer WHERE QuestionID = ?
                     """;
        try (PreparedStatement ps = db.getConnection().prepareCall(sql)) {
            ps.setInt(1, questionID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    QuestionAnswer questionAnswer = new QuestionAnswer(
                            rs.getInt("AnswerID"),
                            rs.getString("AnswerDetail"),
                            rs.getString("Explanation"),
                            rs.getBoolean("IsCorrect"),
                            rs.getInt("QuestionID")
                    );
                    questionAnswers.add(questionAnswer);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questionAnswers;
    }

    public static boolean createQuestionAnswer(int questionID, String answerDetail, String explanation, boolean isCorrect) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                        INSERT INTO QuestionAnswer (QuestionID, AnswerDetail, Explanation, IsCorrect)
                        VALUES (?, ?, ?, ?)
                        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, questionID);
            statement.setString(2, answerDetail);
            statement.setString(3, explanation);
            statement.setBoolean(4, isCorrect);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean changeQuestionAnswer(int questionID, int answerID, String answerDetail, String explanation, boolean isCorrect) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                        UPDATE QuestionAnswer
                        SET AnswerDetail = ?, Explanation = ?, IsCorrect = ?
                        WHERE AnswerID = ? AND QuestionID = ?
                        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, answerDetail);
            statement.setString(2, explanation);
            statement.setBoolean(3, isCorrect);
            statement.setInt(4, answerID);
            statement.setInt(5, questionID);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteQuestionAnswerByID(int answerID) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                        DELETE FROM QuestionAnswer
                        WHERE AnswerID = ?
                        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, answerID);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
