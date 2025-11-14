package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Question;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.sql.Statement;

/**
 *
 * @author Admin
 */
public class QuestionDAO extends DBContext {

    public List<Question> getAllQuestion() {
        List<Question> questions = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Question";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("createdAt");
                LocalDateTime createdAt = (timestamp != null) ? timestamp.toLocalDateTime() : null;
                Question question = new Question(
                        rs.getInt("QuestionID"),
                        rs.getString("QuestionContent"),
                        rs.getInt("QuestionType"),
                        rs.getBoolean("Status"),
                        rs.getInt("QuestionLevel"),
                        rs.getInt("CreatedBy"),
                        createdAt,
                        rs.getInt("SubjectId"),
                        rs.getInt("LessonId")
                );
                questions.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return questions;
    }

    public List<Question> getAllQuestionWithParam(String searchQuery, String filterLevel, int pageSize, int pageIndex) {
        List<Question> questions = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Question WHERE 1=1");

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND QuestionContent LIKE ?");
        }
        if (filterLevel != null && !filterLevel.isEmpty()) {
            sql.append(" AND QuestionLevel = ?");
        }

        sql.append(" ORDER BY QuestionID ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery.trim() + "%");
            }
            if (filterLevel != null && !filterLevel.isEmpty()) {
                ps.setString(paramIndex++, filterLevel);
            }

            int offset = (pageIndex - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Timestamp timestamp = rs.getTimestamp("createdAt");
                    LocalDateTime createdAt = (timestamp != null) ? timestamp.toLocalDateTime() : null;
                    Question question = new Question(
                            rs.getInt("QuestionID"),
                            rs.getString("QuestionContent"),
                            rs.getInt("QuestionType"),
                            rs.getBoolean("Status"),
                            rs.getInt("QuestionLevel"),
                            rs.getInt("CreatedBy"),
                            createdAt,
                            rs.getInt("SubjectId"),
                            rs.getInt("LessonId")
                    );
                    questions.add(question);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    public int getTotalQuestionCount(String searchQuery, String filter) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Question WHERE 1=1");

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND QuestionContent LIKE ?");
        }
        if (filter != null && !filter.trim().isEmpty()) {
            sql.append(" AND QuestionLevel = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery + "%");
            }
            if (filter != null && !filter.trim().isEmpty()) {
                ps.setString(paramIndex++, filter);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public static Question getQuesionByID(int questionID) {
        String sql = "SELECT * FROM Question WHERE QuestionID = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, questionID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Timestamp timestamp = rs.getTimestamp("createdAt");
                    LocalDateTime createdAt = (timestamp != null) ? timestamp.toLocalDateTime() : null;

                    return new Question(
                            rs.getInt("QuestionID"),
                            rs.getString("QuestionContent"),
                            rs.getInt("QuestionType"),
                            rs.getBoolean("Status"),
                            rs.getInt("QuestionLevel"),
                            rs.getInt("CreatedBy"),
                            createdAt,
                            rs.getInt("SubjectID"),
                            rs.getInt("LessonID")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean update(Question q) {
        String sql = """
            UPDATE Question
               SET QuestionContent = ?,
                   Status          = ?
             WHERE QuestionID       = ?
            """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, q.getQuestionContent());
            ps.setBoolean(2, q.isStatus());
            ps.setInt(3, q.getQuestionID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a question by its ID. Returns true if the deletion was successful.
     */
    public boolean deleteQuestionByID(int questionID) {
        String sql = "DELETE FROM Question WHERE QuestionID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, questionID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static int insertQuestion(Question question) { // Thay đổi kiểu trả về từ boolean sang int
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO Question (
                QuestionContent, QuestionType, Status, QuestionLevel,
                CreatedBy, CreatedAt, SubjectID, LessonID
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;
        int generatedQuestionId = -1; // Biến để lưu ID được tạo tự động

        try (
                // Thêm Statement.RETURN_GENERATED_KEYS vào prepareStatement
                PreparedStatement stmt = db.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            stmt.setString(1, question.getQuestionContent());
            stmt.setInt(2, question.getQuestionType());
            stmt.setBoolean(3, question.isStatus());
            stmt.setInt(4, question.getQuestionLevel());
            stmt.setInt(5, question.getCreatedBy());
            // Chuyển đổi LocalDateTime sang Timestamp để lưu vào DB
            stmt.setTimestamp(6, Timestamp.valueOf(question.getCreatedAt()));
            stmt.setInt(7, question.getSubjectID());
            stmt.setInt(8, question.getLessonID());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                // Lấy các khóa được tạo tự động (Generated Keys)
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedQuestionId = rs.getInt(1); // Lấy ID của dòng vừa được chèn
                        question.setQuestionID(generatedQuestionId); // Cập nhật ID vào đối tượng Question
                    }
                }
            }
        } catch (Exception e) { // Nên bắt SQLException cụ thể hơn
            e.printStackTrace();
            // Có thể log lỗi chi tiết hơn ở đây
            // generatedQuestionId vẫn là -1 nếu có lỗi
        }
        return generatedQuestionId; // Trả về ID hoặc -1 nếu thất bại
    }
}
