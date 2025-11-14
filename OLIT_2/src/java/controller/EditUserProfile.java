/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Account;

/**
 *
 * @author Admin
 */
@WebServlet("/EditUserProfile")
@MultipartConfig
public class EditUserProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        request.setCharacterEncoding("UTF-8"); // xử lý tiếng Việt

        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Xử lý upload avatar nếu có
        Part avatarPart = null;
        try {
            avatarPart = request.getPart("avatar");
        } catch (Exception ignored) {}
        String avatarUrl = null;
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + avatarPart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/uploads/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            File file = new File(uploadPath, fileName);
            try (InputStream input = avatarPart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                avatarUrl = "uploads/" + fileName;
                AccountDAO.updateAvatar(userID, avatarUrl);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Nếu chỉ đổi avatar thì redirect luôn
        if (avatarUrl != null) {
            Account updatedAccount = AccountDAO.getAccountByID(userID);
            session.setAttribute("account", updatedAccount);
            session.setAttribute("message", "Upload avatar successfully!");
            session.setAttribute("messageType", "success");
            response.sendRedirect(request.getContextPath() + "/UserProfile");
            return;
        }

        // Lấy dữ liệu từ form userProfile.jsp
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String birthday = request.getParameter("birthday");

        AccountDAO accDao = new AccountDAO();
        boolean updated = accDao.editUserProfile(userID, fullName, gender, phoneNumber, birthday);

        if (updated) {
            Account updatedAccount = accDao.getAccountByID(userID);
            session.setAttribute("account", updatedAccount);
            session.setAttribute("message", "Upload information successfully!");
            session.setAttribute("messageType", "success");
            response.sendRedirect(request.getContextPath() + "/UserProfile");
        } else {
            session.setAttribute("message", "Update information failed. Please try again.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/UserProfile");
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
