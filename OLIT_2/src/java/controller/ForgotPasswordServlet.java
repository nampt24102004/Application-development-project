/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;
import model.*;
import validate.InputValidator;

/**
 *
 * @author macbook
 */
@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ForgotPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        request.setCharacterEncoding("UTF-8");

        // Handle "resetPassword" action
        String action = request.getParameter("action");
        String err = "";

        if (action.equalsIgnoreCase("resetPassword")) {
            String email = request.getParameter("email");

            // Validate email and check if it exists
            Account acc = AccountDAO.getAccountByMail(email);
            if (acc == null || !InputValidator.isEmail(email)) {
                err = "Email is not registered or invalid, register or try again.";
                request.setAttribute("err", err);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            } else {
                // Send reset password email
                String resetLink = "http://localhost:9999/OLIT_2/userPages/setPassword.jsp?email=" + email;
                sendVerificationEmail(email, resetLink);

                // Forward to waiting page
                request.setAttribute("email", email);
                request.setAttribute("action", "Reset your password");
                request.getRequestDispatcher("waitingEmail.jsp").forward(request, response);
            }
        }
    }

// Send password reset email
    private void sendVerificationEmail(String to, String link) {
        final String from = "longxz135@gmail.com";
        final String pass = "nxjw uecr wgcm vsmc";

        // Set email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Authenticate and create session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        });

        try {
            // Compose email content
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            String htmlContent = "<html><body style='font-family: Arial, sans-serif; text-align: center;'>"
                    + "<h1>Password Reset</h1>"
                    + "<p>If you've lost your password or wish to reset it, use the link below to get started</p>"
                    + "<a href='" + link + "' style='text-decoration: none;'><button style='background-color: #007BFF; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;'>Reset Your Password</button></a>"
                    + "<p style='margin-top: 30px; font-size: 14px; color: #666;'>If you did not request a password reset, you can safely ignore this email. Only a person with access to your email can reset your account password.</p>"
                    + "</body></html>";
            message.setContent(htmlContent, "text/html; charset=utf-8");

            // Send email
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
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
