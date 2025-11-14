package controller;

import dao.QuestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.*;

@WebServlet("/QuestionListServlet")
public class QuestionListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session and user role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null || session.getAttribute("roleID") == null) {
            // If session or required attributes are missing, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer roleID = (Integer) session.getAttribute("roleID");
        if (roleID == null || roleID != 2) {
            // If the user is not an Expert (roleID != 2), redirect to Home
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
            return;
        }

        // Get request parameters for search, filter, pagination
        String search = request.getParameter("search");        // Search keyword
        String filter = request.getParameter("filter");        // Filter option (e.g., by topic)
        String pageSizeRaw = request.getParameter("pageSize"); // How many questions per page
        String pageIndexRaw = request.getParameter("page");    // Current page number

        // Default pagination values
        int pageSize = 10;
        int pageIndex = 1;

        // Parse pageSize and pageIndex if provided
        try {
            if (pageSizeRaw != null && !pageSizeRaw.isEmpty()) {
                pageSize = Integer.parseInt(pageSizeRaw);
            }
            if (pageIndexRaw != null && !pageIndexRaw.isEmpty()) {
                pageIndex = Integer.parseInt(pageIndexRaw);
            }
        } catch (NumberFormatException e) {
            // If invalid input, retain default values
        }

        // Retrieve questions from DAO 
        QuestionDAO dao = new QuestionDAO();

        // Get filtered and paginated list of questions
        List<Question> questionList = dao.getAllQuestionWithParam(search, filter, pageSize, pageIndex);

        // Get total number of matching records for pagination
        int totalRecords = dao.getTotalQuestionCount(search, filter);
        int totalPage = (int) Math.ceil((double) totalRecords / pageSize); // Total pages

        // Set attributes to be forwarded to JSP 
        request.setAttribute("questionList", questionList);
        request.setAttribute("search", search);
        request.setAttribute("filter", filter);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("totalPage", totalPage);

        // Step 6: Forward to JSP page for rendering 
        request.getRequestDispatcher("/adminPages/questionList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
