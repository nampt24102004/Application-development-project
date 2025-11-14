package controller;

import dao.SubjectDAO;
import dao.RegistrationDAO;
import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DashboardStatsDTO;
import model.DashboardStatsDTO.TrendPoint;


import java.io.IOException;
import java.math.BigDecimal;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.List;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private final SubjectDAO subjDAO   = new SubjectDAO();
    private final RegistrationDAO regDAO = new RegistrationDAO();
    private final AccountDAO acctDAO   = new AccountDAO();
    private final DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // Lấy from/to từ query params hoặc default last 7 days
        String fromS = req.getParameter("from");
        String toS   = req.getParameter("to");
        LocalDate to   = (toS == null ? LocalDate.now() : LocalDate.parse(toS, fmt));
        LocalDate from = (fromS == null ? to.minusDays(6) : LocalDate.parse(fromS, fmt));

        LocalDateTime fromDt = from.atStartOfDay();
        LocalDateTime toDt   = to.plusDays(1).atStartOfDay().minusSeconds(1);

        try {
            // 1. Subjects
            long newSubjects   = subjDAO.countNewSubjects(fromDt, toDt);
            long totalSubjects = subjDAO.countAllSubjects();

            // 2. Registrations
            long regSuccess   = regDAO.countByStatus("Approved",    fromDt, toDt);
            long regSubmitted = regDAO.countByStatus("Pending",     fromDt, toDt);
            long regCancelled = regDAO.countByStatus("NotApproved", fromDt, toDt);

            // 3. Revenues
            BigDecimal totalRevenue      = regDAO.totalRevenue(fromDt, toDt);
            Map<String, BigDecimal> revByCat = regDAO.revenueByCategory(fromDt, toDt);

            // 4. Customers
            long newCustomers      = acctDAO.countNewCustomers(fromDt, toDt);
            long newBuyingCustomers= acctDAO.countNewBuyingCustomers(fromDt, toDt);

            // 5. Order trend
            List<TrendPoint> trend = regDAO.findOrderTrend(fromDt, toDt);

            // Gom vào DTO
            DashboardStatsDTO stats = new DashboardStatsDTO();
            stats.setNewSubjects(newSubjects);
            stats.setTotalSubjects(totalSubjects);
            stats.setRegSuccess(regSuccess);
            stats.setRegSubmitted(regSubmitted);
            stats.setRegCancelled(regCancelled);
            stats.setTotalRevenue(totalRevenue);
            stats.setRevenueByCategory(revByCat);
            stats.setNewCustomers(newCustomers);
            stats.setNewBuyingCustomers(newBuyingCustomers);
            stats.setOrderTrend(trend);
            
            System.out.println("===== Dashboard Debug =====");
System.out.println("newSubjects   = " + newSubjects);
System.out.println("totalSubjects = " + totalSubjects);
System.out.println("regSuccess    = " + regSuccess);
System.out.println("regSubmitted  = " + regSubmitted);
System.out.println("regCancelled  = " + regCancelled);
System.out.println("totalRevenue  = " + totalRevenue);
System.out.println("revByCat      = " + revByCat);
System.out.println("newCustomers  = " + newCustomers);
System.out.println("newBuyingCust = " + newBuyingCustomers);
System.out.println("orderTrend    = " + trend);

            // Đẩy về JSP
            req.setAttribute("dashboardStats", stats);
            req.setAttribute("defaultFrom", from.format(fmt));
            req.setAttribute("defaultTo",   to.format(fmt));
            req.getRequestDispatcher("/userPages/dashboard.jsp")
               .forward(req, resp);

        } catch (Exception ex) {
            throw new ServletException("Lỗi khi load Dashboard data", ex);
        }
    }
}
