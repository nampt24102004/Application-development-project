<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý đăng ký khóa học - Admin</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #fff;
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                background: white;
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .header {
                background: linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%);
                color: white;
                padding: 30px;
                text-align: center;
            }
            .headertitle{
                background: white;
                color: blue;
                padding: 30px;
                text-align: center;
            }


            .header h1 {
                font-size: 2.5rem;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .header p {
                font-size: 1.1rem;
                opacity: 0.9;
            }

            .content {
                padding: 30px;
            }

            .stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                border: 1px solid #e2e8f0;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: bold;
                color: #4F46E5;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #64748b;
                font-size: 0.9rem;
            }

            .table-container {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            th {
                background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
                color: #334155;
                font-weight: 600;
                padding: 15px 12px;
                text-align: left;
                border-bottom: 2px solid #e2e8f0;
                position: sticky;
                top: 0;
                z-index: 10;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #f1f5f9;
                vertical-align: top;
            }

            tr:hover {
                background-color: #f8fafc;
            }

            .user-info {
                background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
                padding: 10px;
                border-radius: 8px;
                border-left: 4px solid #3b82f6;
            }

            .user-info div {
                margin-bottom: 5px;
            }

            .user-info strong {
                color: #1e40af;
            }

            .course-info {
                color: #059669;
                font-weight: 500;
            }

            .package-info {
                color: #7c3aed;
                font-weight: 500;
            }

            .cost-info {
                font-weight: bold;
                color: #dc2626;
                font-size: 1.1rem;
            }

            .status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background: #fef3c7;
                color: #d97706;
            }

            .status-approved {
                background: #d1fae5;
                color: #059669;
            }

            .status-rejected {
                background: #fee2e2;
                color: #dc2626;
            }

            .status-cancelled {
                background: #f3f4f6;
                color: #6b7280;
            }

            .success-message {
                background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
                color: #065f46;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                border-left: 4px solid #10b981;
            }

            .error-message {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #991b1b;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                border-left: 4px solid #ef4444;
            }

            .access-denied {
                background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                color: #92400e;
                padding: 30px;
                border-radius: 10px;
                text-align: center;
                margin: 50px auto;
                max-width: 500px;
                border-left: 4px solid #f59e0b;
            }

            .empty-message {
                text-align: center;
                padding: 40px;
                color: #64748b;
                font-size: 1.1rem;
            }

            .date-info {
                font-size: 12px;
                color: #64748b;
            }

            .login-link {
                display: inline-block;
                background: #4F46E5;
                color: white;
                padding: 12px 24px;
                text-decoration: none;
                border-radius: 8px;
                margin-top: 15px;
                transition: background 0.3s;
            }

            .login-link:hover {
                background: #3730a3;
            }

            @media (max-width: 768px) {
                .container {
                    margin: 10px;
                    border-radius: 10px;
                }

                .header {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 2rem;
                }

                .content {
                    padding: 20px;
                }

                .stats {
                    grid-template-columns: 1fr;
                }

                table {
                    font-size: 12px;
                }

                th, td {
                    padding: 8px 6px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="../userPages/components/header.jsp" />
        <div class="container">
            <div class="headertitle">
                <h1>📊 Course Registration</h1>
            </div>
            <div class="content">
                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="success-message">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <!-- Thống kê -->
                <div class="stats">
                    <div class="stat-card">
                        <div class="stat-number">${totalRegistrations}</div>
                        <div class="stat-label">Total registration</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${pendingCount}</div>
                        <div class="stat-label">Pending approval</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${approvedCount}</div>
                        <div class="stat-label">Accepted</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${notApprovedCount}</div>
                        <div class="stat-label">Not Approved</div>
                    </div>
                </div>
                <!-- Bảng đăng ký -->
                <div class="table-container">
                    <form method="get" style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end;">
                        <div>
                            <label for="searchEmail">Email:</label><br>
                            <input type="text" id="searchEmail" name="searchEmail" value="${param.searchEmail}" placeholder="Search by email..." style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd; min-width: 180px;">
                        </div>
                        <div>
                            <label for="courseId">Course:</label><br>
                            <select id="courseId" name="courseId" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd; min-width: 140px;">
                                <option value="">All</option>
                                <c:forEach var="c" items="${courseList}">
                                    <option value="${c.courseID}" <c:if test='${param.courseId == c.courseID}'>selected</c:if>>${c.courseTitle}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="status">Status:</label><br>
                            <select id="status" name="status" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd; min-width: 120px;">
                                <option value="">All</option>
                                <c:forEach var="st" items="${statusList}">
                                    <option value="${st}" <c:if test='${param.status == st}'>selected</c:if>>${st}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="fromDate">From:</label><br>
                            <input type="date" id="fromDate" name="fromDate" value="${param.fromDate}" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd;">
                        </div>
                        <div>
                            <label for="toDate">To:</label><br>
                            <input type="date" id="toDate" name="toDate" value="${param.toDate}" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd;">
                        </div>
                        <div>
                            <label for="sort">Sort by:</label><br>
                            <select id="sort" name="sort" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #bcd; min-width: 140px;">
                                <c:forEach var="s" items="${sortList}">
                                    <option value="${s.value}" <c:if test='${param.sort == s.value}'>selected</c:if>>${s.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <button type="submit" style="padding: 8px 18px; border-radius: 7px; background: #4F46E5; color: #fff; border: none; font-weight: 600; font-size: 1em; cursor: pointer;">Search</button>
                        </div>
                    </form>
                    <table>
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>User Information</th>
                                <th>Course</th>
                                <th>Package</th>
                                <th>Value</th>
                                <th>Status</th>
                                <th>Validity period</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reg" items="${registrationList}" varStatus="loop">
                                <tr>
                                    <td><strong>${loop.index + 1}</strong></td>
                                    <td>
                                        <div class="user-info">
                                            <div><strong>👤 Full Name:</strong> ${reg.userFullName}</div>
                                            <div><strong>📧 Email:</strong> ${reg.userEmail}</div>
                                            <div><strong>📞 Phone:</strong> ${reg.userPhone}</div>
                                        </div>
                                    </td>
                                    <td class="course-info">📚 ${reg.course.courseTitle}</td>
                                    <td class="package-info">📦 ${reg.pricePackage.name}</td>
                                    <td class="cost-info">💰 ${reg.pricePackage.salePrice} VNĐ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${reg.status eq 'Paid'}">
                                                <div style="margin-bottom: 4px; color: #2563eb; font-weight: 600;">Paid</div>
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="updateStatus" />
                                                    <input type="hidden" name="registrationID" value="${reg.registrationID}" />
                                                    <select name="newStatus" required>
                                                        <option value="Approved" style="color: #059669;">Approved</option>
                                                        <option value="NotApproved" style="color: #dc2626;">NotApproved</option>
                                                    </select>
                                                    <button type="submit">Update</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status status-${reg.status.toLowerCase()}" style="<c:if test='${reg.status eq "NotApproved" || reg.status eq "Rejected"}'>color: #dc2626;</c:if>">
                                                    <c:choose>
                                                        <c:when test="${reg.status eq 'Rejected'}">NotApproved</c:when>
                                                        <c:otherwise>${reg.status}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            <div><strong>From:</strong> ${reg.validFrom}</div>
                                            <div><strong>To:</strong> ${reg.validTo}</div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty registrationList}">
                        <div class="empty-message">
                            <h3>No registrations yet</h3>
                            <p>There are currently no users registered for the course.</p>
                        </div>
                    </c:if>
                </div>
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div style="display: flex; justify-content: center; margin-top: 24px; gap: 8px;">
                        <c:if test="${currentPage > 1}">
                            <form method="get" style="display:inline;">
                                <input type="hidden" name="page" value="${currentPage - 1}" />
                                <c:forEach var="paramName" items="${paramValues.keySet()}">
                                    <c:if test="${paramName ne 'page'}">
                                        <input type="hidden" name="${paramName}" value="${param[paramName]}" />
                                    </c:if>
                                </c:forEach>
                                <button type="submit">Previous</button>
                            </form>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <form method="get" style="display:inline;">
                                <input type="hidden" name="page" value="${i}" />
                                <c:forEach var="paramName" items="${paramValues.keySet()}">
                                    <c:if test="${paramName ne 'page'}">
                                        <input type="hidden" name="${paramName}" value="${param[paramName]}" />
                                    </c:if>
                                </c:forEach>
                                <button type="submit" <c:if test="${i == currentPage}">style='font-weight:bold; background:#4F46E5; color:#fff;'</c:if>>${i}</button>
                                </form>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <form method="get" style="display:inline;">
                                <input type="hidden" name="page" value="${currentPage + 1}" />
                                <c:forEach var="paramName" items="${paramValues.keySet()}">
                                    <c:if test="${paramName ne 'page'}">
                                        <input type="hidden" name="${paramName}" value="${param[paramName]}" />
                                    </c:if>
                                </c:forEach>
                                <button type="submit">Next</button>
                            </form>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
        <jsp:include page="../userPages/components/footer.jsp" />
    </body>
</html> 