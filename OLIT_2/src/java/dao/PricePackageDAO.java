package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class PricePackageDAO extends DBContext {

    public PricePackage getPackageById(int packageId) {
        String sql = "SELECT * FROM PricePackage WHERE PackageID = ?";
        PricePackage pkg = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, packageId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pkg = new PricePackage();
                    pkg.setPackageID(rs.getInt("PackageID"));
                    pkg.setCourseID(rs.getInt("CourseID"));
                    pkg.setName(rs.getString("Name"));
                    pkg.setAccessDuration(rs.getInt("AccessDuration"));
                    pkg.setListPrice(rs.getInt("ListPrice"));
                    pkg.setSalePrice(rs.getInt("SalePrice"));
                    pkg.setStatus(rs.getInt("Status"));
                    pkg.setDescription(rs.getString("Description"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pkg;
    }

    public PricePackage getLowestActivePackageByCourseId(int courseId) {
        String sql = "SELECT TOP 1 * FROM PricePackage WHERE CourseID = ? AND Status = 1 ORDER BY SalePrice ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PricePackage(
                        rs.getInt("PackageID"),
                        rs.getInt("CourseID"),
                        rs.getString("Name"),
                        rs.getInt("AccessDuration"),
                        rs.getInt("ListPrice"),
                        rs.getInt("SalePrice"),
                        rs.getInt("Status"),
                        rs.getString("Description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PricePackage> getPricePackagesByCourseId(int courseId) {
        List<PricePackage> list = new ArrayList<>();
        String sql = "SELECT * FROM PricePackage WHERE CourseID = ? AND Status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PricePackage p = new PricePackage();
                    p.setPackageID(rs.getInt("PackageID"));
                    p.setCourseID(rs.getInt("CourseID"));
                    p.setName(rs.getString("Name"));
                    p.setAccessDuration(rs.getInt("AccessDuration"));
                    p.setListPrice(rs.getInt("ListPrice"));
                    p.setSalePrice(rs.getInt("SalePrice"));
                    p.setStatus(rs.getInt("Status"));
                    p.setDescription(rs.getString("Description"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public PricePackage getActivePackageByCourseId(int courseId) {
        String sql = "SELECT TOP 1 * FROM PricePackage WHERE CourseID = ? AND Status = 1 ORDER BY SalePrice ASC";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PricePackage(
                        rs.getInt("PackageID"),
                        rs.getInt("CourseID"),
                        rs.getString("Name"),
                        rs.getInt("AccessDuration"),
                        rs.getInt("ListPrice"),
                        rs.getInt("SalePrice"),
                        rs.getInt("Status"),
                        rs.getString("Description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PricePackage> getAllPricePackages() {
        List<PricePackage> list = new ArrayList<>();
        String sql = "SELECT * FROM PricePackage WHERE Status = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PricePackage p = new PricePackage();
                p.setPackageID(rs.getInt("PackageID"));
                p.setCourseID(rs.getInt("CourseID"));
                p.setName(rs.getString("Name"));
                p.setAccessDuration(rs.getInt("AccessDuration"));
                p.setListPrice(rs.getInt("ListPrice"));
                p.setSalePrice(rs.getInt("SalePrice"));
                p.setStatus(rs.getInt("Status"));
                p.setDescription(rs.getString("Description"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PricePackage> getTop5PricePackages() {
        List<PricePackage> list = new ArrayList<>();
        String sql = "SELECT * FROM PricePackage WHERE PackageID BETWEEN 1 AND 5 AND Status = 1 ORDER BY PackageID ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PricePackage p = new PricePackage();
                p.setPackageID(rs.getInt("PackageID"));
                p.setCourseID(rs.getInt("CourseID"));
                p.setName(rs.getString("Name"));
                p.setAccessDuration(rs.getInt("AccessDuration"));
                p.setListPrice(rs.getInt("ListPrice"));
                p.setSalePrice(rs.getInt("SalePrice"));
                p.setStatus(rs.getInt("Status"));
                p.setDescription(rs.getString("Description"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
