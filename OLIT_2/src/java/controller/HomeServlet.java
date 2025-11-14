package controller;
import dao.CourseDAO;
import dao.PostDAO;
import dao.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;
@WebServlet(name = "HomeServlet", urlPatterns = {"/HomeServlet"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SliderDAO sliderDAO = new SliderDAO();
        PostDAO postDAO = new PostDAO();
        CourseDAO courseDAO = new CourseDAO();
        List<Slider> listSlider = sliderDAO.getSlider();
        List<Post> latestPost = postDAO.getNewestPost();
        List<Post> hotPost = postDAO.getHotPost();
        List<Course> hotCourse = courseDAO.getHotCourses();
        // Đặt danh sách slider vào request để chuyển sang JSP
        request.setAttribute("listSlider", listSlider);
        request.setAttribute("latestPost", latestPost);
        request.setAttribute("hotPost", hotPost);
        request.setAttribute("hotCourse", hotCourse);
        request.getRequestDispatcher("/userPages/home.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}