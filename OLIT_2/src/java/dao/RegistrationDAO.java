package dao;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dal.DBContext;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import model.DashboardStatsDTO.TrendPoint;

public class RegistrationDAO extends DBContext {

    public boolean registerCourse(Registration registration) {
        // Tìm ID trống trước
        int availableId = findAvailableRegistrationId();
        if (availableId == -1) {
            return false; // Không tìm thấy ID trống
        }

        String sql = "INSERT INTO Registration (RegistrationID, UserID, CourseID, PackageID, Status, ValidFrom, ValidTo) "
                + "VALUES (?, ?, ?, ?, 'Pending', GETDATE(), DATEADD(MONTH, ?, GETDATE()))";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, availableId);
            ps.setInt(2, registration.getUserID());
            ps.setInt(3, registration.getCourseID());
            ps.setInt(4, registration.getPackageID());

            PricePackage pkg = new PricePackageDAO().getPackageById(registration.getPackageID());
            ps.setInt(5, pkg.getAccessDuration());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private int findAvailableRegistrationId() {
        String sql = "SELECT TOP 1 t1.RegistrationID + 1 "
                + "FROM Registration t1 "
                + "WHERE NOT EXISTS (SELECT 1 FROM Registration t2 WHERE t2.RegistrationID = t1.RegistrationID + 1) "
                + "UNION "
                + "SELECT 1 WHERE NOT EXISTS (SELECT 1 FROM Registration WHERE RegistrationID = 1) "
                + "ORDER BY 1";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Registration> getRegistrationsByUserID(int userID) {
        Connection conn = DBContext.getInstance().getConnection();
        List<Registration> list = new ArrayList<>();

        String sql = "SELECT r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, "
                + "r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseTitle, "
                + "pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "WHERE r.UserID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));

                Course course = new Course();
                course.setCourseTitle(rs.getString("courseTitle"));
                r.setCourse(course);

                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Registration> getRegistrationsByUserIDWithPaging(int userID, int offset, int limit) {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseID AS CourseID, c.CourseTitle, "
                + "p.PackageID AS PackageID, p.CourseID AS PackageCourseID, p.Name AS PackageName, p.AccessDuration, p.ListPrice, p.SalePrice, p.Status AS PackageStatus, p.Description "
                + "FROM Registration r "
                + "LEFT JOIN Course c ON r.CourseID = c.CourseID "
                + "LEFT JOIN PricePackage p ON r.PackageID = p.PackageID "
                + "WHERE r.UserID = ? ORDER BY r.RegistrationID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, offset);
            ps.setInt(3, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom")); // Sửa nếu là Timestamp (xem bước 2)
                r.setValidTo(rs.getString("ValidTo"));     // Sửa nếu là Timestamp (xem bước 2)

                // Khởi tạo Course
                if (rs.getInt("CourseID") != 0) {
                    Course course = new Course();
                    course.setCourseID(rs.getInt("CourseID"));
                    course.setCourseTitle(rs.getString("CourseTitle"));
                    r.setCourse(course);
                }

                // Khởi tạo PricePackage
                if (rs.getInt("PackageID") != 0) {
                    PricePackage pricePackage = new PricePackage();
                    pricePackage.setPackageID(rs.getInt("PackageID"));
                    pricePackage.setCourseID(rs.getInt("PackageCourseID"));
                    pricePackage.setName(rs.getString("PackageName"));
                    pricePackage.setAccessDuration(rs.getInt("AccessDuration"));
                    pricePackage.setListPrice(rs.getInt("ListPrice"));
                    pricePackage.setSalePrice(rs.getInt("SalePrice"));
                    pricePackage.setStatus(rs.getInt("PackageStatus"));
                    pricePackage.setDescription(rs.getString("Description"));
                    r.setPricePackage(pricePackage);
                }

                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countRegistrationsByUserID(int userID) {
        String sql = "SELECT COUNT(*) FROM Registration WHERE UserID = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Registration> getAllRegistrationsForAdmin() {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, "
                + "r.Status, r.ValidFrom, r.ValidTo, "
                + "a.FullName, a.Email, a.PhoneNumber, "
                + "c.CourseTitle, "
                + "pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Account a ON r.UserID = a.UserID "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "ORDER BY r.RegistrationID DESC";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));

                // Tạo Course object
                Course course = new Course();
                course.setCourseID(rs.getInt("CourseID"));
                course.setCourseTitle(rs.getString("CourseTitle"));
                r.setCourse(course);

                // Tạo PricePackage object
                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);

