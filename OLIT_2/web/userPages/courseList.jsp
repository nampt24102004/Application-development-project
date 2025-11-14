<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Online Learn</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5faff 0%, #e8f4f8 100%);
                line-height: 1.6;
            }

            .content-wrapper {
                display: flex;
                max-width: 1400px;
                margin: 0 auto;
                padding: 30px 20px;
                gap: 30px;
                min-height: calc(100vh - 200px);
            }

            /* Sidebar Styling */
            .sidebar {
                width: 280px;
                background: linear-gradient(145deg, #1a1a1a, #2d2d2d);
                color: #fff;
                border-radius: 15px;
                padding: 25px;
                height: fit-content;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                position: sticky;
                top: 30px;
            }

            .sidebar h3 {
                margin: 0 0 20px 0;
                font-size: 18px;
                font-weight: 600;
                color: #00b4d8;
                border-bottom: 2px solid #00b4d8;
                padding-bottom: 10px;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
                margin: 0 0 30px 0;
            }

            .sidebar li {
                margin-bottom: 8px;
            }

            .sidebar a {
                color: #e0e0e0;
                text-decoration: none;
                display: block;
                padding: 12px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-size: 14px;
            }

            .sidebar a:hover {
                background: rgba(0, 180, 216, 0.2);
                color: #00b4d8;
                transform: translateX(5px);
            }

            .contact {
                background: rgba(0, 180, 216, 0.1);
                padding: 20px;
                border-radius: 10px;
                border-left: 4px solid #00b4d8;
            }

            .contact p {
                margin: 8px 0;
                font-size: 13px;
                color: #ccc;
            }

            /* Main Content */
            .main {
                flex: 1;
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            }

            /* Search Bar */
            .search-section {
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 30px;
                color: white;
            }

            .search-bar {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
            }

            .search-bar form {
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 600px;
                gap: 10px;
            }

            .search-input-wrapper {
                flex: 1;
                position: relative;
            }

            .search-bar input[type="text"] {
                width: 100%;
                padding: 15px 20px;
                border-radius: 50px;
                border: none;
                font-size: 16px;
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                outline: none;
                transition: all 0.3s ease;
            }

            .search-bar input[type="text"]:focus {
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
                transform: translateY(-1px);
            }

            .search-bar button {
                padding: 15px 20px;
                border: none;
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border-radius: 50px;
                cursor: pointer;
                font-size: 16px;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
                min-width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .search-bar button:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }

            /* Page Title */
            .page-title {
                text-align: center;
                margin-bottom: 30px;
                color: #2c3e50;
            }

            .page-title h2 {
                font-size: 32px;
                font-weight: 700;
                margin: 0;
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Course Grid */
            .course-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                gap: 25px;
                margin-bottom: 40px;
            }

            .course-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
                border: 1px solid #f0f0f0;
                position: relative;
            }

            .course-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            }

            .course-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .course-card:hover img {
                transform: scale(1.05);
            }

            .course-content {
                padding: 20px;
            }

            .course-card h3 {
                margin: 0 0 10px 0;
                font-size: 20px;
                font-weight: 600;
                color: #2c3e50;
                line-height: 1.3;
            }

            .course-tag {
                display: inline-block;
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                margin-bottom: 10px;
            }

            .course-detail {
                color: #666;
                font-size: 14px;
                margin-bottom: 15px;
                line-height: 1.5;
            }

            .course-actions {
                display: flex;
                gap: 10px;
                margin-bottom: 15px;
            }


            .btn-detail, .btn-register {
                flex: 1;
                padding: 10px 15px;
                border-radius: 8px;
                text-decoration: none;
                text-align: center;
                font-weight: 500;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .btn-detail {
                background: #f8f9fa;
                color: #495057;
                border: 1px solid #dee2e6;
            }

            .btn-detail:hover {
                background: #e9ecef;
                transform: translateY(-1px);
            }

            .btn-register {
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
                border: none;
            }

            .btn-register:hover {
                background: linear-gradient(135deg, #0077cc, #005fa3);
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(0, 119, 204, 0.3);
            }

            .course-price {
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 600;
            }

            .sale-price {
                color: #e74c3c;
                font-size: 18px;
                font-weight: 700;
            }

            .original-price {
                text-decoration: line-through;
                color: #95a5a6;
                font-size: 14px;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #666;
            }

            .empty-state i {
                font-size: 64px;
                color: #ddd;
                margin-bottom: 20px;
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin-top: 40px;
                flex-wrap: wrap;
            }

            .pagination a {
                padding: 12px 16px;
                border-radius: 8px;
                text-decoration: none;
                background: #f8f9fa;
                color: #495057;
                border: 1px solid #dee2e6;
                transition: all 0.3s ease;
                font-weight: 500;
                min-width: 44px;
                text-align: center;
            }

            .pagination a:hover {
                background: #e9ecef;
                transform: translateY(-1px);
            }

            .pagination a.active {
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
                border-color: #0077cc;
                box-shadow: 0 2px 8px rgba(0, 119, 204, 0.3);
            }

            /* Filter Popup */
            .popup-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                justify-content: center;
                align-items: center;
                z-index: 1000;
                backdrop-filter: blur(5px);
            }

            .popup-box {
                background: white;
                padding: 30px;
                border-radius: 15px;
                width: 90%;
                max-width: 400px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                position: relative;
                max-height: 90vh;
                overflow-y: auto;
            }

            .popup-box h4 {
                margin: 0 0 25px 0;
                font-size: 24px;
                color: #2c3e50;
                text-align: center;
            }

            .close-popup {
                position: absolute;
                top: 15px;
                right: 15px;
                background: #e74c3c;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 6px;
                cursor: pointer;
                font-size: 12px;
                transition: all 0.3s ease;
            }

            .close-popup:hover {
                background: #c0392b;
                transform: scale(1.05);
            }

            .popup-box label {
                display: block;
                margin: 15px 0;
                font-weight: 500;
                color: #2c3e50;
                cursor: pointer;
            }

            .popup-box input[type="radio"],
            .popup-box input[type="checkbox"] {
                margin-right: 8px;
                transform: scale(1.2);
            }

            .number-input {
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 20px 0;
            }

            .popup-box input[type="number"] {
                width: 80px;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
            }

            .filter-actions {
                display: flex;
                gap: 10px;
                margin-top: 25px;
                justify-content: center;
            }

            .filter-actions button {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .filter-actions button[type="submit"] {
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
            }

            .filter-actions button[type="submit"]:hover {
                background: linear-gradient(135deg, #0077cc, #005fa3);
                transform: translateY(-1px);
            }

            .filter-actions a {
                padding: 12px 24px;
                background: #f8f9fa;
                color: #495057;
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .filter-actions a:hover {
                background: #e9ecef;
                transform: translateY(-1px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .content-wrapper {
                    flex-direction: column;
                    padding: 20px 15px;
                }

                .sidebar {
                    width: 100%;
                    position: static;
                }

                .course-grid {
                    grid-template-columns: 1fr;
                }

                .search-bar form {
                    flex-direction: column;
                    gap: 15px;
                }

                .search-bar input[type="text"] {
                    border-radius: 10px;
                }

                .search-bar button {
                    border-radius: 10px;
                    width: 100%;
                }

                .course-actions {
                    flex-direction: column;
                }

                .pagination {
                    gap: 5px;
                }

                .pagination a {
                    padding: 8px 12px;
                    font-size: 14px;
                }
            }

            /* Animation for cards */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .course-card {
                animation: fadeInUp 0.6s ease forwards;
            }

            .course-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .course-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .course-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .course-card:nth-child(4) {
                animation-delay: 0.4s;
            }
            .course-card:nth-child(5) {
                animation-delay: 0.5s;
            }
            .course-card:nth-child(6) {
                animation-delay: 0.6s;
            }
        </style>
    </head>
    <body>
        <jsp:include page="components/header.jsp"  />
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                    <!-- Nút chỉ hiện với admin -->
                    <c:if test="${sessionScope.roleID == 2 }">
                        <div style="margin-bottom: 20px;">
                            <a href="${pageContext.request.contextPath}/ManageStudentCourseServlet"
                               style="
                               color: white;
                               padding: 10px 20px;
                               border-radius: 6px;
                               text-decoration: none;
                               font-weight: bolder;
                               background: blue;
                               float: right">
                                Manage Student Course
                            </a>
                        </div>
                    </c:if>
        <div class="content-wrapper">
            <!-- Sidebar -->
            <div class="sidebar">
                <div>
                    <h3><i class="fas fa-list"></i> Course Catalog</h3>
                    <ul>
                        <li><a href="CourseList"><i class="fas fa-book"></i> All courses</a></li>
                            <c:forEach var="cat" items="${categories}">
                            <li><a href="CourseList?category=${cat}"><i class="fas fa-tag"></i> ${cat}</a></li>
                            </c:forEach>
                    </ul>

                    <h3><i class="fas fa-star"></i> Featured Courses</h3>
                    <ul>
                        <c:forEach var="f" items="${featuredSubjects}">
                            <li><a href="CourseDetail?id=${f.courseID}"><i class="fas fa-crown"></i> ${f.courseTitle}</a></li>
                            </c:forEach>
                    </ul>
                    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                    <!-- Nút chỉ hiện với admin -->
                    <c:if test="${sessionScope.roleID == 1}">
                        <div style="margin-bottom: 20px;">
                            <a href="${pageContext.request.contextPath}/AdminRegistrationListServlet"
                               style="
                               color: white;
                               padding: 10px 20px;
                               border-radius: 6px;
                               text-decoration: none;
                               font-weight: bolder;">
                                📋 Registration List
                            </a>
                        </div>
                    </c:if>
                </div>

                <div class="contact">
                    <p><i class="fas fa-phone"></i> Contact: +123 456 789</p>
                    <p><i class="fas fa-envelope"></i> Email: contact@yourdomain.com</p>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main">
                <!-- Search Section -->
                <div class="search-section">
                    <div class="search-bar">
                        <form action="CourseList" method="get">
                            <div class="search-input-wrapper">
                                <input type="text" name="search" placeholder="Search Course..." value="${param.search}" />
                            </div>
                            <input type="hidden" name="sort" value="${param.sort}" />
                            <input type="hidden" name="status" value="${param.status}" />
                            <input type="hidden" name="minQuantity" value="${param.minQuantity}" />
                            <input type="hidden" name="category" value="${param.category}" />
                            <button type="submit" title="Tìm kiếm">
                                <i class="fas fa-search"></i>
                            </button>
                            <button type="button" id="toggleFilter" title="Advanced Filters">
                                <i class="fas fa-filter"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Page Title -->
                <div class="page-title" style="position: relative;">
                    <h2>Course List</h2>
                    <c:if test="${sessionScope.roleID == 1 || sessionScope.roleID == 2}">
                        <a href="${pageContext.request.contextPath}/AddCourseServlet" 
                           style="
                               position: absolute;
                               right: 0;
                               top: 0;
                               color: white;
                               padding: 10px 20px;
                               border-radius: 6px;
                               text-decoration: none;
                               font-weight: bolder;
                               background: #00b4d8;">
                            <i class="fas fa-plus"></i> Add Course
                        </a>
                    </c:if>
                </div>

                <!-- Empty State or Course Grid -->
                <c:choose>
                    <c:when test="${empty courses}">
                        <div class="empty-state">
                            <i class="fas fa-search"></i>
                            <h3>No courses match</h3>
                            <p>Try changing your search keywords or filters</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="course-grid">
                            <c:forEach var="c" items="${courses}">
                                <div class="course-card">
                                    <img src="${c.urlCourse}" alt="Course Image" />
                                    <div class="course-content">
                                        <div class="course-tag">${c.courseTag}</div>
                                        <h3>${c.courseTitle}</h3>
                                        <div class="course-detail">${c.courseDetail}</div>

                                        <div class="course-actions">
                                            <a href="CourseDetail?id=${c.courseID}" class="btn-detail">
                                                <i class="fas fa-info-circle"></i> View details
                                            </a>
                                            <a href="CourseRegisterServlet?courseID=${c.courseID}" class="btn-register">
                                                <i class="fas fa-user-plus"></i> Register now
                                            </a>
                                        </div>  

                                        <c:set var="price" value="${coursePrices[c.courseID]}" />
                                        <div class="course-price">
                                            <span class="sale-price">${price.salePrice}đ</span>
                                            <c:if test="${price.listPrice > price.salePrice}">
                                                <span class="original-price">${price.listPrice}đ</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:set var="baseUrl" value="CourseList?search=${param.search}&sort=${param.sort}&status=${param.status}&minQuantity=${param.minQuantity}&category=${param.category}" />
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="${baseUrl}&page=${currentPage - 1}" title="Previous page">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="${baseUrl}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${baseUrl}&page=${currentPage + 1}" title="Next page">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Advanced Filter Popup -->
        <div class="popup-overlay" id="popup">
            <div class="popup-box">
                <button class="close-popup" onclick="togglePopup()">
                    <i class="fas fa-times"></i>
                </button>
                <h4><i class="fas fa-filter"></i> Advanced Filters</h4>

                <form method="get" action="CourseList">
                    <input type="hidden" name="search" value="${param.search}" />
                    <input type="hidden" name="category" value="${param.category}" />

                    <div style="margin-bottom: 20px;">
                        <strong>Sort by price:</strong>
                        <label>
                            <input type="radio" name="sort" value="asc" ${param.sort == 'asc' ? 'checked' : ''}> 
                            <i class="fas fa-sort-amount-up"></i> Price increases gradually
                        </label>
                        <label>
                            <input type="radio" name="sort" value="desc" ${param.sort == 'desc' ? 'checked' : ''}> 
                            <i class="fas fa-sort-amount-down"></i> Price decreasing
                        </label>
                    </div>

                    <div class="number-input">
                        <label for="minQuantity"><strong>Number of courses displayed:</strong></label>
                        <input type="number" id="minQuantity" name="minQuantity" 
                               value="${empty param.minQuantity ? 6 : param.minQuantity}" 
                               min="1" max="6">
                    </div>

                    <label>
                        <input type="checkbox" name="status" value="1" ${param.status == '1' ? 'checked' : ''}> 
                        <i class="fas fa-check-circle"></i> Show only active courses
                    </label>

                    <div class="filter-actions">
                        <button type="submit">
                            <i class="fas fa-check"></i> Apply
                        </button>
                        <a href="CourseList">
                            <i class="fas fa-redo"></i> Reset
                        </a>
                    </div>
                </form>
            </div>

        </div>
        
        <script>
            function togglePopup() {
                const popup = document.getElementById("popup");
                popup.style.display = (popup.style.display === "flex") ? "none" : "flex";
            }

            document.getElementById("toggleFilter").addEventListener("click", togglePopup);

            // Close popup when clicking outside
            document.getElementById("popup").addEventListener("click", function (e) {
                if (e.target === this) {
                    togglePopup();
                }
            });

            // Add smooth scrolling
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });
        </script>

    </body>  
    <jsp:include page="components/footer.jsp" />
</html>