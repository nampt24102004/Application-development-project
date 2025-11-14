<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
            rel="stylesheet"
            >
        <link 
            rel="stylesheet" 
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
            >
        <style>
            html, body {

                margin:0;
                height:100%;
            }
            body {
                display:flex;
                flex-direction:column;
            }

            /* HEADER và FOOTER */
            .header {
    background: #1e88e5;
    color: white;
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.logo-img {
    height: 40px !important;
    width: auto !important;
    max-width: 100%;
    padding: 2px !important;
    border-radius: 6px !important;
    background: rgba(255,255,255,0.15) !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2) !important;
    margin-right: .75rem;
}
           
            

.page-body {
    flex: 1;
    display: flex;
    overflow: auto; /* tránh cắt header */
}

            /* Sidebar */
            #sidebar {
                flex: 0 0 240px;       /* fix width 220px */
                background: #2c3e50;
                color: #ccc;
                overflow-y: auto;
            }
            /* Main */
            #main {
                flex: 1;               /* chiếm hết phần còn lại */
                padding: 1rem;
                background: #f8f9fa;
                overflow-y: auto;
            }
            footer.app-footer {
                background: #0d6efd;
                color: #fff;
                height: 40px;
                line-height: 40px;    /* căn giữa vertical */
                text-align: center;
                flex-shrink: 0;       /* không co lại khi flex */
                width: 100%;
            }
            
        </style>

    </head>
    <body>

        <jsp:include page="components/header.jsp"/>


        <div class="d-flex">
            <!-- Sidebar -->
            <nav id="sidebar" class="d-flex flex-column p-3">
                <div class="text-center mb-4">
                    <img src="${sessionScope.avatarUrl != null 
                                ? sessionScope.avatarUrl 
                                : 'images/avatar-default.png'}"
                         alt="Avatar"
                         class="avatar"width="64" height="64"> 

                    <div class="mt-2 text-white">Hello!</div>
                    <small class="text-success">● Online</small>
                </div>
                <ul class="nav nav-pills flex-column mb-auto">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="nav-link active">
                            <i class="bi bi-speedometer2 me-2"></i>Dashboard
                        </a>
                    </li>
                    <li><a href="#" class="nav-link"><i class="bi bi-gear me-2"></i>Settings List</a></li>
                    <li><a href="${pageContext.request.contextPath}/AdminUserListServlet" class="nav-link"><i class="bi bi-journal-check me-2"></i>User List</a></li>
                    <li><a href="${pageContext.request.contextPath}/SubjectList" class="nav-link"><i class="bi bi-card-list me-2"></i>Subject List</a></li>
                    <li><a href="#" class="nav-link"><i class="bi bi-journal-check me-2"></i>Slider List</a></li>
                    <li><a href="${pageContext.request.contextPath}/AdminRegistrationListServlet" class="nav-link"><i class="bi bi-journal-check me-2"></i>Registrations List</a></li>
                    <li><a href="${pageContext.request.contextPath}/QuestionListServlet" class="nav-link"><i class="bi bi-card-list me-2"></i>Question List</a></li>






                </ul>
                <div class="mt-auto text-center text-muted">
                    © 2025 YourApp
                </div>
            </nav>

            <!-- Main content -->
            <div id="main" class="flex-fill">
                <div class="container-fluid">
                    <!-- Filter -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1>📊 Dashboard</h1>
                        <form class="row g-2" method="get">
                            <div class="col-auto">
                                <input type="date" name="from" 
       value="${not empty param.from ? param.from : defaultFrom}" 
       class="form-control form-control-sm"/>
                            </div>
                            <div class="col-auto align-self-center">to</div>
                            <div class="col-auto">
                                <input type="date" name="to" 
       value="${not empty param.to ? param.to : defaultTo}" 
       class="form-control form-control-sm"/>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary btn-sm">Apply</button>
                            </div>
                        </form>
                    </div>

                    <!-- Stat Cards -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <div class="card text-center p-3 shadow-sm">
                                <i class="bi bi-book stat-icon text-primary"></i>
                                <div class="h2 text-primary">${dashboardStats.newSubjects}</div>
                                <div class="text-muted">New Subjects</div>
                                <small>Total: ${dashboardStats.totalSubjects}</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center p-3 shadow-sm">
                                <i class="bi bi-pencil-square stat-icon text-success"></i>
                                <div class="h2 text-success">${dashboardStats.regSuccess}</div>
                                <div class="text-muted">Registrations</div>
                                <small>Submitted: ${dashboardStats.regSubmitted}</small><br>
                                <small>Cancelled: ${dashboardStats.regCancelled}</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card shadow-sm">
                                <div class="card-body text-center">
                                    <i class="bi bi-currency-dollar stat-icon text-warning"></i>
                                    <div class="h2 text-warning">$${dashboardStats.totalRevenue}</div>
                                    <div class="text-muted">Revenues</div>
                                </div>
                                <ul class="list-group list-group-flush">
                                    <c:forEach var="e" items="${dashboardStats.revenueByCategory}">
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span>${e.key}</span><span>$${e.value}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>  
                        <div class="col-md-3">
                            <div class="card text-center p-3 shadow-sm">
                                <i class="bi bi-people stat-icon text-info"></i>
                                <div class="h2 text-info">${dashboardStats.newCustomers}</div>
                                <div class="text-muted">New Customers</div>
                                <small>First-time Buyers: ${dashboardStats.newBuyingCustomers}</small>
                            </div>
                        </div>
                    </div>

                    <!-- Chart -->
                    <div class="card shadow-sm mb-4">
                        <div class="card-header">Order Counts (Last 7 Days)</div>
                        <div class="card-body">
                            <canvas id="orderChart" height="100"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const labels = [<c:forEach var="pt" items="${dashboardStats.orderTrend}" varStatus="st">'${pt.date}'<c:if test="${!st.last}">,</c:if></c:forEach>];
                    const dataSuccess = [<c:forEach var="pt" items="${dashboardStats.orderTrend}" varStatus="st">${pt.successCount}<c:if test="${!st.last}">,</c:if></c:forEach>];
            const dataTotal = [<c:forEach var="pt" items="${dashboardStats.orderTrend}" varStatus="st">${pt.totalCount}<c:if test="${!st.last}">,</c:if></c:forEach>];

            new Chart(
                    document.getElementById('orderChart').getContext('2d'),
                    {
                        type: 'line',
                        data: {labels, datasets: [
                                {label: 'Success', data: dataSuccess, borderWidth: 2, tension: 0.3},
                                {label: 'All', data: dataTotal, borderWidth: 2, tension: 0.3}
                            ]},
                        options: {
                            scales: {y: {beginAtZero: true}},
                            plugins: {legend: {position: 'bottom'}}
                        }
                    }
            );
                </script>
        <jsp:include page="components/footer.jsp"/>
    </body>
</html>
