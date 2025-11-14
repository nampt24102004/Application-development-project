<%-- 
    Document   : newSubject
    Created on : Jun 25, 2025, 1:59:07 PM
    Author     : khain
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Subjects List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <style>
            body {
                background: #f7f9fc;
                font-family: 'Segoe UI', Arial, sans-serif;
            }
            .container {
                width: 950px;
                margin: 40px auto;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 6px 28px rgba(0,0,0,0.10);
                padding: 32px 36px 22px 36px;
            }
            h2 {
                margin-bottom: 22px;
                color: #23376a;
                font-weight: 700;
                font-size: 2.1em;
                letter-spacing: 1px;
            }
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 22px;
            }
            .add-btn {
                background: #3867fa;
                color: #fff;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                font-size: 1em;
                padding: 11px 28px;
                text-decoration: none;
                box-shadow: 0 2px 10px rgba(56,103,250,0.11);
                transition: background 0.2s;
            }
            .add-btn:hover {
                background: #204ac4;
            }
            .filters {
                display: flex;
                gap: 20px;
                margin-bottom: 22px;
            }
            .filters select, .filters input {
                border-radius: 8px;
                border: 1px solid #e0e7f0;
                padding: 9px 14px;
                font-size: 1em;
                background: #f7f9fc;
            }
            .filters .search-btn {
                background: #3867fa;
                color: #fff;
                border: none;
                border-radius: 8px;
                padding: 10px 32px;
                font-size: 1em;
                font-weight: 600;
                margin-left: 10px;
                cursor: pointer;
            }
            .filters .search-btn:hover {
                background: #204ac4;
            }
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-bottom: 18px;
            }
            thead th {
                background: #f0f3fa;
                color: #455a77;
                padding: 13px 10px;
                font-weight: 600;
                font-size: 1.09em;
                border-bottom: 2.2px solid #e5e9f5;
                text-align: left;
            }
            tbody td {
                padding: 13px 10px;
                border-bottom: 1.3px solid #e9eef7;
                font-size: 1.08em;
            }
            .badge {
                display: inline-block;
                padding: 2px 13px;
                border-radius: 14px;
                font-size: 0.98em;
                font-weight: 600;
            }
            .badge-pub {
                background: #dbfaea;
                color: #18a55a;
            }
            .badge-draft {
                background: #f7e4ec;
                color: #a73d76;
            }
            .actions a, .actions button {
                margin-right: 11px;
                color: #3867fa;
                background: none;
                border: none;
                font-size: 1.1em;
                cursor: pointer;
                text-decoration: none;
                font-weight: 600;
            }
            .actions a:last-child {
                margin-right: 0;
            }
            .actions .edit-btn {
                color: #9d55b3;
            }
            .actions .edit-btn:hover {
                color: #511e80;
            }
            .actions .view-btn:hover {
                color: #163e93;
            }
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 11px;
                font-size: 1.06em;
                margin-top: 16px;
            }
            .pagination a {
                padding: 3px 11px;
                border-radius: 5px;
                background: #f2f4fb;
                color: #1a2753;
                text-decoration: none;
            }
            .pagination a.active {
                background: #3867fa;
                color: #fff;
                font-weight: 600;
            }
            .pagination a:hover {
                background: #204ac4;
                color: #fff;
            }

            .header {
                width: 100%;
                background: #1e88e5;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 20px;
                height: 70px;
                box-shadow: 0 2px 8px rgba(40,100,200,0.07);
                border-radius: 0 0 22px 22px;
                position: relative;
                box-sizing: border-box;
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 16px; /* Giãn logo và chữ */
            }



            .header-center {
                display: flex;
                align-items: center;
                gap: 28px; /* nhỏ hơn chút nếu muốn */
            }

            .header-center a {
                color: #fff;
                font-size: 1.18em;
                font-weight: 500;
                text-decoration: none;
                transition: color 0.17s;
                padding: 8px 12px;
                border-radius: 8px;
            }

            .header-center a:hover,
            .header-center a.active {
                background: rgba(255,255,255,0.14);
                color: #ffe66d;
            }

            .header-right .avatar {
                width: 43px;
                height: 43px;
                border-radius: 50%;
                border: 2px solid #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.09);
                cursor: pointer;
                object-fit: cover;
                transition: box-shadow 0.18s;
            }

            .header-right .avatar:hover {
                box-shadow: 0 6px 18px rgba(40,100,200,0.18);
            }
            .logo-img {
                height: 54px;       /* tăng lên cho to hơn */
                width: auto;
                padding: 4px;       /* thêm khoảng trắng xung quanh */
                border-radius: 8px;
                background: rgba(255,255,255,0.15);  /* nhẹ nhàng tách icon khỏi nền */
                box-shadow: 0 2px 8px rgba(0,0,0,0.2); /* đổ bóng để nổi bật */
                display: block;
            }

            .logo-text {
                font-size: 2.1em;
                font-weight: 700;
                color: #fff;
                letter-spacing: 1.5px;
                font-family: inherit;
                line-height: 1;  /* Tránh bị dính đáy */
            }
            @media (max-width: 900px) {
                .header {
                    flex-direction: column;
                    height: auto;
                    padding: 10px 15px;
                }
                .header-center {
                    gap: 12px;
                    font-size: 1em;
                    margin: 10px 0;
                }
            }

        </style>
    <div class="header">
        <div class="header-left">
            <img class="logo-img" src="images/HeaderIcon.png" alt="Logo">
            <span class="logo-text">CourseAura</span>
        </div>



        <div class="header-center">
            <a href="${pageContext.request.contextPath}/HomeServlet">Home</a>
            <a href="${pageContext.request.contextPath}/MyCourseServlet">Course</a>
            <a href="${pageContext.request.contextPath}/BlogListServlet">Blog</a>
            <a href="${pageContext.request.contextPath}/Logout">Logout</a>

        </div>
        <div class="header-right">
            <img src="${avatarUrl != null ? avatarUrl : 'images/avatar.png'}" class="avatar" alt="Profile" />
            <span class="user-info">
                ${userName}
                <span class="role-badge">${userRole}</span>
            </span>
        </div>
    </div>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <h2>Subjects List</h2>
            <c:if test="${userRole eq 'Admin'}">
                <a href="${pageContext.request.contextPath}/newSubject" class="add-btn">
                    <i class="fa fa-plus"></i> Add New Subject
                </a>
            </c:if>    
        </div>
        <form method="get" action="${pageContext.request.contextPath}/SubjectList" class="filters">
            <input type="text" name="search" placeholder="Search for subject name..." value="${param.search}"/>
            <select name="category">
                <option value="">Category</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
                </c:forEach>
            </select>
            <select name="status">
                <option value="">Status</option>
                <option value="1" <c:if test="${param.status == '1'}">selected</c:if>>Published</option>
                <option value="0" <c:if test="${param.status == '0'}">selected</c:if>>Draft</option>
                </select>
                <button type="submit" class="search-btn"><i class="fa fa-search"></i> Search</button>
            </form>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Subject Name</th>
                        <th>Category</th>
                        <th>No. of Lesson</th>
                        <th>Status</th>
                        <th>Owner</th>
                        <c:if test="${userRole eq 'Admin'}">
                        <th>Actions</th>
                        </c:if>  
                </tr>
            </thead>
            <tbody>
                <c:forEach var="subj" items="${subjectList}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${subj.subjectName}</td>
                        <td>${subj.category}</td>
                        <td>${subj.numOfLessons}</td>
                        <td>
                            <c:choose>
                                <c:when test="${subj.status}">
                                    <span class="badge badge-pub">Published</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-draft">Draft</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            ${subj.ownerName}
                        </td>
                        <c:if test="${userRole eq 'Admin'}">
                            <td class="actions">

                                <a href="#" class="edit-btn" title="Edit">
                                    
                                    <i class="fa fa-edit"></i> Edit
                                </a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <a href="#" title="Prev">&laquo; Prev</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#" title="Next">Next &raquo;</a>
        </div>
    </div>
                            <jsp:include page="components/footer.jsp"/>

</body>
</html>



