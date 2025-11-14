//package controller;
//
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import jakarta.servlet.http.Part;
//import dao.CourseDAO;
//import model.Account;
//import dao.SubjectDAO;
//import model.Subject;
//import java.util.List;
//import dao.PricePackageDAO;
//import model.PricePackage;
//
//@WebServlet(name = "AddCourseServlet", urlPatterns = {"/AddCourseServlet"})
//@MultipartConfig(maxFileSize = 16177215) // 16MB
//public class AddCourseServlet extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Chỉ cho phép Admin hoặc Expert truy cập
//        HttpSession session = request.getSession();
//        Account acc = (Account) session.getAttribute("account");
//        if (acc == null) {
//            acc = (Account) session.getAttribute("fullAccount");
//        }
//        if (acc == null || !(acc.getRoleID() == 1 || acc.getRoleID() == 2)) {
//            response.sendRedirect("userPages/accessDenied.jsp");
//            return;
//        }
//        // Lấy danh sách subject cho dropdown
//        List<Subject> subjects = new SubjectDAO().getAllSubjects();
//        request.setAttribute("subjects", subjects);
//        // Lấy top 5 price package có giá thấp nhất (nếu cần cho các chức năng khác)
//        List<PricePackage> packages = new PricePackageDAO().getTop5PricePackages();
//        request.setAttribute("packages", packages);
//        // Hiển thị thông báo nếu có
//        String successMsg = request.getParameter("success");
//        if (successMsg != null) {
//            request.setAttribute("success", successMsg);
//        }
//        request.getRequestDispatcher("adminPages/addCourse.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        HttpSession session = request.getSession();
//        Account acc = (Account) session.getAttribute("account");
//        if (acc == null) {
//            acc = (Account) session.getAttribute("fullAccount");
//        }
//        if (acc == null || !(acc.getRoleID() == 1 || acc.getRoleID() == 2)) {
//            response.sendRedirect("userPages/accessDenied.jsp");
//            return;
//        }
//        // Lấy lại dữ liệu cho form (subjects, packages) để forward về JSP nếu cần
//        List<Subject> subjects = new SubjectDAO().getAllSubjects();
//        request.setAttribute("subjects", subjects);
//        List<PricePackage> packages = new PricePackageDAO().getTop5PricePackages();
//        request.setAttribute("packages", packages);
//
//        // Kiểm tra có phải submit form PricePackage không (chỉ khi có courseID và name, và KHÔNG có các trường của Course)
//        String courseIDStr = request.getParameter("courseID");
//        String packageName = request.getParameter("name");
//        String accessDurationStr = request.getParameter("accessDuration");
//        String listPriceStr = request.getParameter("listPrice");
//        String salePriceStr = request.getParameter("salePrice");
//        // Nếu có courseID và các trường của package, thì xử lý thêm package
//        if (courseIDStr != null && packageName != null && accessDurationStr != null && listPriceStr != null && salePriceStr != null) {
//            int courseID = Integer.parseInt(courseIDStr);
//            int accessDuration = Integer.parseInt(accessDurationStr);
//            double listPrice = Double.parseDouble(listPriceStr);
//            double salePrice = Double.parseDouble(salePriceStr);
//            String description = request.getParameter("description");
//
//            dao.PricePackageDAO pricePackageDAO = new dao.PricePackageDAO();
//            boolean success = pricePackageDAO.addPricePackage(courseID, packageName, accessDuration, listPrice, salePrice, description);
//
//            if (success) {
//                request.setAttribute("courseID", courseID);
//                request.setAttribute("success", "Thêm gói giá thành công! Bạn có thể thêm tiếp hoặc quay lại danh sách khóa học.");
//            } else {
//                request.setAttribute("courseID", courseID);
//                request.setAttribute("error", "Thêm gói giá thất bại!");
//            }
//            // Chỉ forward lại để hiển thị form thêm package tiếp
//            request.getRequestDispatcher("adminPages/addCourse.jsp").forward(request, response);
//            return;
//        }
//
//        // Nếu không phải submit PricePackage, xử lý thêm Course (chỉ khi không có courseID)
//        if (courseIDStr == null) {
//            try {
//                int subjectID = Integer.parseInt(request.getParameter("subjectID"));
//                String name = request.getParameter("name");
//                String description = request.getParameter("description");
//                String courseTag = request.getParameter("courseTag");
//                String urlCourse = ""; // Có thể lấy từ file upload hoặc trường riêng nếu có
//                String courseLevel = request.getParameter("courseLevel");
//                String featureFlag = request.getParameter("featureFlag");
//                int status = Integer.parseInt(request.getParameter("status"));
//                int courseraDuration = 0;
//                try {
//                    courseraDuration = Integer.parseInt(request.getParameter("courseraDuration"));
//                } catch (Exception e) {}
//                // Xử lý ảnh nếu cần
//                Part imagePart = request.getPart("image");
//                if (imagePart != null && imagePart.getSize() > 0) {
//                    String fileName = imagePart.getSubmittedFileName();
//                    String uploadPath = request.getServletContext().getRealPath("") + "uploads";
//                    java.io.File uploadDir = new java.io.File(uploadPath);
//                    if (!uploadDir.exists()) uploadDir.mkdir();
//                    imagePart.write(uploadPath + java.io.File.separator + fileName);
//                    urlCourse = "uploads/" + fileName;
//                }
//                CourseDAO courseDAO = new CourseDAO();
//                int cid = courseDAO.getLastCourseId() +1;
//                boolean isAdded = courseDAO.addCourse(cid, subjectID, name, courseTag, urlCourse, description, courseLevel, featureFlag, status, courseraDuration);
//                if (isAdded) {
//                    // Thêm thành công, chuyển sang trang thêm package cho course mới
//                    response.sendRedirect("AddPackageServlet?courseID=" + cid);
//                    return;
//                } else {
//                    request.setAttribute("error", "Thêm khóa học thất bại!");
//                    request.getRequestDispatcher("adminPages/addCourse.jsp").forward(request, response);
//                    return;
//                }
//            } catch (Exception e) {
//                request.setAttribute("error", "Dữ liệu không hợp lệ hoặc thiếu thông tin!");
//            }
//            // Forward lại để hiển thị form thêm package nếu thành công
//            request.getRequestDispatcher("adminPages/addCourse.jsp").forward(request, response);
//            return;
//        }
//        // Nếu không rơi vào các trường hợp trên, quay lại trang thêm Course
//        request.getRequestDispatcher("adminPages/addCourse.jsp").forward(request, response);
//    }
//}
