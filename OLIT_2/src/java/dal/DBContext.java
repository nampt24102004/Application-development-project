/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Long0
 */
public class DBContext {

    private static DBContext instance = new DBContext();//singleton pattern
    protected Connection connection;
    String err;

    public static DBContext getInstance() {
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }

    public DBContext() {
        try {
            if (connection == null || connection.isClosed()) {
                String user = "sa";
                String password = "123";
                String url = "jdbc:sqlserver://localhost:1433;databaseName=OLIT;TrustServerCertificate=true";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, user, password);
            }
        } catch (Exception e) {
            err = e.getMessage();
            connection = null;
        }
    }

    public String getErr() {
        return this.err;
    }

//    public static void main(String[] args) {
//        DBContext db = DBContext.getInstance();
//        Connection conn = db.getConnection();
//        if (conn != null) {
//            System.out.println("Kết nối cơ sở dữ liệu thành công!");
//            try {
//                System.out.println("Database Name: " + conn.getCatalog());
//                conn.close(); // Đóng kết nối sau khi kiểm tra
//            } catch (Exception e) {
//                System.out.println("Lỗi khi lấy thông tin cơ sở dữ liệu: " + e.getMessage());
//            }
//        } else {
//            System.out.println("Kết nối cơ sở dữ liệu thất bại! Lỗi: " + db.getErr());
//        }
//    }
}
