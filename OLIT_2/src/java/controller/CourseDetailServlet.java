/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.*;
import java.util.List;
import model.*;

/**
 *
 * @author macbook
 */
@WebServlet("/CourseDetail")
public class CourseDetailServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet CourseDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseDetailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseIdParam = request.getParameter("id");
        if (courseIdParam == null || courseIdParam.isEmpty()) {
            response.sendRedirect("CourseList");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdParam);

            CourseDAO courseDAO = new CourseDAO();
            PricePackageDAO priceDAO = new PricePackageDAO();
            SubjectDAO subjectDAO = new SubjectDAO();

            // 1. Lấy thông tin khoá học
            Course course = courseDAO.getCourseById(courseId);
            if (course == null) {
                request.setAttribute("message", "Khoá học không tồn tại.");
                request.setAttribute("messageType", "danger");
                return;
            }

            // 2. Lấy gói có giá rẻ nhất (status = 1)
            PricePackage lowestPackage = priceDAO.getLowestActivePackageByCourseId(courseId);

            // 3. Lấy tất cả danh mục
            List<Subject> allSubjects = subjectDAO.getAllSubjects(null, null, null);  // không filter
            List<String> allCategories = subjectDAO.getAllCategories();
            // 4. Lấy khoá học nổi bật
            List<Course> featuredCourses = courseDAO.getHotCourses();

            // lấy list media 
            List<CourseMedia> mediaList = courseDAO.getAllMediaByCourseId(courseId);
            request.setAttribute("mediaList", mediaList);
            System.out.println(mediaList.size());
            // 5. Set attribute và forward

            // lấy list reivews 
            ReviewDAO reviewDAO = new ReviewDAO();
            List<Review> reviews = reviewDAO.getReviewsByCourseId(courseId);
            request.setAttribute("reviews", reviews);
            request.setAttribute("course", course);
            request.setAttribute("lowestPackage", lowestPackage);
            request.setAttribute("subjects", allSubjects);
            request.setAttribute("categories", allCategories);
            request.setAttribute("featuredSubjects", featuredCourses);
            System.out.println(course);
            request.getRequestDispatcher("/userPages/courseDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("CourseList");
        }
    }
}
