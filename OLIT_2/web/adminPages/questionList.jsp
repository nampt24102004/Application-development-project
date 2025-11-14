<%-- 
    Document   : question-list.jsp
    Created on : Jun 15, 2025, 2:53:30 PM
    Author     : Long
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.SubjectDAO" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>QUESTION LIST</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .eye-icon {
                cursor: pointer;
                margin-left: 5px;
                color: #888;
            }
            .eye-icon:hover {
                color: #000;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .action-icons i {
                margin: 0 6px;
                cursor: pointer;
                color: #1e88e5;
            }
            .action-icons i:hover {
                color: #1565c0;
            }
        </style>
    </head>
    <body class="bg-light">

        <!-- Include the common header for users -->
        <jsp:include page="../userPages/components/header.jsp"/>

        <div class="container mt-5">

            <!-- Title and "Add new Question" button -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">QUESTION LIST</h2>
                <form action="${pageContext.request.contextPath}/CreateQuestionServlet" method="get">
                    <button type="submit" class="btn btn-primary" title="create">+ Add new Question</button>
                </form>
            </div>

            <!-- Search, filter, page size and refresh form -->
            <form method="get" action="${pageContext.request.contextPath}/QuestionListServlet" class="row mb-3">
                <div class="col-md-6">
                    <!-- Input to search question by keyword -->
                    <input type="text" name="search" class="form-control" placeholder="Search question..." value="${param.search}">
                </div>
                <div class="col-md-3">
                    <!-- Dropdown to filter by level -->
                    <select class="form-select" name="filter">
                        <option value="">Filter by Level</option>
                        <option value="Beginner"     ${param.filter=='Beginner'     ? 'selected':''}>Beginner</option>
                        <option value="Intermediate" ${param.filter=='Intermediate' ? 'selected':''}>Intermediate</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <!-- Input to specify number of records per page -->
                    <input type="number" name="pageSize" class="form-control" placeholder="Records/page" min="1"
                           value="${param.pageSize != null ? param.pageSize : 10}">
                </div>
                <div class="col-md-1">
                    <!-- Apply button to submit search/filter -->
                    <button type="submit" class="btn btn-primary w-100">Apply</button>
                </div>
                <div class="col-md-1">
                    <!-- Refresh button to reset all filters -->
                    <button type="button" class="btn btn-secondary w-100" onclick="resetForm()">Refresh</button>
                </div>
            </form>

            <!-- Table displaying the list of questions -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover" id="questionTable">
                    <thead class="table-secondary">
                        <tr>
                            <!-- Table headers with toggle icons -->
                            <th>ID <i class="bi bi-eye eye-icon" onclick="toggleColumn(0)"></i></th>
                            <th>Content <i class="bi bi-eye eye-icon" onclick="toggleColumn(1)"></i></th>
                            <th>Subject <i class="bi bi-eye eye-icon" onclick="toggleColumn(2)"></i></th>
                            <th>Level <i class="bi bi-eye eye-icon" onclick="toggleColumn(3)"></i></th>
                            <th>Status <i class="bi bi-eye eye-icon" onclick="toggleColumn(4)"></i></th>
                            <th>Option</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through each question in the list -->
                        <c:forEach var="q" items="${questionList}">
                            <tr>
                                <td>${q.questionID}</td>
                                <td>${q.questionContent}</td>
                                <td>${SubjectDAO.getSubjectByID(q.subjectID).subjectName}</td>
                                <td>${q.questionLevel}</td>
                                <td>
                                    <!-- Display status based on boolean value -->
                                    <c:choose>
                                        <c:when test="${q.status}">Active</c:when>
                                        <c:otherwise>Inactive</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-icons">
                                    <!-- Edit/view detail button -->
                                    <form action="${pageContext.request.contextPath}/QuestionDetailServlet" method="get" style="display:inline;">
                                        <input type="hidden" name="action"     value="viewQuestionDetail">
                                        <input type="hidden" name="questionID" value="${q.questionID}">
                                        <button type="submit" class="btn btn-link p-0" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination controls -->
            <div class="d-flex justify-content-end mt-3">
                <nav>
                    <ul class="pagination">
                        <!-- Show "Previous" link if not on first page -->
                        <c:if test="${pageIndex > 1}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/QuestionListServlet?page=${pageIndex-1}&search=${param.search}&filter=${param.filter}&pageSize=${param.pageSize}">
                                    Previous
                                </a>
                            </li>
                        </c:if>
                        <!-- Page number links -->
                        <c:forEach var="i" begin="1" end="${totalPage}">
                            <li class="page-item ${i==pageIndex?'active':''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/QuestionListServlet?page=${i}&search=${param.search}&filter=${param.filter}&pageSize=${param.pageSize}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>
                        <!-- Show "Next" link if not on last page -->
                        <c:if test="${pageIndex < totalPage}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/QuestionListServlet?page=${pageIndex+1}&search=${param.search}&filter=${param.filter}&pageSize=${param.pageSize}">
                                    Next
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- JS Functions -->
        <script>
                                // Toggle visibility of a column in the table
                                function toggleColumn(idx) {
                                    const table = document.getElementById("questionTable");
                                    Array.from(table.rows).forEach(row => {
                                        const cell = row.cells[idx];
                                        cell.style.display = cell.style.display === 'none' ? '' : 'none';
                                    });
                                }

                                // Reset search/filter form and reload list
                                function resetForm() {
                                    document.querySelector("form").reset();
                                    window.location.href = "${pageContext.request.contextPath}/QuestionListServlet";
                                }
        </script>
    </body>

</html>
