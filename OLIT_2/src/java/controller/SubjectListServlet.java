/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Subject;

/**
 *
 * @author khain
 */
@WebServlet(name = "SubjectListServlet", urlPatterns = {"/SubjectList"})
public class SubjectListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Account acc = null;
        if (session != null) {
            acc = (Account) session.getAttribute("fullAccount");
        }
        // Kiểm tra quyền truy cập
        if (acc == null || (acc.getRoleID() != 1 && acc.getRoleID() != 2)) {
            resp.sendRedirect(req.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }

        String search = req.getParameter("search");
        String category = req.getParameter("category");
        String status = req.getParameter("status");

        SubjectDAO dao = new SubjectDAO();
        List<Subject> subjectList = new ArrayList<>();
        List<String> categoryList = new ArrayList<>();
        try {
            categoryList = dao.getAllCategories();
            if (acc.getRoleID() == 1) { // Admin
                subjectList = dao.getAllSubjects(search, category, status);
            } else if (acc.getRoleID() == 2) { // Expert
                subjectList = dao.getSubjectsByExpertId(acc.getUserID(), search, category, status); // CHỈ LẤY SUBJECT CỦA EXPERT
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.setAttribute("subjectList", subjectList);
        req.setAttribute("categoryList", categoryList);
        // Lấy thông tin user từ session

        req.setAttribute("userName", acc.getFullName());
        req.setAttribute("userRole", acc.getRoleID() == 1 ? "Admin" : (acc.getRoleID() == 2 ? "Expert" : "Other"));
        req.setAttribute("avatarUrl", acc.getUrlAvatar());

        req.getRequestDispatcher("/userPages/subjectList.jsp").forward(req, resp);

    }
}
