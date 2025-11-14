<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Course</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5faff, #c3cfe2);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            background: rgba(0,0,0,0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        .popup {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(30,136,229,0.10);
            padding: 24px 18px 18px 18px;
            max-width: 420px;
            width: 95vw;
            position: relative;
            animation: fadeInScale 0.25s;
        }
        .close-btn {
            position: absolute;
            top: 12px;
            right: 16px;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #888;
            cursor: pointer;
            transition: color 0.2s;
        }
        .close-btn:hover { color: #e53935; }
        h2 {
            text-align: center;
            color: #1e88e5;
            margin-bottom: 22px;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            font-weight: 600;
            color: #1e88e5;
            margin-bottom: 6px;
            display: block;
            letter-spacing: 0.2px;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 92%;
            margin-left: 4%;
            margin-right: 4%;
            padding: 11px 14px 11px 38px;
            border: 1px solid #cbe3fa;
            border-radius: 8px;
            font-size: 15px;
            background: #f5faff;
            color: #222;
            transition: border-color 0.2s;
            margin-top: 2px;
            box-sizing: border-box;
            display: block;
        }
        input[readonly] {
            background: #e3f0fc;
            color: #888;
            cursor: not-allowed;
        }
        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #1e88e5;
            font-size: 1.1em;
            pointer-events: none;
        }
        .input-wrap {
            position: relative;
        }
        .gender-group {
            display: flex;
            gap: 18px;
            margin-top: 4px;
        }
        .gender-group label {
            font-weight: 500;
            color: #444;
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .gender-group input[type="radio"] {
            accent-color: #1e88e5;
            width: 16px; height: 16px;
        }
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 18px;
        }
        .btn-register {
            background: linear-gradient(90deg, #1e88e5 0%, #42a5f5 100%);
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            padding: 11px 0;
            font-size: 1.08em;
            flex: 1;
            transition: background 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(30,136,229,0.08);
            cursor: pointer;
        }
        .btn-register:hover {
            background: linear-gradient(90deg, #1565c0 0%, #1e88e5 100%);
            box-shadow: 0 4px 16px rgba(30,136,229,0.15);
        }
        .btn-cancel {
            background: #e0e0e0;
            color: #333;
            border: none;
            border-radius: 8px;
            padding: 11px 0;
            font-size: 1.08em;
            flex: 1;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-cancel:hover {
            background: #bdbdbd;
        }
        @keyframes fadeInScale {
            from { opacity: 0; transform: scale(0.92); }
            to   { opacity: 1; transform: scale(1); }
        }
        @media (max-width: 600px) {
            .popup { padding: 10px 2vw 8px 2vw; }
            h2 { font-size: 1.1rem; }
            input[type="text"],
            input[type="email"],
            input[type="tel"],
            select {
                width: 98%;
                margin-left: 1%;
                margin-right: 1%;
            }
        }
    </style>
</head>
<body>
    <div class="overlay">
        <div class="popup">
            <button class="close-btn" onclick="window.history.back();">&times;</button>
            <h2>Register Course</h2>
            <form action="${pageContext.request.contextPath}/CourseRegisterServlet" method="get" id="courseSelectForm">
                <c:if test="${empty param.courseID}">
                    <div class="form-group">
                        <label for="courseID">Choose Course</label>
                        <select id="courseID" name="courseID" required onchange="document.getElementById('courseSelectForm').submit();">
                            <option value="" disabled selected style="color:#888;">-- Select Course --</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.courseID}">${c.courseTitle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="button-group">
                        <button type="button" class="btn btn-cancel" onclick="window.history.back();">Cancel</button>
                    </div>
                </c:if>
            </form>
            <c:if test="${not empty param.courseID}">
                <c:choose>
                    <c:when test="${sessionScope.fullAccount == null}">
                        <div style="color: red; text-align: center; font-weight: bold; margin: 20px 0;">
                            Please login or register an account to register for the course.
                        </div>
                        <div class="button-group" style="justify-content: center;">
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-register" style="text-decoration:none; text-align:center;">Log in</a>
                            <a href="${pageContext.request.contextPath}/signUp.jsp" class="btn btn-cancel" style="text-decoration:none; text-align:center;">Sign up</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/RegisterCourse" method="post">
                            <input type="hidden" name="course" value="${param.courseID}" />
                            <div class="form-group">
                                <label for="courseName">Course Name</label>
                                <input type="text" id="courseName" name="courseName" value="${courseName}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="package">Choose Price Package</label>
                                <select id="package" name="packageID" required>
                                    <option value="">-- Select Package --</option>
                                    <c:forEach items="${pricePackages}" var="pkg">
                                        <option value="${pkg.packageID}">
                                            <c:out value="${pkg.name}"/> - $${pkg.salePrice}
                                            <c:if test="${pkg.listPrice > pkg.salePrice}">
                                                (was $${pkg.listPrice})
                                            </c:if>
                                            - ${pkg.accessDuration} months access
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" id="fullName" name="fullName"
                                       value="${sessionScope.fullAccount != null ? sessionScope.fullAccount.fullName : ''}"
                                       ${sessionScope.fullAccount != null ? 'readonly' : ''} required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email"
                                       value="${sessionScope.fullAccount != null ? sessionScope.fullAccount.email : ''}"
                                       ${sessionScope.fullAccount != null ? 'readonly' : ''} required>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone Number</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber"
                                       value="${not empty sessionScope.fullAccount ? sessionScope.fullAccount.phoneNumber : ''}"
                                       ${not empty sessionScope.fullAccount ? 'readonly' : ''} required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <div class="gender-group">
                                    <c:choose>
                                        <c:when test="${sessionScope.fullAccount != null}">
                                            <c:choose>
                                                <c:when test="${sessionScope.fullAccount.gender == 'Male'}">
                                                    <label><input type="radio" name="gender" value="Male" checked disabled> Male</label>
                                                </c:when>
                                                <c:when test="${sessionScope.fullAccount.gender == 'Female'}">
                                                    <label><input type="radio" name="gender" value="Female" checked disabled> Female</label>
                                                </c:when>
                                                <c:otherwise>
                                                    <label><input type="radio" name="gender" value="Other" checked disabled> Other</label>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <label><input type="radio" name="gender" value="Male"> Male</label>
                                            <label><input type="radio" name="gender" value="Female"> Female</label>
                                            <label><input type="radio" name="gender" value="Other"> Other</label>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="button-group">
                                <button type="submit" class="btn btn-register">Register</button>
                                <button type="button" class="btn btn-cancel" onclick="window.history.back();">Cancel</button>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
</body>
</html>