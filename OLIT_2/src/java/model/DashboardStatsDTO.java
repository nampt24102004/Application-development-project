/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author khain
 */


import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;



public class DashboardStatsDTO {
    // 1. Subjects
    private long newSubjects;
    private long totalSubjects;

    // 2. Registrations
    private long regSuccess;
    private long regSubmitted;
    private long regCancelled;

    // 3. Revenues
    private BigDecimal totalRevenue;
    private Map<String, BigDecimal> revenueByCategory;

    // 4. Customers
    private long newCustomers;
    private long newBuyingCustomers;

    // 5. Order trend
    private List<TrendPoint> orderTrend;

    public DashboardStatsDTO() {
        // default constructor
    }

    // === Getters & Setters ===

    public long getNewSubjects() {
        return newSubjects;
    }
    public void setNewSubjects(long newSubjects) {
        this.newSubjects = newSubjects;
    }

    public long getTotalSubjects() {
        return totalSubjects;
    }
    public void setTotalSubjects(long totalSubjects) {
        this.totalSubjects = totalSubjects;
    }

    public long getRegSuccess() {
        return regSuccess;
    }
    public void setRegSuccess(long regSuccess) {
        this.regSuccess = regSuccess;
    }

    public long getRegSubmitted() {
        return regSubmitted;
    }
    public void setRegSubmitted(long regSubmitted) {
        this.regSubmitted = regSubmitted;
    }

    public long getRegCancelled() {
        return regCancelled;
    }
    public void setRegCancelled(long regCancelled) {
        this.regCancelled = regCancelled;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }
    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Map<String, BigDecimal> getRevenueByCategory() {
        return revenueByCategory;
    }
    public void setRevenueByCategory(Map<String, BigDecimal> revenueByCategory) {
        this.revenueByCategory = revenueByCategory;
    }

    public long getNewCustomers() {
        return newCustomers;
    }
    public void setNewCustomers(long newCustomers) {
        this.newCustomers = newCustomers;
    }

    public long getNewBuyingCustomers() {
        return newBuyingCustomers;
    }
    public void setNewBuyingCustomers(long newBuyingCustomers) {
        this.newBuyingCustomers = newBuyingCustomers;
    }

    public List<TrendPoint> getOrderTrend() {
        return orderTrend;
    }
    public void setOrderTrend(List<TrendPoint> orderTrend) {
        this.orderTrend = orderTrend;
    }

    // === Inner class TrendPoint ===
    public static class TrendPoint {
        private LocalDate date;
        private long totalCount;
        private long successCount;

        public TrendPoint(LocalDate date, long totalCount, long successCount) {
            this.date = date;
            this.totalCount = totalCount;
            this.successCount = successCount;
        }

        public LocalDate getDate() {
            return date;
        }
        public void setDate(LocalDate date) {
            this.date = date;
        }

        public long getTotalCount() {
            return totalCount;
        }
        public void setTotalCount(long totalCount) {
            this.totalCount = totalCount;
        }

        public long getSuccessCount() {
            return successCount;
        }
        public void setSuccessCount(long successCount) {
            this.successCount = successCount;
        }
    }
}



