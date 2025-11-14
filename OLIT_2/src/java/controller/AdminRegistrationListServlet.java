package controller;

import dao.RegistrationDAO;
import dao.SubjectDAO;
import dao.CourseDAO;
import model.Registration;
import model.Subject;
import model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminRegistrationListServlet", urlPatterns = {"/AdminRegistrationListServlet"})
public class AdminRegistrationListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || (int) session.getAttribute("roleID") != 1) {
            response.sendRedirect(request.getContextPath() + "/userPages/accessDenied.jsp");
            return;
        }
        

        RegistrationDAO registrationDAO = new RegistrationDAO();
        List<Registration> registrationList = registrationDAO.getAllRegistrationsForAdmin();

        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjectList = subjectDAO.getAllSubjects();
        request.setAttribute("subjectList", subjectList);

        // Lấy danh sách course cho filter
        List<Course> courseList = new CourseDAO().getCourses();
        request.setAttribute("courseList", courseList);

        // Danh sách trạng thái
        List<String> statusList = new ArrayList<>();
        statusList.add("Approved");
        statusList.add("Pending");
        statusList.add("Rejected");
        statusList.add("Cancelled");
        statusList.add("NotApproved");
        request.setAttribute("statusList", statusList);

        // Danh sách sort
        List<Map<String, String>> sortList = new ArrayList<>();
        sortList.add(Map.of("value", "id_asc", "label", "ID ↑"));
        sortList.add(Map.of("value", "id_desc", "label", "ID ↓"));
        sortList.add(Map.of("value", "email_asc", "label", "Email ↑"));
        sortList.add(Map.of("value", "email_desc", "label", "Email ↓"));
        sortList.add(Map.of("value", "date_asc", "label", "Registration Date ↑"));
        sortList.add(Map.of("value", "date_desc", "label", "Registration Date ↓"));
        sortList.add(Map.of("value", "subject_asc", "label", "Subject ↑"));
        sortList.add(Map.of("value", "subject_desc", "label", "Subject ↓"));
        sortList.add(Map.of("value", "package_asc", "label", "Package ↑"));
        sortList.add(Map.of("value", "package_desc", "label", "Package ↓"));
        sortList.add(Map.of("value", "price_asc", "label", "Total Price ↑"));
        sortList.add(Map.of("value", "price_desc", "label", "Total Price ↓"));
        sortList.add(Map.of("value", "status_asc", "label", "Status ↑"));
        sortList.add(Map.of("value", "status_desc", "label", "Status ↓"));
        sortList.add(Map.of("value", "from_asc", "label", "Valid From ↑"));
        sortList.add(Map.of("value", "from_desc", "label", "Valid From ↓"));
        sortList.add(Map.of("value", "to_asc", "label", "Valid To ↑"));
        sortList.add(Map.of("value", "to_desc", "label", "Valid To ↓"));
        request.setAttribute("sortList", sortList);

        // Lấy filter từ request
        String searchEmail = request.getParameter("searchEmail");
        String courseIdStr = request.getParameter("courseId");
        String status = request.getParameter("status");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String sort = request.getParameter("sort");

        // Lọc
        if (searchEmail != null && !searchEmail.isEmpty()) {
            registrationList = registrationList.stream()
                .filter(r -> r.getUserEmail() != null && r.getUserEmail().toLowerCase().contains(searchEmail.toLowerCase()))
                .collect(java.util.stream.Collectors.toList());
        }
        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdStr);
                registrationList = registrationList.stream()
                    .filter(r -> r.getCourse() != null && r.getCourse().getCourseID() == courseId)
                    .collect(java.util.stream.Collectors.toList());
            } catch (NumberFormatException ignored) {}
        }
        if (status != null && !status.isEmpty()) {
            registrationList = registrationList.stream()
                .filter(r -> status.equalsIgnoreCase(r.getStatus()))
                .collect(java.util.stream.Collectors.toList());
        }
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (fromDate != null && !fromDate.isEmpty()) {
            registrationList = registrationList.stream()
                .filter(r -> {
                    try {
                        return LocalDate.parse(r.getValidFrom().substring(0, 10), dtf).compareTo(LocalDate.parse(fromDate, dtf)) >= 0;
                    } catch (Exception e) { return true; }
                })
                .collect(java.util.stream.Collectors.toList());
        }
        if (toDate != null && !toDate.isEmpty()) {
            registrationList = registrationList.stream()
                .filter(r -> {
                    try {
                        return LocalDate.parse(r.getValidFrom().substring(0, 10), dtf).compareTo(LocalDate.parse(toDate, dtf)) <= 0;
                    } catch (Exception e) { return true; }
                })
                .collect(java.util.stream.Collectors.toList());
        }

        // Sắp xếp
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "id_asc":
                    registrationList.sort(java.util.Comparator.comparingInt(model.Registration::getRegistrationID));
                    break;
                case "id_desc":
                    registrationList.sort(java.util.Comparator.comparingInt(model.Registration::getRegistrationID).reversed());
                    break;
                case "email_asc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getUserEmail, java.util.Comparator.nullsLast(String::compareToIgnoreCase)));
                    break;
                case "email_desc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getUserEmail, java.util.Comparator.nullsLast(String::compareToIgnoreCase)).reversed());
                    break;
                case "date_asc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidFrom, java.util.Comparator.nullsLast(String::compareTo)));
                    break;
                case "date_desc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidFrom, java.util.Comparator.nullsLast(String::compareTo)).reversed());
                    break;
                case "subject_asc":
                    registrationList.sort(java.util.Comparator.comparing(r -> r.getCourse() != null ? r.getCourse().getSubjectID() : 0));
                    break;
                case "subject_desc":
                    registrationList.sort(java.util.Comparator.comparing((model.Registration r) -> r.getCourse() != null ? r.getCourse().getSubjectID() : 0).reversed());
                    break;
                case "package_asc":
                    registrationList.sort(java.util.Comparator.comparing(r -> r.getPricePackage() != null ? r.getPricePackage().getName() : ""));
                    break;
                case "package_desc":
                    registrationList.sort(java.util.Comparator.comparing((model.Registration r) -> r.getPricePackage() != null ? r.getPricePackage().getName() : "").reversed());
                    break;
                case "price_asc":
                    registrationList.sort(java.util.Comparator.comparingInt(r -> r.getPricePackage() != null ? r.getPricePackage().getSalePrice() : 0));
                    break;
                case "price_desc":
                    registrationList.sort(java.util.Comparator.comparingInt((model.Registration r) -> r.getPricePackage() != null ? r.getPricePackage().getSalePrice() : 0).reversed());
                    break;
                case "status_asc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getStatus, java.util.Comparator.nullsLast(String::compareToIgnoreCase)));
                    break;
                case "status_desc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getStatus, java.util.Comparator.nullsLast(String::compareToIgnoreCase)).reversed());
                    break;
                case "from_asc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidFrom, java.util.Comparator.nullsLast(String::compareTo)));
                    break;
                case "from_desc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidFrom, java.util.Comparator.nullsLast(String::compareTo)).reversed());
                    break;
                case "to_asc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidTo, java.util.Comparator.nullsLast(String::compareTo)));
                    break;
                case "to_desc":
                    registrationList.sort(java.util.Comparator.comparing(model.Registration::getValidTo, java.util.Comparator.nullsLast(String::compareTo)).reversed());
                    break;
            }
        }

        // Phân trang
        int pageSize = 10;
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        int totalRecords = registrationList.size();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalRecords);
        List<Registration> paginatedList = registrationList;
        if (fromIndex < totalRecords) {
            paginatedList = registrationList.subList(fromIndex, toIndex);
        } else {
            paginatedList = new ArrayList<>();
        }
        request.setAttribute("registrationList", paginatedList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Thống kê
        int totalRegistrations = registrationList.size();
        int pendingCount = 0, approvedCount = 0, notApprovedCount = 0;
        for (Registration reg : registrationList) {
            switch (reg.getStatus()) {
                case "Pending": pendingCount++; break;
                case "Approved": approvedCount++; break;
                case "NotApproved": notApprovedCount++; break;
            }
        }
        request.setAttribute("totalRegistrations", totalRegistrations);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("notApprovedCount", notApprovedCount);

        // Forward tới JSP
        request.getRequestDispatcher("/adminPages/adminRegistrationList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String regIdStr = request.getParameter("registrationID");
            String newStatus = request.getParameter("newStatus");
            if (regIdStr != null && newStatus != null && (newStatus.equals("Approved") || newStatus.equals("NotApproved"))) {
                try {
                    int regId = Integer.parseInt(regIdStr);
                    RegistrationDAO dao = new RegistrationDAO();
                    // Chỉ cho phép cập nhật nếu trạng thái hiện tại là Pending
                    List<Registration> regs = dao.getAllRegistrationsForAdmin();
                    Registration reg = regs.stream().filter(r -> r.getRegistrationID() == regId).findFirst().orElse(null);
                    if (reg != null && "Paid".equals(reg.getStatus())) {
                        // Nếu chọn NotApproved thì lưu là NotApproved trong DB
                        String dbStatus = newStatus.equals("NotApproved") ? "NotApproved" : "Approved";
                        dao.updateRegistrationStatus(regId, dbStatus);
                        request.setAttribute("message", "Status updated successfully!");
                    } else {
                        request.setAttribute("error", "Only registrations in Paid status can be approved.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid ID.");
                }
            } else {
                request.setAttribute("error", "Missing information or invalid status.Missing information or invalid status.");
            }
        }
        // Sau khi xử lý, load lại danh sách
        doGet(request, response);
    }
} 