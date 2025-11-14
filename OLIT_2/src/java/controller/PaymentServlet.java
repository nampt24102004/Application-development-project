package controller;

import dao.RegistrationDAO;
import model.Registration;
import dao.SubjectDAO;
import dao.CourseDAO;
import dao.SettingDAO;
import model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import util.EmailUtil;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // Lấy thông tin đăng ký cho phần thanh toán
        String regIdStr = request.getParameter("registrationID");
        Registration registration = null;
        if (regIdStr != null) {
            try {
                int regId = Integer.parseInt(regIdStr);
                registration = new RegistrationDAO().getRegistrationById(regId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        if (registration == null) {
            int userID = (int) session.getAttribute("userID");
            registration = new RegistrationDAO().getLatestRegistrationByUser(userID);
        }
        request.setAttribute("registration", registration);
        // Lấy dữ liệu sidebar giống courseList
        List<String> categories = new SubjectDAO().getAllCategories();
        List<Course> featuredCourses = new CourseDAO().getHotCourses();
        request.setAttribute("categories", categories);
        request.setAttribute("featuredCourses", featuredCourses);
        request.getRequestDispatcher("userPages/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String regIdStr = request.getParameter("registrationID");
        if (regIdStr != null) {
            try {
                int regId = Integer.parseInt(regIdStr);
                RegistrationDAO dao = new RegistrationDAO();
                // Đổi trạng thái sang 'Paid' thay vì 'Pending'
                dao.updateRegistrationStatus(regId, "Paid");
                String adminEmail = new SettingDAO().getSettingValueByType("Email");

                String baseURL = request.getRequestURL().toString()
                        .replace(request.getRequestURI(), request.getContextPath());

                String confirmLink = baseURL + "/AdminRegistrationListServlet";

                String mailSubject = "Confirm course payment";
                String mailContent = "There is a new payment request that needs confirmation. "
                        + "<a href=\"" + confirmLink + "\">Confirm registration</a>";

                EmailUtil.sendMail(adminEmail, mailSubject, mailContent);

                session.setAttribute("message", "Payment confirmed. Your registration is now marked as paid.");
                session.setAttribute("messageType", "success");
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid registration ID.");
                session.setAttribute("messageType", "error");
            }
        }
        response.sendRedirect("MyRegistration");
    }
}
