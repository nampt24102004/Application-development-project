<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Registration" %>
<%@ page import="model.Course" %>
<%@ page import="model.PricePackage" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Course payment</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Header */
            .header {
                background: #1e88e5;
                color: white;
                padding: 15px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            /* Phần logo và tên (từ header-left gốc) */
            .header-left {
                display: flex;
                align-items: center;
                gap: 16px; /* khoảng cách giữa logo và chữ */
            }
            .logo-img {
                height: 40px !important;
                width: auto !important;
                max-width: 100%;
                padding: 2px !important;
                border-radius: 6px !important;
                background: rgba(255,255,255,0.15) !important;
                box-shadow: 0 2px 8px rgba(0,0,0,0.2) !important;
            }
            .logo-text {
                font-size: 2.1em;
                font-weight: 700;
                color: #fff;
                letter-spacing: 1.5px;
                font-family: inherit;
                line-height: 1;
            }
            .header .nav {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .header .nav a {
                color: white;
                text-decoration: none;
                font-size: 16px;
                font-weight:bold;
            }
            .header .nav a:hover {
                text-decoration: underline;
            }
            .header .nav .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                cursor: pointer;
                object-fit: cover;
            }
            body {
                background: #f5faff;
                font-family: Arial, sans-serif;
            }
            .payment-container {
                max-width: 600px;
                margin: 40px auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                padding: 32px;
            }
            .payment-title {
                color: #0d6efd;
                font-weight: bold;
                margin-bottom: 24px;
                text-align: center;
            }
            .info-label {
                font-weight: 600;
                color: #333;
            }
            .info-value {
                color: #1e88e5;
                font-size: 1.1em;
            }
            .pay-btn {
                width: 100%;
                margin-top: 32px;
                font-size: 1.2em;
                padding: 12px;
                border-radius: 8px;
            }
            .summary-table {
                width: 100%;
                margin-bottom: 0;
            }
            .summary-table th, .summary-table td {
                padding: 10px 8px;
            }
            .summary-table th {
                background: #e3f0fc;
                color: #0d6efd;
            }
            .summary-table td {
                background: #f8fbff;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header">
            <!-- Logo + tên -->
            <div class="header-left">
                <img class="logo-img" src="images/HeaderIcon.png" alt="Logo">
                <span class="logo-text">CourseAura</span>
            </div>
            <div class="nav">
                <a href="${pageContext.request.contextPath}/HomeServlet">Home</a>
                <a href="${pageContext.request.contextPath}/MyCourseServlet">My Courses</a>
                <a href="${pageContext.request.contextPath}/MyRegistration">Registration</a>
                <a href="${pageContext.request.contextPath}/BlogListServlet">Blog</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            </div>
        </div>
        <div class="content-wrapper">


            <!-- Main Content -->
            <div class="main">
                <div class="payment-container">
                    <h2 class="payment-title">Course payment</h2>
                    <table class="summary-table">
                        <tr>
                            <th class="info-label">Course name</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    ${registration.course.courseTitle}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="info-label">Package</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    ${registration.pricePackage.name}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="info-label">Price</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    $${registration.pricePackage.salePrice}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="info-label">Valid from</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    ${registration.validFrom}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="info-label">Valid to</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    ${registration.validFrom} - ${registration.validTo}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="info-label">Status</th>
                            <td class="info-value">
                                <c:if test="${not empty registration}">
                                    <c:choose>
                                        <c:when test="${registration.status eq 'Paid'}">Pending processing</c:when>
                                        <c:when test="${registration.status eq 'Approved'}">Confirmed</c:when>
                                        <c:when test="${registration.status eq 'NotApproved'}">Rejected</c:when>
                                        <c:when test="${registration.status eq 'Pending'}">Processing</c:when>
                                        <c:otherwise>${registration.status}</c:otherwise>
                                    </c:choose>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                    <c:if test="${ registration.status eq 'Pending'}">
                        <form method="post" action="PaymentServlet" onsubmit="return disableSubmitButton(this);">
                            <input type="hidden" name="registrationID" value="${registration.registrationID}" />
                            <button type="submit" class="btn btn-primary pay-btn" id="confirmBtn">Payment Confirm</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
    <script>
        function disableSubmitButton(form) {
            const btn = form.querySelector('button[type="submit"]');
            if (btn) {
                btn.disabled = true;
                btn.innerText = "Processing...";
            }
            return true; // allow form submit
        }
    </script>

</html> 