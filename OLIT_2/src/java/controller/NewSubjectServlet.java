package controller;

import dao.AccountDAO;
import dao.SubjectDAO;
import dao.SubjectMediaDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.stream.Collectors;
import model.Account;

@WebServlet(name = "NewSubjectServlet", urlPatterns = {"/newSubject"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 50, // 50MB/file
        maxRequestSize = 1024 * 1024 * 100 // 100MB total
)
public class NewSubjectServlet extends HttpServlet {

    // Hiển thị form, load category + expert từ DB
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Kiểm quyền (nếu cần)
        HttpSession session = req.getSession();
        Account acc = (session != null) ? (Account) session.getAttribute("fullAccount") : null;
        if (acc == null || acc.getRoleID() != 1) {
            resp.sendRedirect(req.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }

        String success = (String) session.getAttribute("successMessage");
        if (success != null) {
            req.setAttribute("successMessage", success);
            session.removeAttribute("successMessage");
        }

        // --- Flash errorMessage (nếu dùng session) ---
        String error = (String) session.getAttribute("errorMessage");
        if (error != null) {
            req.setAttribute("errorMessage", error);
            session.removeAttribute("errorMessage");
        }

        // Load data cho dropdown
        List<String> categoryList = new SubjectDAO().getAllCategories();
        List<Account> expertList = new AccountDAO().getExperts();

        req.setAttribute("categoryList", categoryList);
        req.setAttribute("expertList", expertList);

        // Forward đến JSP mới của bạn 
        req.getRequestDispatcher("/userPages/newSubject.jsp").forward(req, resp);
    }

    // Xử lý khi bấm Save
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Account acc = (session != null) ? (Account) session.getAttribute("fullAccount") : null;
        if (acc == null || acc.getRoleID() != 1) {
            resp.sendRedirect(req.getContextPath() + "/accessDenied.jsp");
            return;
        }

        // 1) Đọc form fields
        String subjectName = req.getParameter("subjectName");
        String category = req.getParameter("category");
        String ownerRaw = req.getParameter("ownerId");
        String statusRaw = req.getParameter("status");
        String description = req.getParameter("description");

        int ownerId = Integer.parseInt(ownerRaw);
        boolean featuredFlag = req.getParameter("featuredFlag") != null;
        boolean status = "1".equals(statusRaw);

        // 2) Lưu Subject, lấy ID
        int subjectID = new SubjectDAO().insertSubjectReturnId(subjectName, category, ownerId, featuredFlag, status, description);
        if (subjectID <= 0) {
            session.setAttribute("errorMessage", "Tạo Subject thất bại, vui lòng thử lại!");

            resp.sendRedirect(req.getContextPath() + "/newSubject");
            return;
        }

        // 3) Lưu từng file media vào /uploads và SubjectMedia
        String uploadPath = req.getServletContext().getRealPath("/uploads");
        new File(uploadPath).mkdirs();
        SubjectMediaDAO smDao = new SubjectMediaDAO();

        // Lấy các tên file tuỳ chỉnh từ JSP
        String[] customNames = req.getParameterValues("customFileName");

        // Lọc ra danh sách Part là mediaFiles
        List<Part> fileParts = req.getParts().stream()
                .filter(p -> "mediaFiles".equals(p.getName()) && p.getSize() > 0)
                .collect(Collectors.toList());

        for (int i = 0; i < fileParts.size(); i++) {
            Part part = fileParts.get(i);
            String originalName = Paths.get(part.getSubmittedFileName())
                    .getFileName().toString();
            String ext = originalName.substring(originalName.lastIndexOf('.') + 1).toLowerCase();
            String mediaType = ext.matches("jpg|jpeg|png|gif")
                    ? "image"
                    : "video";

            String filePath = uploadPath + File.separator + originalName;
            part.write(filePath);

            
            // Chọn tên tuỳ chỉnh (nếu rỗng thì dùng tên gốc)
            String custom = (customNames != null && customNames.length > i && !customNames[i].isBlank())
                    ? customNames[i]
                    : originalName;
            String url = "uploads/" + originalName;
            // Save record vào DB
            smDao.insertMedia(subjectID, url, mediaType, custom );
        }
    

    // 4) Chuyển về trang danh sách
    session.setAttribute (

    "successMessage", "Tạo Subject thành công!");
    resp.sendRedirect (req.getContextPath

() + "/newSubject");
    }
}
