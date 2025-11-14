/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import dao.CourseDAO;
import dao.PricePackageDAO;
import dao.SubjectDAO;
import model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.PricePackage;
import model.Subject;
/**
 *
 * @author hocdo
 */@WebServlet("/CourseListServlet")
public class CourseListServlet extends HttpServlet {

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
            out.println("<title>Servlet CourseListServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        // Nhận filter từ request
        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String status = request.getParameter("status"); // default: 1
        String sort = request.getParameter("sort");
        String minQuantityStr = request.getParameter("minQuantity");
        String pageStr = request.getParameter("page");

        // Parse minQuantity thành số lượng khóa học hiển thị
        int pageSize = 6; // mặc định
        try {
            if (minQuantityStr != null && !minQuantityStr.isEmpty()) {
                int parsed = Integer.parseInt(minQuantityStr);
                if (parsed > 0 && parsed <= 6) {
                    pageSize = parsed;
                }
            }
        } catch (NumberFormatException e) {
            // ignore
        }

        // Parse số trang hiện tại
        int currentPage = 1;
        try {
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            // ignore
        }

        // DAO
        CourseDAO courseDAO = new CourseDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        PricePackageDAO priceDAO = new PricePackageDAO();

        // Lọc subject
        List<Subject> filteredSubjects = subjectDAO.getAllSubjects(search, category, status);

        // Lấy subjectId
        List<Integer> subjectIds = filteredSubjects.stream()
                .map(Subject::getSubjectID)
                .collect(Collectors.toList());

        // Lấy khoá học theo subjectId
        List<Course> allCourses = courseDAO.getCoursesBySubjectIds(subjectIds);

        // Danh mục & nổi bật
        List<String> allCategories = subjectDAO.getAllCategories();
        List<Course> featuredCourses = courseDAO.getHotCourses();

        // Lọc số lượng bài học (>= 0)
        List<Course> filteredCourses = allCourses.stream().filter(course -> {
            Subject subject = filteredSubjects.stream()
                    .filter(s -> s.getSubjectID() == course.getSubjectID())
                    .findFirst().orElse(null);
            return subject != null;
        }).collect(Collectors.toList());

        // Sắp xếp nếu có yêu cầu (theo giá sale)
        if ("asc".equalsIgnoreCase(sort) || "desc".equalsIgnoreCase(sort)) {
            Map<Integer, PricePackage> allPrices = new HashMap<>();
            for (Course c : filteredCourses) {
                PricePackage price = priceDAO.getActivePackageByCourseId(c.getCourseID());
                if (price != null) {
                    allPrices.put(c.getCourseID(), price);
                }
            }

            Comparator<Course> comparator = Comparator.comparingInt(c -> {
                PricePackage p = allPrices.get(c.getCourseID());
                return (p != null) ? p.getSalePrice() : Integer.MAX_VALUE;
            });

            if ("desc".equalsIgnoreCase(sort)) {
                comparator = comparator.reversed();
            }

            filteredCourses.sort(comparator);
        }

        // Phân trang
        int totalCourses = filteredCourses.size();
        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);
        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalCourses);

        List<Course> paginatedCourses = totalCourses > 0
                ? filteredCourses.subList(fromIndex, toIndex)
                : new ArrayList<>();

        // Map courseID → PricePackage (Status = 1)
        Map<Integer, PricePackage> coursePrices = new HashMap<>();
        for (Course c : paginatedCourses) {
            PricePackage price = priceDAO.getActivePackageByCourseId(c.getCourseID());
            if (price != null) {
                coursePrices.put(c.getCourseID(), price);
            }
        }

        // Truyền về JSP
        request.setAttribute("courses", paginatedCourses);
        request.setAttribute("categories", allCategories);
        request.setAttribute("featuredSubjects", featuredCourses);
        request.setAttribute("coursePrices", coursePrices);

        // Truyền lại filter
        request.setAttribute("search", search);
        request.setAttribute("category", category);
        request.setAttribute("status", status);
        request.setAttribute("sort", sort);
        request.setAttribute("minQuantity", pageSize);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/userPages/courseList.jsp").forward(request, response);
    }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
