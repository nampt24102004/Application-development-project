package controller;

import dao.SubjectDAO;
import dao.DimensionDAO;
import dao.LessonDAO;
import dao.QuestionDAO;
import dao.QuestionAnswerDAO;
import dao.QuestionMediaDAO;
import model.Subject;
import model.Dimension;
import model.Lesson;
import model.Question;
import model.QuestionAnswer;
import model.QuestionMedia;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.util.Collection;
import java.util.stream.Collectors;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet("/QuestionDetailServlet")
public class QuestionDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate session and role
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

        // Load question details
        String qid = request.getParameter("questionID");
        if (qid == null || qid.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameter questionID");
            return;
        }
        int questionID = Integer.parseInt(qid);

        Subject subject = SubjectDAO.getSubjectByID(questionID);
        List<Dimension> dimensions = DimensionDAO.getDimensionsByQuestionID(questionID);
        Question question = QuestionDAO.getQuesionByID(questionID);
        if (question == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Question not found");
            return;
        }
        Lesson lesson = LessonDAO.getLessonByID(question.getLessonID());
        List<QuestionAnswer> answers = QuestionAnswerDAO.getQuestionAnswerByQuestionID(questionID);
        List<QuestionMedia> medias = QuestionMediaDAO.getQuestionAnswerByQuestionID(questionID);

        request.setAttribute("subject", subject);
        request.setAttribute("dimensions", dimensions);
        request.setAttribute("lesson", lesson);
        request.setAttribute("question", question);
        request.setAttribute("questionAnswers", answers);
        request.setAttribute("questionMedias", medias);
        request.getRequestDispatcher("adminPages/questionDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String qid = request.getParameter("questionID");
        if (qid == null || qid.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameter questionID");
            return;
        }
        int questionID = Integer.parseInt(qid);

        switch (action == null ? "" : action) {
            case "saveChanges":
                // Update question content and status
                Question q = new Question();
                q.setQuestionID(questionID);
                q.setQuestionContent(request.getParameter("questionContent"));
                q.setStatus("1".equals(request.getParameter("status")));
                new QuestionDAO().update(q);

                // Update existing answers
                String[] ansIds = request.getParameterValues("answerID");
                if (ansIds != null) {
                    String[] dets = request.getParameterValues("answerDetail");
                    String[] exps = request.getParameterValues("explanation");
                    String[] cors = request.getParameterValues("isCorrect");
                    for (int i = 0; i < ansIds.length; i++) {
                        QuestionAnswerDAO.changeQuestionAnswer(
                                questionID,
                                Integer.parseInt(ansIds[i]),
                                dets[i],
                                exps[i],
                                "1".equals(cors[i]));
                    }
                }

                // Add new answers
                String[] newD = request.getParameterValues("newAnswerDetail");
                if (newD != null) {
                    String[] newE = request.getParameterValues("newExplanation");
                    String[] newC = request.getParameterValues("newIsCorrect");
                    for (int i = 0; i < newD.length; i++) {
                        if (!newD[i].isBlank()) {
                            QuestionAnswerDAO.createQuestionAnswer(
                                    questionID,
                                    newD[i],
                                    newE[i],
                                    "1".equals(newC[i]));
                        }
                    }
                }

                response.sendRedirect(request.getContextPath() + "/QuestionDetailServlet?questionID=" + questionID);
                break;

            case "saveMediaList":
                // Delete old media
                List<QuestionMedia> oldMedia = QuestionMediaDAO.getQuestionAnswerByQuestionID(questionID);
                for (QuestionMedia m : oldMedia) {
                    QuestionMediaDAO.deleteQuestionMedia(m.getMediaId());
                }

                // Upload and save new media
                String[] mTypes = request.getParameterValues("mediaType");
                String[] mDescs = request.getParameterValues("mediaDescription");
                String[] existingURLs = request.getParameterValues("existingMediaURL");
                Collection<Part> parts = request.getParts();
                List<Part> fileParts = parts.stream()
                        .filter(p -> "mediaFile".equals(p.getName()))
                        .collect(Collectors.toList());

                for (int i = 0; i < mTypes.length; i++) {
                    String filename = null;
                    Part filePart = (fileParts.size() > i) ? fileParts.get(i) : null;
                    if (filePart != null && filePart.getSize() > 0) {
                        filename = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                        String uploadDir = getServletContext().getRealPath("/userPages/assets/mediaQuestion");
                        File uploadPath = new File(uploadDir);
                        if (!uploadPath.exists()) {
                            uploadPath.mkdirs();
                        }
                        filePart.write(uploadDir + File.separator + filename);
                    } else if (existingURLs != null && existingURLs.length > i) {
                        filename = existingURLs[i];
                    }
                    if (filename != null && !filename.isBlank()) {
                        QuestionMediaDAO.createQuestionMedia(
                                questionID,
                                filename,
                                Integer.parseInt(mTypes[i]),
                                mDescs[i]);
                    }
                }

                response.sendRedirect(request.getContextPath() + "/QuestionDetailServlet?questionID=" + questionID);
                break;

            case "deleteQuestion":
                // Delete question and redirect
                boolean ok = new QuestionDAO().deleteQuestionByID(questionID);
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/QuestionListServlet");
                } else {
                    response.getWriter().write("fail");
                }
                break;

            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
