package dao;

import java.sql.*;
import java.util.*;
import model.Review;
import dal.DBContext;

public class ReviewDAO extends DBContext {

    public List<Review> getReviewsByCourseId(int courseId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.FullName FROM Review r JOIN [Account] u ON r.UserID = u.UserID "
                + "WHERE r.CourseID = ? AND r.Status = 1 ORDER BY r.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setUserID(rs.getInt("UserID"));
                    review.setCourseID(rs.getInt("CourseID"));
                    review.setContent(rs.getString("Content"));
                    review.setStar(rs.getInt("Star"));
                    review.setCreatedAt(rs.getDate("CreatedAt"));
                    review.setStatus(rs.getBoolean("Status"));
                    review.setImageURL(rs.getString("ImageURL"));
                    review.setUserFullName(rs.getString("FullName"));

                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public void insertReview(Review review) {
        String sql = "INSERT INTO Review (ReviewID, UserID, CourseID, Content, Star, CreatedAt, Status, ImageURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, getNextReviewID());
            ps.setInt(2, review.getUserID());
            ps.setInt(3, review.getCourseID());
            ps.setString(4, review.getContent());
            ps.setInt(5, review.getStar());
            ps.setTimestamp(6, new java.sql.Timestamp(review.getCreatedAt().getTime()));
            ps.setBoolean(7, review.isStatus());
            ps.setString(8, review.getImageURL());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int getNextReviewID() {
        String sql = "SELECT ISNULL(MAX(ReviewID), 0) + 1 FROM Review";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }
}
