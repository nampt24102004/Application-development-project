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

public class LessonDAO {

    public List<Lesson> getLessonsByModuleId(int moduleId) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM Lesson WHERE ModuleID = ? ORDER BY [Order]";

        try {
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, moduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("LessonID"));
                lesson.setModuleID(rs.getInt("ModuleID"));
                lesson.setLessonTitle(rs.getString("LessonTitle"));
                lesson.setLessonDetail(rs.getString("LessonDetails"));
                lesson.setStatus(rs.getBoolean("Status"));
                lesson.setURLLesson(rs.getString("URLLesson"));
                lesson.setOrder(rs.getInt("Order"));
                list.add(lesson);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Lesson getFirstLessonByCourseId(int courseId) {
        String sql = "SELECT TOP 1 l.* FROM Lesson l "
                + "JOIN SectionModule sm ON l.ModuleID = sm.ModuleID "
                + "JOIN CourseSection cs ON sm.SectionID = cs.SectionID "
                + "WHERE cs.CourseID = ? "
                + "ORDER BY cs.SectionID, sm.ModuleID, l.[Order]";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLessonID(rs.getInt("LessonID"));
                    lesson.setModuleID(rs.getInt("ModuleID"));
                    lesson.setLessonTitle(rs.getString("LessonTitle"));
                    lesson.setLessonDetail(rs.getString("LessonDetails"));
                    lesson.setStatus(rs.getBoolean("Status"));
                    lesson.setURLLesson(rs.getString("URLLesson"));
                    lesson.setOrder(rs.getInt("Order"));
                    return lesson;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Lesson getLessonByID(int lessonID) {
        Lesson lesson = null;
        String sql = """
                         SELECT * FROM LESSON WHERE LessonID = ? ORDER BY [Order]
                         """;
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, lessonID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lesson = new Lesson(
                            rs.getInt("LessonID"),
                            rs.getInt("ModuleID"),
                            rs.getString("LessonTitle"),
                            rs.getString("LessonDetails"),
                            rs.getBoolean("Status"),
                            rs.getString("URLLesson"),
                            rs.getInt("Order")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lesson;
    }

    public static List<Lesson> getAllLesson() {
        String sql = """
                         SELECT * FROM LESSON ORDER BY [Order]
                         """;
        List<Lesson> lessons = new ArrayList<Lesson>();
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson(
                            rs.getInt("LessonID"),
                            rs.getInt("ModuleID"),
                            rs.getString("LessonTitle"),
                            rs.getString("LessonDetails"),
                            rs.getBoolean("Status"),
                            rs.getString("URLLesson"),
                            rs.getInt("Order")
                    );
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }
    
}
