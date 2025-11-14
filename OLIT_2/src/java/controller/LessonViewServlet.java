
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
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import model.*;

/**
 *
 * @author macbook
 */
@WebServlet("/LessonView")
public class LessonViewServlet extends HttpServlet {

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
            out.println("<title>Servlet LessonViewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LessonViewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        int courseId = Integer.parseInt(request.getParameter("id"));

        CourseSectionDAO sectionDAO = new CourseSectionDAO();
        SectionModelDAO moduleDAO = new SectionModelDAO();
        LessonDAO lessonDAO = new LessonDAO();
        CourseDAO courseDAO = new CourseDAO();
        QuizDAO quizDAO = new QuizDAO();
        LessonProgressDAO lpDAO = new LessonProgressDAO();
        int userId = ((Integer) request.getSession().getAttribute("userID"));
        // trong service hoặc servlet

        

        List<CourseSection> sectionList = sectionDAO.getSectionsByCourseId(courseId);
        for (CourseSection section : sectionList) {
            List<SectionModule> modules = moduleDAO.getModulesBySectionId(section.getSectionID());
            for (SectionModule module : modules) {
                List<Lesson> lessons = lessonDAO.getLessonsByModuleId(module.getModuleID());
                module.setLessons(lessons);
            }
            section.setModules(modules);

            // Gắn quiz vào từng section
            Quiz quiz = quizDAO.getQuizBySectionId(section.getSectionID());
            section.setQuiz(quiz);
        }

        Course course = courseDAO.getCourseById(courseId);
        int totalLessons = sectionList.stream()
                .flatMap(s -> s.getModules().stream())
                .mapToInt(m -> m.getLessons().size())
                .sum();

// Số bài đã hoàn thành
        int completed;
        try {
            completed = lpDAO.countCompletedInCourse(userId, courseId);
            request.setAttribute("totalLessons", totalLessons);
            request.setAttribute("completedCount", completed);   // ← đã được dùng trong JSP
        } catch (Exception ex) {
            Logger.getLogger(LessonViewServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        Set<Integer> completedLessonSet = new HashSet<>(new LessonProgressDAO().getCompletedLessonIds(userId));
        request.setAttribute("completedLessonSet", completedLessonSet);

        request.setAttribute("course", course);
        request.setAttribute("sectionList", sectionList);
        request.getRequestDispatcher("/userPages/lessonView.jsp").forward(request, response);
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
