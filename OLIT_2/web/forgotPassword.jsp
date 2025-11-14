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
            <h2>Reset your password</h2>
            <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
                <p>Please enter the email address you’d like your password reset information sent to</p>
                <% String email = request.getParameter("email"); %>
                <input type="text" class="input-field" name="email" value="${email != null ? email : ""}" placeholder="Enter Your Email" required>
                <c:if test="${not empty err}">
                    <p class="err">${err}</p>
                </c:if>
                <div class="links">
                    <a href="${pageContext.request.contextPath}/login.jsp">Sign in</a>
                </div>
                <input type="hidden" name="action" value="resetPassword">
                <button type="submit" class="button">Request reset link</button>
            </form>
        </div>
    </body>
</html>
