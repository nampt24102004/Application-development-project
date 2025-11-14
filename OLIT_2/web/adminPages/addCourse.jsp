<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="model.PricePackage"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Add New Course</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f7f9;
                margin: 0;
                color: #333;
            }
            .container {
                max-width: 900px;
                margin: 30px auto;
                padding: 40px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
                font-weight: 600;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
                margin-bottom: 25px;
            }
            .form-group {
                display: flex;
                flex-direction: column;
            }
            .form-group-full {
                grid-column: 1 / -1;
            }
            label {
                font-weight: 600;
                font-size: 14px;
                color: #555;
                margin-bottom: 8px;
            }
            input[type="text"],
            input[type="number"],
            input[type="file"],
            textarea,
            select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                font-family: 'Segoe UI', sans-serif;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
                box-sizing: border-box;
            }
            input[type="text"]:focus,
            input[type="number"]:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.2);
            }
            textarea {
                resize: vertical;
                min-height: 120px;
            }
            input[type="submit"] {
                background: linear-gradient(135deg, #00b4d8, #0077cc);
                color: white;
                border: none;
                padding: 15px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
            }
            input[type="submit"]:hover {
                background: linear-gradient(135deg, #0077cc, #005fa3);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 119, 204, 0.3);
            }
            .error-message {
                color: #e74c3c;
                text-align: center;
                margin-bottom: 20px;
                font-weight: 500;
                background-color: #fdd;
                padding: 10px;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../userPages/components/header.jsp"/>

        <div class="container">
            <h2><i class="fas fa-plus-circle"></i> Add Course</h2>

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>
            <c:if test="${not empty success}">
                <p class="error-message" style="color: #22863a; background: #eaffea;">${success}</p>
            </c:if>

            <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group form-group-full">
                        <label for="name">Course Name:</label>
                        <input type="text" id="name" name="name" required placeholder="e.g., Introduction to Python">
                    </div>

                    <div class="form-group form-group-full">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description" required placeholder="A comprehensive course for beginners..."></textarea>
                    </div>

                    <div class="form-group">
                        <label for="subjectID">Topic:</label>
                        <select id="subjectID" name="subjectID" required>
                            <%
                                List<model.Subject> subjects = (List<model.Subject>) request.getAttribute("subjects");
                                if (subjects != null) {
                                    for (model.Subject s : subjects) {
                            %>
                            <option value="<%=s.getSubjectID()%>"><%=s.getSubjectName()%></option>
                            <%      }
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="courseTag">Tag:</label>
                        <input type="text" id="courseTag" name="courseTag" placeholder="e.g., Programming, Python">
                    </div>

                    <div class="form-group">
                        <label for="courseLevel">Level:</label>
                        <input type="text" id="courseLevel" name="courseLevel" placeholder="e.g., Beginner">
                    </div>

                    <div class="form-group">
                        <label for="courseraDuration">Duration (hours):</label>
                        <input type="number" id="courseraDuration" name="courseraDuration" min="0" placeholder="e.g., 10">
                    </div>

                    <div class="form-group">
                        <label for="status">Status:</label>
                        <select id="status" name="status">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="featureFlag">Feature Flag:</label>
                        <input type="text" id="featureFlag" name="featureFlag" placeholder="e.g., 'Hot', 'New'">
                    </div>

                    <div class="form-group form-group-full">
                        <label for="image">Image Course:</label>
                        <input type="file" id="image" name="image" accept="image/*">
                    </div>
                </div>
                <input type="submit" value="Add Course">
            </form>
        </div>
        <c:if test="${not empty courseID}">
            <div class="container" style="margin-top:30px; border:1px solid #ccc; padding:20px;">
                <h3>Add package price for new course</h3>
                <form action="AddCourseServlet" method="post">
                    <input type="hidden" name="courseID" value="${courseID}" />
                    <div class="form-group">
                        <label for="name">Package name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="accessDuration">Access period (months):</label>
                        <input type="number" id="accessDuration" name="accessDuration" required>
                    </div>
                    <div class="form-group">
                        <label for="listPrice">List price:</label>
                        <input type="number" id="listPrice" name="listPrice" required>
                    </div>
                    <div class="form-group">
                        <label for="salePrice">Selling price:</label>
                        <input type="number" id="salePrice" name="salePrice" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Describe:</label>
                        <textarea id="description" name="description"></textarea>
                    </div>
                    <input type="submit" value="Thêm gói giá">
                </form>
            </div>
        </c:if>
    </body>
</html> 