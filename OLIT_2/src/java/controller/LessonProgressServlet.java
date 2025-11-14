package controller;

import dao.LessonProgressDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/lesson-progress")
public class LessonProgressServlet extends HttpServlet {

    private final LessonProgressDAO lpDAO = new LessonProgressDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");

        String lessonIdStr = req.getParameter("lessonId");
        System.out.println("🔥 lessonId = '" + lessonIdStr + "'"); // THÊM DÒNG NÀY

        int userId = ((Integer) req.getSession().getAttribute("userID"));

        try (PrintWriter out = resp.getWriter()) {
            int lessonId = Integer.parseInt(lessonIdStr); // lỗi sẽ nằm ở đây nếu rỗng
            new LessonProgressDAO().markCompleted(userId, lessonId);
            out.print("{\"success\":true}");
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.setStatus(500);
        }
    }

}
