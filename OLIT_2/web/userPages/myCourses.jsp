<%-- 
    Document   : myCourse
    Created on : June 03, 2025
    Author     : Nam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>My Courses - Online Learn</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
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
                font-weight: bold;
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

            /* Main Content */
            .main {
                padding: 60px 0 60px 0;
                text-align: center;
            }

            .main .title {
                font-size: 32px;
                color: #333;
                margin-bottom: 30px;
            }

            /* Course List */
            .course-list {
                display: flex;
                flex-wrap: wrap;
                gap: 40px 40px;
                justify-content: center;
                align-items: flex-start;
                margin-top: 32px;
                margin-bottom: 32px;
                padding: 0 24px;
            }

            .course-card {
                width: 380px;
                background-color: white;
                border-radius: 16px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.12);
                overflow: hidden;
                transition: transform 0.3s;
                margin-bottom: 32px;
            }

            .course-card:hover {
                transform: translateY(-5px);
            }

            .course-card img {
                width: 100%;
                height: 240px;
                object-fit: cover;
            }

            .course-card .content {
                padding: 32px 28px 28px 28px;
                text-align: center;
            }

            .course-card h3 {
                font-size: 28px;
                color: #1e88e5;
                margin: 0 0 18px;
                text-align: center;
                font-weight: 800;
            }

            .course-card p {
                font-size: 18px;
                color: #666;
                margin: 0 0 18px;
                text-align: center;
                line-height: 1.7;
            }

            .course-card .instructor {
                font-size: 13px;
                color: #999;
                text-align: left;
            }

            .course-card a {
                display: inline-block;
                margin-top: 18px;
                padding: 14px 32px;
                background-color: #1e88e5;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 20px;
                font-weight: 700;
                transition: background 0.3s;
            }

            .course-card a:hover {
                background-color: #1565c0;
            }
            .course-tag {
                display: inline-block;
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
                padding: 12px 32px;
                border-radius: 32px;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                letter-spacing: 1px;
                box-shadow: 0 4px 16px rgba(30,136,229,0.15);
                text-align: center;
            }
            /* No Courses Message */
            .no-courses {
                font-size: 18px;
                color: #666;
                margin-top: 20px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .main {
                    padding: 20px;
                }

                .course-card {
                    width: 100%;
                    max-width: 400px;
                }

                .header .nav {
                    gap: 10px;
                }

                .header .nav a {
                    font-size: 14px;
                }
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
                <a href="${pageContext.request.contextPath}/CourseListServlet">Courses</a>
                <a href="${pageContext.request.contextPath}/MyRegistration">Registration</a>
                <a href="${pageContext.request.contextPath}/BlogListServlet">Blog</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main">
            <h1 class="title">Online Learning Courses</h1>
            <div class="course-list">
                <c:choose>
                    <c:when test="${not empty myCourses}">
                        <c:forEach var="course" items="${myCourses}">
                            <div class="course-card">
                                <img src="${course.urlCourse}" alt="Course Image" />
                                <div class="content">
                                    <div class="course-tag">${course.courseTag}</div>
                                    <h3>${course.getCourseTitle()}</h3>
                                    <p>${course.getCourseDetail()}</p>
                                    <a href="${pageContext.request.contextPath}/LessonView?id=${course.getCourseID()}">View Course</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-courses">You have not registered for any courses yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </body>
    <jsp:include page="components/footer.jsp" />
</html>