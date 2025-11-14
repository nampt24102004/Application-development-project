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

public class CourseSectionDAO {
    
    
    public List<CourseSection> getSectionsByCourseId(int courseId) {
        List<CourseSection> list = new ArrayList<>();
        String sql = "SELECT * FROM CourseSection WHERE CourseID = ?";

        try {
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseSection section = new CourseSection();
                section.setSectionID(rs.getInt("SectionID"));
                section.setCourseID(rs.getInt("CourseID"));
                section.setSectionTitle(rs.getString("SectionTitle"));
                list.add(section);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
