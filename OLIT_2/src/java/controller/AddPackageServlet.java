//package controller;
//
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import dao.PricePackageDAO;
//import dao.CourseDAO;
//import java.util.List;
//import model.PricePackage;
//
//@WebServlet("/AddPackageServlet")
//public class AddPackageServlet extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String courseID = request.getParameter("courseID");
//        PricePackageDAO pricePackageDAO = new PricePackageDAO();
//        List<PricePackage> samplePackages = pricePackageDAO.getTop5PricePackages();
//        request.setAttribute("courseID", courseID);
//        request.setAttribute("samplePackages", samplePackages);
//        request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            int courseID = Integer.parseInt(request.getParameter("courseID"));
//            CourseDAO courseDAO = new CourseDAO();
//            PricePackageDAO pricePackageDAO = new PricePackageDAO();
//            List<PricePackage> samplePackages = pricePackageDAO.getTop5PricePackages();
//            request.setAttribute("samplePackages", samplePackages);
//            if (courseDAO.getCourseById(courseID) == null) {
//                request.setAttribute("message", "Course does not exist!");
//                request.setAttribute("courseID", courseID);
//                request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                return;
//            }
//            String packageName = request.getParameter("packageName");
//            String durationStr = request.getParameter("duration");
//            String listPriceStr = request.getParameter("listPrice");
//            String salePriceStr = request.getParameter("salePrice");
//            String description = request.getParameter("description");
//
//            // Validate dữ liệu đầu vào
//            if (packageName == null || packageName.trim().isEmpty() ||
//                durationStr == null || durationStr.trim().isEmpty() ||
//                listPriceStr == null || listPriceStr.trim().isEmpty() ||
//                salePriceStr == null || salePriceStr.trim().isEmpty()) {
//                request.setAttribute("message", "Missing or empty package data!");
//                request.setAttribute("courseID", courseID);
//                request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                return;
//            }
//
//            int accessDuration = 0;
//            int listPrice = 0;
//            int salePrice = 0;
//            try {
//                accessDuration = Integer.parseInt(durationStr);
//                listPrice = Integer.parseInt(listPriceStr);
//                salePrice = Integer.parseInt(salePriceStr);
//            } catch (NumberFormatException nfe) {
//                request.setAttribute("message", "Invalid number format in package data!");
//                request.setAttribute("courseID", courseID);
//                request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                return;
//            }
//
//            System.out.println("packageName=" + packageName);
//            System.out.println("duration=" + accessDuration);
//            System.out.println("listPrice=" + listPrice);
//            System.out.println("salePrice=" + salePrice);
//            System.out.println("description=" + description);
//
//            boolean success = false;
//            try {
//                // Kiểm tra trùng package name cho cùng course
//                List<PricePackage> existingPackages = pricePackageDAO.getPricePackagesByCourseId(courseID);
//                for (PricePackage pkg : existingPackages) {
//                    if (pkg.getName().equalsIgnoreCase(packageName)) {
//                        request.setAttribute("message", "This package name already exists for this course!");
//                        request.setAttribute("courseID", courseID);
//                        request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                        return;
//                    }
//                }
//                success = pricePackageDAO.addPricePackage(courseID, packageName, accessDuration, listPrice, salePrice, description);
//            } catch (Exception ex) {
//                ex.printStackTrace();
//                request.setAttribute("message", "SQL Exception: " + ex.getMessage());
//                request.setAttribute("courseID", courseID);
//                request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                return;
//            }
//
//            if (success) {
//                response.sendRedirect("AddCourseServlet?success=Add course and package successfully!");
//                return;
//            } else {
//                request.setAttribute("message", "Add package failed! (Check DB constraints)");
//                request.setAttribute("courseID", courseID);
//                request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//                return;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("message", "Invalid input data! " + e.getMessage());
//            request.getRequestDispatcher("/adminPages/addPackage.jsp").forward(request, response);
//        }
//    }
//} 