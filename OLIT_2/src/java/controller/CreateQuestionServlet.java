/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DimensionDAO;
import dao.LessonDAO;
import dao.QuestionAnswerDAO;
import dao.QuestionDAO;
import dao.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import model.Dimension;
import model.Lesson;
import model.Question;
import model.Subject;

/**
 *
 * @author Long0
 */
@WebServlet(name = "CreateQuestionServlet", urlPatterns = {"/CreateQuestionServlet"})
public class CreateQuestionServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateQuestionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateQuestionServlet at " + request.getContextPath() + "</h1>");
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

        // Validate session and user role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null || session.getAttribute("roleID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer roleID = (Integer) session.getAttribute("roleID");
        if (roleID == null || roleID != 2) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
            return;
        }

        // Load dropdown data
        SubjectDAO sj = new SubjectDAO();
        List<Subject> subjects = sj.getAllPublishedSubjects();
        List<Dimension> dimensions = DimensionDAO.getAllDimension();
        List<Lesson> lessons = LessonDAO.getAllLesson();

        // Set attributes and forward to JSP
        request.setAttribute("subjects", subjects);
        request.setAttribute("dimensions", dimensions);
        request.setAttribute("lessons", lessons);
        request.getRequestDispatcher("adminPages/createQuestion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorMessage = null;

        try {
            // Get and validate basic question info
            String subjectParam = request.getParameter("subject");
            String lessonParam = request.getParameter("lesson");
            String statusParam = request.getParameter("status");
            String questionContent = request.getParameter("questionContent");
            String userIDParam = request.getParameter("userID");
            String lvParam = request.getParameter("lv");

            if (subjectParam == null || lessonParam == null || statusParam == null
                    || questionContent == null || questionContent.trim().isEmpty()
                    || userIDParam == null || lvParam == null) {
                errorMessage = "Please fill in all required question fields.";
            }

            int subject = -1;
            int lesson = -1;
            boolean status = false;
            int userID = -1;
            int lv = -1;

            if (errorMessage == null) {
                try {
                    subject = Integer.parseInt(subjectParam);
                    lesson = Integer.parseInt(lessonParam);
                    int statusInt = Integer.parseInt(statusParam);
                    status = (statusInt == 1);
                    userID = Integer.parseInt(userIDParam);
                    lv = Integer.parseInt(lvParam);
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid numeric input.";
                }
            }

            // Validate answers
            String[] newAnswerDetails = request.getParameterValues("newAnswerDetail");
            String[] newExplanations = request.getParameterValues("newExplanation");
            String[] newIsCorrects = request.getParameterValues("newIsCorrect");

            if (newAnswerDetails == null || newAnswerDetails.length < 2) {
                errorMessage = "A question must have at least 2 answers.";
            } else {
                boolean hasCorrectAnswer = false;
                for (int i = 0; i < newAnswerDetails.length; i++) {
                    if (newAnswerDetails[i] == null || newAnswerDetails[i].trim().isEmpty()) {
                        errorMessage = "Please fill in all answer details.";
                        break;
                    }
                    if (newIsCorrects != null && i < newIsCorrects.length && "1".equals(newIsCorrects[i])) {
                        hasCorrectAnswer = true;
                    }
                }
                if (errorMessage == null && !hasCorrectAnswer) {
                    errorMessage = "At least one answer must be marked as correct.";
                }
            }

            // Return if validation fails
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("selectedSubject", subjectParam);
                request.setAttribute("selectedLesson", lessonParam);
                request.setAttribute("selectedStatus", statusParam);
                request.setAttribute("selectedLevel", lvParam);
                request.setAttribute("questionContent", questionContent);
                doGet(request, response);
                return;
            }

            // Insert question into database
            Question question = new Question(questionContent, 1, status, lv, userID, subject, lesson);
            question.setCreatedAt(LocalDateTime.now());
            int questionID = QuestionDAO.insertQuestion(question);

            if (questionID == -1) {
                errorMessage = "Failed to create question.";
                request.setAttribute("errorMessage", errorMessage);
                doGet(request, response);
                return;
            }

            // Insert dimensions
            String[] dimensions = request.getParameterValues("dimensions");
            if (dimensions != null) {
                for (String dimStr : dimensions) {
                    if (!dimStr.trim().isEmpty()) {
                        int dimension = Integer.parseInt(dimStr);
                        DimensionDAO.insertQuestionDimension(questionID, dimension);
                    }
                }
            }

            // Insert answers
            for (int i = 0; i < newAnswerDetails.length; i++) {
                String detail = newAnswerDetails[i].trim();
                String explanation = (newExplanations != null && i < newExplanations.length)
                        ? newExplanations[i].trim() : "";
                boolean isCorrect = (newIsCorrects != null && i < newIsCorrects.length)
                        && "1".equals(newIsCorrects[i]);

                QuestionAnswerDAO.createQuestionAnswer(questionID, detail, explanation, isCorrect);
            }

            // Redirect after success
            response.sendRedirect(request.getContextPath() + "/QuestionListServlet");

        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "Unexpected error: " + e.getMessage();
            request.setAttribute("errorMessage", errorMessage);
            doGet(request, response);
        }
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
