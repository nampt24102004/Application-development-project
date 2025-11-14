/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.RegistrationDAO;
import dao.CourseDAO;
import model.Course;
import model.Registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author macbook
 */
@WebServlet("/MyCourseServlet")
public class MyCourseServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userID = (int) session.getAttribute("userID");

        RegistrationDAO regDao = new RegistrationDAO();
        CourseDAO courseDao = new CourseDAO();

        List<Registration> registrations = regDao.getApprovedRegistrationsByUserID(userID);
        List<Course> myCourses = new ArrayList<>();

        for (Registration reg : registrations) {
            Course course = courseDao.getCourseById(reg.getCourseID());
            if (course != null) {
                myCourses.add(course);
            }
        }

        request.setAttribute("myCourses", myCourses);
        request.getRequestDispatcher("userPages/myCourses.jsp").forward(request, response);
    }
}
