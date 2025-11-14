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
import model.PostCategory;

/**
 *
 * @author khain
 */
public class PostCategoryDAO  extends DBContext {
  public List<PostCategory> findAll() {
    List<PostCategory> cats = new ArrayList<>();
    String sql = "SELECT CategoryID, CategoryName, URL FROM PostCategory";
    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
      while (rs.next()) {
        PostCategory c = new PostCategory();
        c.setCategoryID(rs.getInt("CategoryID"));
        c.setCategoryName(rs.getString("CategoryName"));
        c.setURL(rs.getString("URL"));
        cats.add(c);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return cats;
  }
}
