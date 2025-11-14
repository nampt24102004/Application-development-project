package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SettingDAO {

    private Connection conn;

    public SettingDAO() {
        conn = DBContext.getInstance().getConnection();
    }

    public String getSettingValueByType(String settingType) {
        String sql = "SELECT SettingValue FROM Setting WHERE SettingType = ? AND SettingStatus = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, settingType);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("SettingValue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static void main(String[] args) {
        System.out.println(new SettingDAO().getSettingValueByType("Email"));
    }
}

    
