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
import model.Account;
import dao.AccountDAO;
import java.util.Properties;
import jakarta.mail.*;
import dao.AccountDAO;
import jakarta.mail.internet.*;
import validate.InputValidator;

/**
 *
 * @author macbook
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Get user input from signup form
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String err = "";

        // Validate email format and check if it already exists
        if (!InputValidator.isEmail(email) || AccountDAO.getAccountByMail(email) != null) {
            err = "Email already exists or is invalid!";
            request.setAttribute("err", err);
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        } // Validate phone number format
        else if (!InputValidator.isPhone(phone)) {
            err = "Phone number must be 10 digits long!";
            request.setAttribute("err", err);
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        } // Check if phone number already exists
        else if (AccountDAO.getAccountByPhone(phone) != null) {
            err = "Phone number already exists!";
            request.setAttribute("err", err);
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        } else {
            // Send verification email for setting password
            String link = "http://localhost:9999/OLIT_2/userPages/setPassword.jsp?email=" + email;
            sendVerificationEmail(email, link);

            // Create a new account and insert it into the database
            Account newAccount = new Account();
            newAccount.setFullName(fullName);
            newAccount.setGender(gender);
            newAccount.setEmail(email);
            newAccount.setPhoneNumber(phone);
            newAccount.setRoleID(3);
            newAccount.setStatus("active");
            newAccount.setPassword("0");
            AccountDAO.insertAccount(newAccount);

            // Forward to waiting email confirmation page
            request.setAttribute("email", email);
            request.setAttribute("action", "Create Your Account");
            request.getRequestDispatcher("waitingEmail.jsp").forward(request, response);
        }
    }

    // Send verification email with password setup link
    private void sendVerificationEmail(String to, String link) {
        final String from = "longxz135@gmail.com";
        final String pass = "nxjw uecr wgcm vsmc";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Confirm account registration");

            // Email content with setup link
            String htmlContent = "<html><body style='font-family: Arial, sans-serif; text-align: center;'>"
                    + "<h1>Login to the System</h1>"
                    + "<p>Click the link below to login</p>"
                    + "<a href='" + link + "' style='text-decoration: none;'><button style='background-color: #007BFF; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;'>Login</button></a>"
                    + "</body></html>";
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
