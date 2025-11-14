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

public class SectionModelDAO {
    public List<SectionModule> getModulesBySectionId(int sectionId) {
        List<SectionModule> list = new ArrayList<>();
            String sql = "SELECT * FROM SectionModule WHERE SectionID = ?";

        try {
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, sectionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SectionModule module = new SectionModule();
                module.setModuleID(rs.getInt("ModuleID"));
                module.setSectionID(rs.getInt("SectionID"));
                module.setModuleTitle(rs.getString("ModuleTitle"));
                list.add(module);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
