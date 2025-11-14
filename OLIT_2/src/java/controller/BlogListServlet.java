/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostCategoryDAO;
import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import model.PostCategory;

/**
 *
 * @author Admin
 */
@WebServlet("/BlogListServlet")
public class BlogListServlet extends HttpServlet {

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
            out.println("<title>Servlet BlogListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO postDao = new PostDAO();
        PostCategoryDAO catDAO = new PostCategoryDAO();
        String search = request.getParameter("search");
        String categoryIdRaw = request.getParameter("categoryId");
        List<Post> list = null;

        if (search != null && !search.trim().isEmpty()) {
            list = postDao.searchPost(search);

        } else if (categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdRaw);
            list = postDao.getBlogByCategory(categoryId);
        } else {
            list = postDao.getAllBlog(); // hoặc hàm lấy toàn bộ bài viết
        }

        List<Post> newestPosts = postDao.getNewestPost();
        List<PostCategory> categories = catDAO.findAll();
        request.setAttribute("blogList", list);
        request.setAttribute("newestPosts", newestPosts);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("userPages/blogList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
