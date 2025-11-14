package controller;

import dao.RegistrationDAO;
import model.Registration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Comparator;

@WebServlet(name = "ManageStudentCourseServlet", urlPatterns = {"/ManageStudentCourseServlet"})
public class ManageStudentCourseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer roleID = (Integer) session.getAttribute("roleID");
        if (roleID == null || (roleID != 1 && roleID != 2)) { // 1: Admin, 2: Expert
            response.sendRedirect(request.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }
        RegistrationDAO registrationDAO = new RegistrationDAO();
        List<Registration> registrationList = registrationDAO.getAllRegistrationsForAdmin();
        // Lọc chỉ lấy các đăng ký đã được duyệt và sắp xếp theo ID tăng dần
        List<Registration> approvedList = registrationList.stream()
            .filter(r -> "Approved".equalsIgnoreCase(r.getStatus()))
            .sorted(Comparator.comparingInt(Registration::getRegistrationID))
            .collect(Collectors.toList());
        request.setAttribute("registrationList", approvedList);
        request.getRequestDispatcher("/adminPages/manageStudentCourses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer roleID = (Integer) session.getAttribute("roleID");
        if (roleID == null || (roleID != 1 && roleID != 2)) {
            response.sendRedirect(request.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }
        String action = request.getParameter("action");
        if ("deleteRegistration".equals(action)) {
            String regIdStr = request.getParameter("registrationID");
            if (regIdStr != null) {
                try {
                    int regId = Integer.parseInt(regIdStr);
                    RegistrationDAO dao = new RegistrationDAO();
                    boolean deleted = dao.deleteRegistrationById(regId);
                    if (deleted) {
                        request.setAttribute("message", "Course deleted successfully!");
                    } else {
                        request.setAttribute("error", "Cannot delete course!");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid ID!");
                }
            } else {
                request.setAttribute("error", "Missing registration information!");
            }
        }
        doGet(request, response);
    }
} 