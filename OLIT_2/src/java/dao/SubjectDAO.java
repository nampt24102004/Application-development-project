package dao;

import dal.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import model.Subject;

public class SubjectDAO {

    // Lấy tất cả Subject đã publish (Status = 1)
    public List<Subject> getAllPublishedSubjects() {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT s.SubjectID, s.SubjectName, s.Category, s.OwnerId, a.FullName AS OwnerName, s.Status, "
                + "COUNT(l.LessonID) AS NumOfLessons "
                + "FROM Subject s "
                + "JOIN Account a ON s.OwnerId = a.UserID "
                + "LEFT JOIN Course c ON s.SubjectID = c.SubjectID "
                + "LEFT JOIN CourseSection cs ON c.CourseID = cs.CourseID "
                + "LEFT JOIN SectionModule sm ON cs.SectionID = sm.SectionID "
                + "LEFT JOIN Lesson l ON sm.ModuleID = l.ModuleID "
                + "WHERE s.Status = 1 "
                + "GROUP BY s.SubjectID, s.SubjectName, s.Category, s.OwnerId, a.FullName, s.Status "
                + "ORDER BY s.SubjectID";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getInstance().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectName(rs.getString("SubjectName"));
                s.setCategory(rs.getString("Category"));
                s.setOwnerId(rs.getInt("OwnerId"));
                s.setOwnerName(rs.getString("OwnerName"));
                s.setStatus(rs.getBoolean("Status"));
                s.setNumOfLessons(rs.getInt("NumOfLessons"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // Lấy danh sách Subject theo filter
    public List<Subject> getAllSubjects(String search, String category, String status) {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT s.SubjectID, s.SubjectName, s.Category, s.OwnerId, a.FullName AS OwnerName, s.Status, "
                + "COUNT(l.LessonID) AS NumOfLessons "
                + "FROM Subject s "
                + "JOIN Account a ON s.OwnerId = a.UserID "
                + "LEFT JOIN Course c ON s.SubjectID = c.SubjectID "
                + "LEFT JOIN CourseSection cs ON c.CourseID = cs.CourseID "
                + "LEFT JOIN SectionModule sm ON cs.SectionID = sm.SectionID "
                + "LEFT JOIN Lesson l ON sm.ModuleID = l.ModuleID "
                + "WHERE 1=1 ";
        List<Object> params = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            sql += "AND s.SubjectName LIKE ? ";
            params.add("%" + search + "%");
        }
        if (category != null && !category.isEmpty()) {
            sql += "AND s.Category = ? ";
            params.add(category);
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.Status = ? ";
            if ("1".equals(status) || "true".equalsIgnoreCase(status)) {
                params.add(1);
            } else if ("0".equals(status) || "false".equalsIgnoreCase(status)) {
                params.add(0);
            } else {
                params.add(status);
            }
        }

        sql += "GROUP BY s.SubjectID, s.SubjectName, s.Category, s.OwnerId, a.FullName, s.Status ";
        sql += "ORDER BY s.SubjectID";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectName(rs.getString("SubjectName"));
                s.setCategory(rs.getString("Category"));

                s.setOwnerId(rs.getInt("OwnerId"));

                s.setOwnerName(rs.getString("OwnerName"));
                s.setStatus(rs.getBoolean("Status"));
                s.setNumOfLessons(rs.getInt("NumOfLessons"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy tất cả các Category (phục vụ filter)
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT Category FROM Subject";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getInstance().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM Subject WHERE Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getInstance().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectName(rs.getString("SubjectName"));
                s.setCategory(rs.getString("Category"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    // SubjectDAO.java

    public List<Subject> getSubjectsByExpertId(int expertId, String search, String category, String status) {
        List<Subject> list = new ArrayList<>();

        String sql = "SELECT s.SubjectID, s.SubjectName, s.Category, s.OwnerId, s.Status, "
                + "COUNT(l.LessonID) AS NumOfLessons, a.FullName AS OwnerName "
                + "FROM Subject s "
                + "JOIN ExpertSubject es ON s.SubjectID = es.SubjectID "
                + // Bảng này lưu assign
                "JOIN Account a ON s.OwnerId = a.UserID "
                + "LEFT JOIN Course c ON s.SubjectID = c.SubjectID "
                + "LEFT JOIN CourseSection cs ON c.CourseID = cs.CourseID "
                + "LEFT JOIN SectionModule sm ON cs.SectionID = sm.SectionID "
                + "LEFT JOIN Lesson l ON sm.ModuleID = l.ModuleID "
                + "WHERE es.ExpertID = ? ";
        List<Object> params = new ArrayList<>();
        params.add(expertId);
        // Thêm search, category, status filter như cũ nếu cần
        if (search != null && !search.isEmpty()) {
            sql += " AND s.SubjectName LIKE ?";
            params.add("%" + search + "%");
        }
        if (category != null && !category.isEmpty()) {
            sql += " AND s.Category = ?";
            params.add(category);
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND s.Status = ?";
            params.add(Integer.parseInt(status));
        }

        sql += " GROUP BY s.SubjectID, s.SubjectName, s.Category, s.OwnerId, a.FullName, s.Status "
                + "ORDER BY s.SubjectID";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectName(rs.getString("SubjectName"));
                s.setCategory(rs.getString("Category"));

                s.setOwnerId(rs.getInt("OwnerId"));
                s.setNumOfLessons(rs.getInt("NumOfLessons"));
                s.setStatus(rs.getBoolean("Status"));
                s.setOwnerName(rs.getString("OwnerName"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertSubjectReturnId(String name, String category, int ownerId, boolean featuredFlag, boolean status,
            String Description) {
        String sql = "INSERT INTO Subject (SubjectName, Category, OwnerID, FeaturedFlag, Status,Description) VALUES (?, ?,?,?, ?,?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getInstance().getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setInt(3, ownerId);
            ps.setBoolean(4, featuredFlag);
            ps.setBoolean(5, status);
            ps.setString(6, Description);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    public static Subject getSubjectByID(int subjectID) {
        Subject subject = new Subject();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                    SELECT * FROM Subject WHERE SubjectID = ?
                    """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, subjectID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectName(rs.getString("SubjectName"));
                subject.setCategory(rs.getString("Category"));
                subject.setNumOfLessons(rs.getInt("NumOfLessons"));
                subject.setOwnerId(rs.getInt("OwnerId"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subject;
    }
    
    /** Trả về tổng số môn (dùng làm New Subjects luôn > tránh dùng createdDate) */
    public long countNewSubjects(java.time.LocalDateTime from, java.time.LocalDateTime to) {
        // Nếu bạn muốn khác biệt, có thể đặt newSubjects = 0
        return countAllSubjects();
    }

    /** Trả về tổng số môn */
    public long countAllSubjects() {
        String sql = "SELECT COUNT(*) FROM Subject";
        try (
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            return rs.next() ? rs.getLong(1) : 0;
        } catch (SQLException e) {
            throw new RuntimeException("DB error in countAllSubjects", e);
        }
    }

}
