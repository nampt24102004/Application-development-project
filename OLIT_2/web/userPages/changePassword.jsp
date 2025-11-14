<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Reset Password</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/login.css">
    </head>
    <body>
        <div class="login-container">
            <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="post">
                <h2>Change Password</h2>
                <input type="password" name="oldPassword" class="input-field" placeholder="Old Password" required>

                <input type="password" name="newPassword" class="input-field" placeholder="New Password" required>
                <div class="password-hint">
                    • At least 8 characters<br>
                    • Includes letters number and special character
                </div>
                <input type="password" name="confirmPassword" class="input-field" placeholder="Confirm Password" required>
                <a href="${pageContext.request.contextPath}/forgotPassword.jsp">Forgot Password?</a>
                <input type="hidden" name="action" value="changePassword">
                <button type="submit" class="button">Save Change</button>

                <c:if test="${not empty error}">
                    <p class="error-msg">${error}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>
