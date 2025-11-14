package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author Admin
 */
@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        AccountDAO accountDAO = new AccountDAO();
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        //lấy dữ liệu từ DB
        int userId = (int) session.getAttribute("userID");
        int roleID = (int) session.getAttribute("roleID");
       

        Account account = accountDAO.getAccountByID(userId);
        System.out.println("Account from DB: " + account);
        int roleId = (int) session.getAttribute("roleID");
        String userEmail = (String) session.getAttribute("userEmail");
        

        request.setAttribute("roleID", roleID);
        request.setAttribute("userID", userId);
        request.setAttribute("roleID", roleId);
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("account", account);

        request.getRequestDispatcher("/userPages/userProfile.jsp").forward(request, response);
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
