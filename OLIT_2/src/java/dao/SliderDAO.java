/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt để thay đổi giấy phép
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java để chỉnh sửa mẫu này
 */
package dao;

import dal.DBContext;
import model.Slider;
import java.sql.*;
import java.util.*;

public class SliderDAO extends DBContext {

    public List<Slider> getSlider() {
        List<Slider> listSlider = new ArrayList<>();
        String sql = "SELECT * FROM Slider";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("SliderID"));
                slider.setTitle(rs.getString("Title"));
                slider.setImageUrl(rs.getString("ImageURL")); // Sửa lỗi tên cột
                slider.setBackLink(rs.getString("Backlink"));
                slider.setStatus(rs.getInt("Status"));
                slider.setNotes(rs.getString("Notes"));
                slider.setDisplayOrder(rs.getInt("DisplayOrder"));
                slider.setValidFrom(rs.getDate("ValidFrom"));

                listSlider.add(slider);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listSlider;
    }
    
    public List<Slider> getSliderByCourseID(int courseID) {
        List<Slider> listSlider = new ArrayList<>();
        String sql = "SELECT * FROM Slider Where CourseID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Slider slider = new Slider();
                slider.setCourseID(courseID);
                slider.setSliderId(rs.getInt("SliderID"));
                slider.setTitle(rs.getString("Title"));
                slider.setImageUrl(rs.getString("ImageURL"));
                slider.setBackLink(rs.getString("Backlink"));
                slider.setStatus(rs.getInt("Status"));
                slider.setNotes(rs.getString("Notes"));
                slider.setDisplayOrder(rs.getInt("DisplayOrder"));
                slider.setValidFrom(rs.getDate("ValidFrom"));

                listSlider.add(slider);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listSlider;
    }

    public static void main(String[] args) {
        SliderDAO s = new SliderDAO();
        List<Slider> ss = s.getSlider();
        for (Slider slider : ss) { // Sử dụng đúng biến lặp
            System.out.println(slider);
        }
    }
}