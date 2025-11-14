/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Account;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Long0
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static ArrayList<Account> accounts = AccountDAO.getAccounts();

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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

        // Get email and password from the login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String err = "";

        boolean loginSuccess = false;
        Account loggedInAccount = null;

        // Authenticate user
        if (AccountDAO.getAccountByMail(email) != null
                && AccountDAO.getAccountByMail(email).getPassword().equals(password)) {

            // Create session and store user info
            loggedInAccount = AccountDAO.getAccountByMail(email);
            HttpSession session = request.getSession();
            session.setAttribute("userID", loggedInAccount.getUserID());
            session.setAttribute("roleID", loggedInAccount.getRoleID());
            session.setAttribute("userEmail", loggedInAccount.getEmail());
            session.setAttribute("fullAccount", loggedInAccount);
            session.setAttribute("avatarUrl", loggedInAccount.getUrlAvatar());

            // Redirect to homepage
            response.sendRedirect(request.getContextPath() + "/HomeServlet");

        } else {
            // Handle invalid login
            err = "Wrong email or password, please re-enter";
            request.setAttribute("err", err);
            RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
            rs.forward(request, response);
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
