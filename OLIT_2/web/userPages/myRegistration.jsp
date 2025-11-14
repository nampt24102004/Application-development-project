<%-- 
    Document   : myRegistration
    Created on : Jun 2, 2025, 10:25:29 PM
    Author     : Nam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Registration" %>
<%@ page import="model.Course" %>
<%@ page import="model.PricePackage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>My Registration</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            html,
            body {
                height: 100%;
                margin: 0;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f5faff;
                display: flex;
                flex-direction: column;
            }

            main {
                flex: 1;
                padding: 20px;
                padding-bottom: 100px;
                /* chừa chỗ cho button cố định */
            }

 
           /* Header */
            .header {
                background-color: #1e88e5;
                color: white;
                padding: 15px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .header .logo {
                font-size: 24px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .header .nav {
                display: flex;
                gap: 20px;
            }

            .header .nav a {
                color: white;
                text-decoration: none;
                font-size: 16px;
                transition: color 0.3s;
            }

            .header .nav a:hover {
                color: #bbdefb;
            }
            .header {
                background-color: #1E88E5;
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
                height: 54px;       /* chiều cao logo */
                width: auto;
                padding: 4px;       /* khoảng trắng quanh icon */
                border-radius: 8px;
                background: rgba(255,255,255,0.15);
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                display: block;
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
                    gap: 10px;
                }

                .header .nav a {
                    font-size: 16px;
                    font-weight: bold;
                }
            h3 {
                color: #0d6efd;
                font-weight: bold;
                margin-bottom: 25px;
            }

            table {
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            thead.table-dark {
                background-color: #0d6efd !important;
            }

            .table thead th {
                color: white;
                text-align: center;
                vertical-align: middle;
            }

            .table td {
                vertical-align: middle;
                text-align: center;
            }

            .cancel-btn {
                background-color: #dc3545;
                border: none;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 4px;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .cancel-btn:hover {
                background-color: #bb2d3b;
            }

            .form-control,
            .form-select {
                background-color: #e0f4ff;
                border: 1px solid #7ec8e3;
                border-radius: 6px;
                color: #333;
                transition: border-color 0.3s ease;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 5px rgba(13, 110, 253, 0.3);
            }

            label.form-label {
                font-weight: bold;
                color: #333;
            }


            .bottom-left-btn {
                height: 40px;
                left: 30px;
                background-color: #6c757d;
                color: white;
            }

            .bottom-right-btn {
                height: 40px;
                right: 30px;
                background-color: #0d6efd;
                color: white;
            }



            .bottom-left-btn:hover {
                background-color: #5c636a;
            }

            .bottom-right-btn:hover {
                background-color: #0b5ed7;
            }
            @media (max-width: 768px) {
                header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .bottom-left-btn,
                .bottom-right-btn {
                    bottom: 100px;
                    /* Adjusted for mobile to avoid footer */
                    padding: 8px 14px;
                    font-size: 14px;
                }
                .mb-3-filter{
                    display: none;
                }
            }
        </style>
    </head>

    <body>
        <header>

            <div class="header">
                <!-- Logo + tên -->
                <div class="header-left">
                    <img class="logo-img" src="images/HeaderIcon.png" alt="Logo">
                    <span class="logo-text">CourseAura</span>
                </div>
                            <div class="nav">
                <a href="${pageContext.request.contextPath}/HomeServlet">Home</a>
                <a href="${pageContext.request.contextPath}/MyCourseServlet">MyCourses</a>
                <a href="${pageContext.request.contextPath}/BlogListServlet">Blog</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
                
            </div>
        </header>

        <main>
            <div class="container-fluid">
                <h3 class="mb-4">My Registration</h3>
                <% if (session.getAttribute("message") != null) { 
   String type = (String)session.getAttribute("messageType"); 
   String alertClass = "alert-success";
   String customStyle = "background-color:#e6f9ed;color:#155724;";
   if ("error".equals(type)) {
       alertClass = "alert-danger";
       customStyle = "background-color:#ffeaea;color:#b71c1c;";
   }
%>
<div class="alert <%= alertClass %>" style="margin-bottom:18px; text-align:center; font-weight:500; <%= customStyle %>">
    <%= session.getAttribute("message") %>
</div>
<% session.removeAttribute("message"); session.removeAttribute("messageType"); } %>
                <div class="row">
                    <!-- Left Section: Course List -->
                    <div class="col-md-9">
                        <table class="table table-bordered table-striped align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>STT</th>
                                    <th>Course</th>
                                    <th>Registration Time</th>
                                    <th>Package</th>
                                    <th>Total Cost</th>
                                    <th>Status</th>
                                    <th>Valid From</th>
                                    <th>Valid To</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Registration> registrations = (List<Registration>) request.getAttribute("registrations");
                                    int currentPage = (Integer) request.getAttribute("currentPage");
                                    int recordsPerPage = 6; // Cần đảm bảo giá trị này khớp với servlet
                                    int startingStt = (currentPage - 1) * recordsPerPage + 1;

                                    // Sắp xếp danh sách: Pending lên đầu, sau đó theo registrationID giảm dần
                                    if (registrations != null) {
                                        Collections.sort(registrations, new Comparator<Registration>() {
                                            @Override
                                            public int compare(Registration r1, Registration r2) {
                                                boolean isPending1 = "Pending".equalsIgnoreCase(r1.getStatus());
                                                boolean isPending2 = "Pending".equalsIgnoreCase(r2.getStatus());
                                                if (isPending1 && !isPending2) return -1;
                                                if (!isPending1 && isPending2) return 1;
                                                return Integer.compare(r2.getRegistrationID(), r1.getRegistrationID());
                                            }
                                        });
                                    }
                                    
                                    if (registrations != null) {
                                        for (Registration r : registrations) {
                                %>
                                <tr>
                                    <td><%= startingStt++ %></td>
                                    <td><%= r.getCourse().getCourseTitle() %></td>
                                    <td><%= r.getValidFrom() %></td>
                                    <td><%= r.getPricePackage().getName() %></td>
                                    <td>$<%= r.getPricePackage().getSalePrice() %></td>
                                    <td>
                                        <span class="badge bg-<%= "Active".equals(r.getStatus()) ? "success" : "secondary" %>">
                                            <%= r.getStatus() %>
                                        </span>
                                    </td>
                                    <td><%= r.getValidFrom() %></td>
                                    <td><%= r.getValidTo() %></td>
                                    <td>
                                        <% if ("Pending".equals(r.getStatus())) { %>
                                        <form method="post" action="MyRegistration" style="display:inline;" onsubmit="return confirmCancel();">
                                            <input type="hidden" name="registrationID" value="<%= r.getRegistrationID() %>" />
                                            <input type="hidden" name="action" value="cancel" />
                                            <button type="submit" class="btn btn-danger btn-sm cancel-btn">Cancel</button>
                                        </form>
                                        <a href="PaymentServlet?registrationID=<%= r.getRegistrationID() %>" class="btn btn-success btn-sm" style="margin-left:6px;">Payment</a>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>

                        </table>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-center mt-4">
                            <nav>
                                <ul class="pagination">
                                    <!-- Prev -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="MyRegistration?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <!-- Page numbers -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="MyRegistration?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <!-- Next -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="MyRegistration?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <!-- Right Section: Filter -->
                    <div class="col-md-3">
                        <div class="mb-3">
                            <label for="search" class="form-label">Search</label>
                            <input type="text" id="search" class="form-control" placeholder="Search course...">
                        </div>
                        <div class="mb-3-filter">
                            <label for="subjectFilter" class="form-label"></label>
                            <select id="subjectFilter" class="form-select">
                                
                            </select>
                        </div>
                        <div>
                            <!-- Fixed Buttons -->
                            <a href="CourseRegisterServlet" class="bottom-right-btn" style="border-radius: 8px; display: inline-block; text-align: center; line-height: 40px; text-decoration: none;">➕ Course Register</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('search');
                const subjectFilter = document.getElementById('subjectFilter');
                const tableRows = document.querySelectorAll('tbody tr');

                function filterTable() {
                    const searchText = searchInput.value.toLowerCase().trim();
                    const selectedSubject = subjectFilter.value;

                    tableRows.forEach(row => {
                        const subject = row.cells[1].textContent.trim();
                        const matchSearch = subject.toLowerCase().includes(searchText);
                        const matchFilter = !selectedSubject || subject === selectedSubject;

                        if (matchSearch && matchFilter) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                }

                searchInput.addEventListener('input', filterTable);
                subjectFilter.addEventListener('change', filterTable);
            });

            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('course').selectedIndex = -1;
            });

            function confirmCancel() {
                return confirm('Are you sure to Register this account?');
            }

            // Tạo object: courseID -> list package
            var allPackages = {};
            <c:forEach var="pkg" items="${allPackages}">
                if (!allPackages['${pkg.courseID}']) allPackages['${pkg.courseID}'] = [];
                allPackages['${pkg.courseID}'].push({
                    id: '${pkg.packageID}',
                    name: '${pkg.name}',
                    salePrice: '${pkg.salePrice}',
                    listPrice: '${pkg.listPrice}',
                    accessDuration: '${pkg.accessDuration}'
                });
            </c:forEach>

            function updatePackages() {
                var courseId = document.getElementById('course').value;
                var packageSelect = document.getElementById('package');
                packageSelect.innerHTML = '<option value="">-- Select Package --</option>';
                if (allPackages[courseId]) {
                    allPackages[courseId].forEach(function(pkg) {
                        var opt = document.createElement('option');
                        opt.value = pkg.id;
                        opt.textContent = pkg.name + ' - $' + pkg.salePrice + (pkg.listPrice > pkg.salePrice ? ' (was $' + pkg.listPrice + ')' : '') + ' - ' + pkg.accessDuration + ' months';
                        packageSelect.appendChild(opt);
                    });
                }
            }
        </script>
        <jsp:include page="components/footer.jsp" />
    </body>

</html>