                // Lưu thông tin người dùng trực tiếp vào Registration
                r.setUserFullName(rs.getString("FullName"));
                r.setUserEmail(rs.getString("Email"));
                r.setUserPhone(rs.getString("PhoneNumber"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteRegistrationById(int registrationId) {
        String sql = "DELETE FROM Registration WHERE RegistrationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRegistrationStatus(int registrationId, String status) {
        String sql = "UPDATE Registration SET Status = ? WHERE RegistrationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, registrationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Registration> getApprovedRegistrationsByUserID(int userID) {
        Connection conn = DBContext.getInstance().getConnection();
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, "
                + "r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseTitle, "
                + "pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "WHERE r.UserID = ? AND r.Status = 'Approved'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));
                Course course = new Course();
                course.setCourseTitle(rs.getString("courseTitle"));
                r.setCourse(course);
                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Registration getLatestRegistrationByUserAndCourse(int userID, int courseID) {
        String sql = "SELECT TOP 1 r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseTitle, pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "WHERE r.UserID = ? AND r.CourseID = ? "
                + "ORDER BY r.RegistrationID DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));
                Course course = new Course();
                course.setCourseTitle(rs.getString("CourseTitle"));
                r.setCourse(course);
                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Registration getRegistrationById(int registrationId) {
        String sql = "SELECT r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseTitle, pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "WHERE r.RegistrationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));
                Course course = new Course();
                course.setCourseTitle(rs.getString("CourseTitle"));
                r.setCourse(course);
                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Registration getLatestRegistrationByUser(int userID) {
        String sql = "SELECT TOP 1 r.RegistrationID, r.UserID, r.CourseID, r.PackageID, r.ApprovedBy, r.Status, r.ValidFrom, r.ValidTo, "
                + "c.CourseTitle, pp.Name AS PackageName, pp.SalePrice "
                + "FROM Registration r "
                + "JOIN Course c ON r.CourseID = c.courseID "
                + "JOIN PricePackage pp ON r.PackageID = pp.PackageID "
                + "WHERE r.UserID = ? "
                + "ORDER BY r.RegistrationID DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Registration r = new Registration();
                r.setRegistrationID(rs.getInt("RegistrationID"));
                r.setUserID(rs.getInt("UserID"));
                r.setCourseID(rs.getInt("CourseID"));
                r.setPackageID(rs.getInt("PackageID"));
                r.setApprovedBy(rs.getInt("ApprovedBy"));
                r.setStatus(rs.getString("Status"));
                r.setValidFrom(rs.getString("ValidFrom"));
                r.setValidTo(rs.getString("ValidTo"));
                Course course = new Course();
                course.setCourseTitle(rs.getString("CourseTitle"));
                r.setCourse(course);
                PricePackage pp = new PricePackage();
                pp.setName(rs.getString("PackageName"));
                pp.setSalePrice(rs.getInt("SalePrice"));
                r.setPricePackage(pp);
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public long countByStatus(String status, LocalDateTime from, LocalDateTime to) {
        String sql = """
            SELECT COUNT(*) 
              FROM Registration 
             WHERE Status = ? 
               AND ValidFrom BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = DBContext.getInstance()
                                             .getConnection()
                                             .prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setObject(2, from);
            ps.setObject(3, to);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getLong(1) : 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("DB error in countByStatus", e);
        }
    }

    // Tổng doanh thu dựa trên ValidFrom
    public BigDecimal totalRevenue(LocalDateTime from, LocalDateTime to) {
        String sql = """
            SELECT COALESCE(SUM(pp.SalePrice),0)
              FROM Registration r
              JOIN PricePackage pp ON r.PackageID = pp.PackageID
             WHERE r.Status = 'Approved'
               AND r.ValidFrom BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = DBContext.getInstance()
                                             .getConnection()
                                             .prepareStatement(sql)) {
            ps.setObject(1, from);
            ps.setObject(2, to);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            throw new RuntimeException("DB error in totalRevenue", e);
        }
    }

    // Xu hướng đơn hàng theo ngày ValidFrom
    public List<TrendPoint> findOrderTrend(LocalDateTime from, LocalDateTime to) {
    Map<LocalDate, TrendPoint> trendMap = new LinkedHashMap<>();

    // B1: Tạo 7 ngày mặc định với total = 0, success = 0
    LocalDate current = from.toLocalDate();
    LocalDate endDate = to.toLocalDate();
    while (!current.isAfter(endDate)) {
        trendMap.put(current, new TrendPoint(current, 0, 0));
        current = current.plusDays(1);
    }

    // B2: Lấy dữ liệu thực tế từ DB
    String sql = """
        SELECT CAST(ValidFrom AS date) AS d,
               COUNT(*) AS total,
               SUM(CASE WHEN Status = 'Approved' THEN 1 ELSE 0 END) AS success
        FROM Registration
        WHERE ValidFrom BETWEEN ? AND ?
        GROUP BY CAST(ValidFrom AS date)
    """;

    try (PreparedStatement ps = DBContext.getInstance()
                                         .getConnection()
                                         .prepareStatement(sql)) {
        ps.setObject(1, from);
        ps.setObject(2, to);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LocalDate date = rs.getDate("d").toLocalDate();
                long total = rs.getLong("total");
                long success = rs.getLong("success");

                // Ghi đè dữ liệu ngày có thực trong DB
                trendMap.put(date, new TrendPoint(date, total, success));
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("DB error in findOrderTrend", e);
    }

    return new ArrayList<>(trendMap.values());
}


    // Doanh thu theo chuyên mục dựa trên ValidFrom
    public Map<String, BigDecimal> revenueByCategory(LocalDateTime from, LocalDateTime to) {
        String sql = """
            SELECT s.Category, COALESCE(SUM(pp.SalePrice),0) AS rev
              FROM Registration r
              JOIN PricePackage pp ON r.PackageID = pp.PackageID
              JOIN Course c ON pp.CourseID = c.CourseID
              JOIN Subject s ON c.SubjectID = s.SubjectID
             WHERE r.Status = 'Approved'
               AND r.ValidFrom BETWEEN ? AND ?
             GROUP BY s.Category
        """;
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        try (PreparedStatement ps = DBContext.getInstance()
                                             .getConnection()
                                             .prepareStatement(sql)) {
            ps.setObject(1, from);
            ps.setObject(2, to);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("Category"), rs.getBigDecimal("rev"));
                }
            }
            return map;
        } catch (SQLException e) {
            throw new RuntimeException("DB error in revenueByCategory", e);
        }
    }

}
