/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Role;

/**
 *
 * @author Long0
 */
public class RoleDAO {

    public static ArrayList<Role> getRoles() {
        DBContext db = DBContext.getInstance();
        ArrayList<Role> roles = new ArrayList<>();
        try {
            String sql = """
                     Select 
                         RoleID,
                         RoleName
                         FROM Role
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Role role = new Role(
                        rs.getInt("RoleID"),
                        rs.getString("RoleName")
                );
                roles.add(role);
            }
        } catch (Exception e) {
            return null;
        }
        return roles;
    }
}
