package controller;

import dao.AccountDAO;
import dao.RoleDAO;
import model.Account;
import model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AdminUserListServlet", urlPatterns = {"/AdminUserListServlet"})
public class AdminUserListServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null
                || !"1".equals(session.getAttribute("roleID").toString())) {
            response.sendRedirect(request.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }

        // Get parameters
        String search = request.getParameter("search");
        String gender = getStringAttributeOrParameter(request, "gender");
        String role = getStringAttributeOrParameter(request, "role");
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");

        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
        }

        // Fetch user list
        List<Account> userList = AccountDAO.getAccounts();
        if (userList == null) userList = new ArrayList<>();

        // Filter
        if (gender != null && !gender.isEmpty()) {
            userList = userList.stream()
                    .filter(u -> gender.equalsIgnoreCase(u.getGender()))
                    .collect(Collectors.toList());
        }

        if (role != null && !role.isEmpty()) {
            try {
                int roleId = Integer.parseInt(role);
                userList = userList.stream()
                        .filter(u -> u.getRoleID() == roleId)
                        .collect(Collectors.toList());
            } catch (NumberFormatException ignored) {
            }
        }

        if (status != null && !status.isEmpty()) {
            userList = userList.stream()
                    .filter(u -> status.equalsIgnoreCase(u.getStatus()))
                    .collect(Collectors.toList());
        }

        // Search
        if (search != null && !search.isEmpty()) {
            String keyword = search.toLowerCase();
            userList = userList.stream()
                    .filter(u ->
                            (u.getFullName() != null && u.getFullName().toLowerCase().contains(keyword)) ||
                            (u.getEmail() != null && u.getEmail().toLowerCase().contains(keyword)) ||
                            (u.getPhoneNumber() != null && u.getPhoneNumber().toLowerCase().contains(keyword)))
                    .collect(Collectors.toList());
        }

        // Pagination
        int totalRecords = userList.size();
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        int fromIndex = Math.min((currentPage - 1) * PAGE_SIZE, totalRecords);
        int toIndex = Math.min(fromIndex + PAGE_SIZE, totalRecords);
        List<Account> paginatedList = userList.subList(fromIndex, toIndex);

        List<Role> roleList = RoleDAO.getRoles();

        // Set attributes
        request.setAttribute("userList", paginatedList);
        request.setAttribute("roleList", roleList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("search", search);
        request.setAttribute("gender", gender);
        request.setAttribute("role", role);
        request.setAttribute("status", status);
        request.setAttribute("sort", sort);
        request.setAttribute("editUserID", request.getParameter("editUserID"));

        request.getRequestDispatcher("/adminPages/adminUserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null
                || !"1".equals(session.getAttribute("roleID").toString())) {
            response.sendRedirect(request.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "save":
                    int userID = Integer.parseInt(request.getParameter("userID"));
                    Account acc = AccountDAO.getAccountByID(userID);
                    if (acc != null) {
                        acc.setFullName(request.getParameter("fullName"));
                        acc.setGender(request.getParameter("gender"));
                        acc.setEmail(request.getParameter("email"));
                        acc.setPhoneNumber(request.getParameter("phoneNumber"));
                        acc.setRoleID(Integer.parseInt(request.getParameter("roleID")));
                        acc.setStatus(request.getParameter("status"));
                        AccountDAO.updateAccount(acc);
                    }
                    break;

                case "delete":
                    int deleteID = Integer.parseInt(request.getParameter("userID"));
                    AccountDAO.deleteAccount(deleteID);
                    break;

                case "add":
                    String email = request.getParameter("email");
                    if (AccountDAO.getAccountByMail(email) != null) {
                        request.setAttribute("errorAddUser", "Email already exists. Cannot create new user.");
                        request.setAttribute("addUserData", new String[]{
                                request.getParameter("fullName"),
                                request.getParameter("gender"),
                                email,
                                request.getParameter("phoneNumber"),
                                request.getParameter("roleID"),
                                request.getParameter("status")
                        });
                        request.setAttribute("showAddUserModal", true);
                        doGet(request, response);
                        return;
                    }

                    Account newAcc = new Account();
                    newAcc.setFullName(request.getParameter("fullName"));
                    newAcc.setGender(request.getParameter("gender"));
                    newAcc.setEmail(email);
                    newAcc.setPhoneNumber(request.getParameter("phoneNumber"));
                    newAcc.setRoleID(Integer.parseInt(request.getParameter("roleID")));
                    newAcc.setStatus(request.getParameter("status"));
                    newAcc.setPassword(request.getParameter("password"));
                    AccountDAO.insertAccount(newAcc);

                    response.sendRedirect(request.getContextPath() + "/AdminUserListServlet");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Hoặc dùng Logger nếu cần
        }

        doGet(request, response);
    }

    private String getStringAttributeOrParameter(HttpServletRequest request, String name) {
        Object attr = request.getAttribute(name);
        return attr != null ? attr.toString() : request.getParameter(name);
    }
}
