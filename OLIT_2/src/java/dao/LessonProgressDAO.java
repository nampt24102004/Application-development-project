package dao;

import dal.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class LessonProgressDAO {
    /** true nếu user đã hoàn thành lesson */
    public boolean isCompleted(int userId, int lessonId) throws Exception {
        String sql = "SELECT Completed FROM LessonProgress WHERE UserID=? AND LessonID=?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getBoolean("Completed");
            }
        }
    }

    /** Ghi nhận hoàn thành (idempotent) */
    public void markCompleted(int userId, int lessonId) throws Exception {
        String sql = """
            MERGE LessonProgress AS tgt
            USING (SELECT ? AS UserID, ? AS LessonID) src
            ON (tgt.UserID = src.UserID AND tgt.LessonID = src.LessonID)
            WHEN MATCHED THEN UPDATE SET Completed = 1, CompletedAt = ?
            WHEN NOT MATCHED THEN
                INSERT (UserID, LessonID, Completed, CompletedAt)
                VALUES (src.UserID, src.LessonID, 1, ?);
            """;
        Timestamp ts = Timestamp.valueOf(LocalDateTime.now());
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, lessonId);
            ps.setTimestamp(3, ts);
            ps.setTimestamp(4, ts);
            ps.executeUpdate();
        }
    }

    public int countCompletedInCourse(int userId, int courseId) throws Exception {
        String sql = """
            SELECT COUNT(*) FROM LessonProgress lp
            JOIN Lesson l ON lp.LessonID = l.LessonID
            JOIN SectionModule sm ON l.ModuleID = sm.ModuleID
            JOIN CourseSection cs ON sm.SectionID = cs.SectionID
            WHERE lp.UserID = ? AND lp.Completed = 1 AND cs.CourseID = ?
            """;
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
    public List<Integer> getCompletedLessonIds(int userId) {
    List<Integer> completed = new ArrayList<>();
    String sql = """
        select LessonID from LessonProgress where UserID = ? 
    """;

    try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                completed.add(rs.getInt("LessonID"));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return completed;
}
   

}
