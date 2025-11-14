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
import java.util.List;               // ← correct List import
import model.Post;
import model.PostCategory;

/**
 *
 * @author khain
 */
@WebServlet(name = "BlogDetailsServlet", urlPatterns = {"/BlogDetailsServlet"})
public class BlogDetailsServlet extends HttpServlet {

    private final PostDAO postDAO = new PostDAO();
    private final PostCategoryDAO catDAO = new PostCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int postID = Integer.parseInt(req.getParameter("postID"));

    // 1) load single post
    Post post = postDAO.getPostByID(postID);

    // 2) sidebar data
    List<PostCategory> categories = catDAO.findAll();
    List<Post> latestPosts = postDAO.getNewestPost();

    // 3) set attributes
    req.setAttribute("post", post);
    req.setAttribute("categories", categories);
    req.setAttribute("latestPosts", latestPosts);

    // 4) forward
    req.getRequestDispatcher("/userPages/blogDetails.jsp")
       .forward(req, resp);
  }
}
