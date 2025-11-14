/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Registration;
import dao.CourseDAO;
import model.Course;
import dao.PricePackageDAO;
import model.PricePackage;
import dao.AccountDAO;
import model.Account;

/**
 *
 * @author macbook
 */
@WebServlet("/MyRegistration")
public class MyRegistration extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userID = (int) session.getAttribute("userID");
        RegistrationDAO dao = new RegistrationDAO();
        // Lấy page từ URL, mặc định là 1
        int page = 1;
        int recordsPerPage = 6;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * recordsPerPage;
        // Lấy toàn bộ danh sách đăng ký
        List<Registration> allRegistrations = dao.getRegistrationsByUserID(userID);
        // Sắp xếp: Pending lên đầu, sau đó theo RegistrationID giảm dần
        allRegistrations.sort((r1, r2) -> {
            boolean isPending1 = "Pending".equalsIgnoreCase(r1.getStatus());
            boolean isPending2 = "Pending".equalsIgnoreCase(r2.getStatus());
            if (isPending1 && !isPending2) return -1;
            if (!isPending1 && isPending2) return 1;
            return Integer.compare(r2.getRegistrationID(), r1.getRegistrationID());
        });
        // Phân trang thủ công
        int totalRecords = allRegistrations.size();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        int fromIndex = Math.min(offset, totalRecords);
        int toIndex = Math.min(offset + recordsPerPage, totalRecords);
        List<Registration> registrations = allRegistrations.subList(fromIndex, toIndex);
        // Lấy danh sách khoá học
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getCourses();
        // Lấy toàn bộ package
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        List<PricePackage> allPackages = pricePackageDAO.getAllPricePackages();
        // Lấy thông tin tài khoản user
        Account account = AccountDAO.getAccountByID(userID);
        request.setAttribute("registrations", registrations);
        request.setAttribute("currentPage", Integer.valueOf(page));
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("courses", courses);
        request.setAttribute("allPackages", allPackages);
        request.setAttribute("account", account);
        request.getRequestDispatcher("userPages/myRegistration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            String regIdStr = request.getParameter("registrationID");
            if (regIdStr != null) {
                try {
                    int regId = Integer.parseInt(regIdStr);
                    RegistrationDAO dao = new RegistrationDAO();
                    dao.deleteRegistrationById(regId);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("MyRegistration");
            return;
        }
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userID = (int) session.getAttribute("userID");
        RegistrationDAO dao = new RegistrationDAO();
        // Lấy page từ URL, mặc định là 1
        int page = 1;
        int recordsPerPage = 6;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * recordsPerPage;
        // Lấy danh sách đăng ký có phân trang
        List<Registration> registrations = dao.getRegistrationsByUserIDWithPaging(userID, offset, recordsPerPage);
        int totalRecords = dao.countRegistrationsByUserID(userID);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        // Lấy danh sách khoá học
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getCourses();
        // Lấy toàn bộ package
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        List<PricePackage> allPackages = pricePackageDAO.getAllPricePackages();
        // Lấy thông tin tài khoản user
        Account account = AccountDAO.getAccountByID(userID);
        request.setAttribute("registrations", registrations);
        request.setAttribute("currentPage", Integer.valueOf(page));
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("courses", courses);
        request.setAttribute("allPackages", allPackages);
        request.setAttribute("account", account);
        request.getRequestDispatcher("userPages/myRegistration.jsp").forward(request, response);
    }
}
