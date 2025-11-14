/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PricePackageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.PricePackage;
import dao.CourseDAO;
import model.Course;

/**
 *
 * @author Admin
 */
@WebServlet("/CourseRegisterServlet")
public class CourseRegisterServlet extends HttpServlet {
    private PricePackageDAO pricePackageDAO;
    private CourseDAO courseDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        pricePackageDAO = new PricePackageDAO();
        courseDAO = new CourseDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CourseRegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseRegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get courseId from request parameter
        String courseIdStr = request.getParameter("courseID");
        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdStr);
                List<PricePackage> pricePackages = pricePackageDAO.getPricePackagesByCourseId(courseId);
                
                // Set the pricePackages as request attribute
                request.setAttribute("pricePackages", pricePackages);
                // Lấy tên khóa học
                Course course = courseDAO.getCourseById(courseId);
                if (course != null) {
                    request.setAttribute("courseName", course.getCourseTitle());
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else {
            // Nếu không có courseID, truyền danh sách khoá học để chọn
            List<Course> courses = CourseDAO.getCourses();
            request.setAttribute("courses", courses);
        }
        
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("fullAccount");

        // Lấy courseID từ request (truyền từ CourseDetail.jsp)
        String courseID = request.getParameter("courseID");
        request.setAttribute("courseID", courseID);

        if (user != null) {
            // Đã đăng nhập: tự động điền thông tin user
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("mobile", user.getPhoneNumber());
            request.setAttribute("gender", user.getGender());
        }

        // Hiển thị trang popup đăng ký khóa học (điền sẵn nếu đã login)
        request.getRequestDispatcher("/userPages/registerCourse.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseID = request.getParameter("courseID");
        String packageName = request.getParameter("pricePackage");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        
        // Lấy userID nếu đã đăng nhập
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
