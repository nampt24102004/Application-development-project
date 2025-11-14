<%-- 
    Document   : setPassword
    Created on : Jun 23, 2025, 10:14:09 AM
    Author     : Long0
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Set Password</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/login.css">
    </head>
    <body>
        <div class="login-container">
            <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="post">
                <h2>Set your Password</h2>
                <%  String email = request.getParameter("email"); %>
                <input readonly type="email" name="email" class="input-field" value="<%= email != null ? email : "" %>">

                <input type="password" name="newPassword" class="input-field" placeholder="New Password" required>
                <div class="password-hint">
                    • At least 8 characters<br>
                    • Includes letters number and special character
                </div>
                <input type="password" name="confirmPassword" class="input-field" placeholder="Confirm Password" required>
                
                <c:if test="${not empty error}">
                    <p class="error-msg">${error}</p>
                </c:if>

                <input type="hidden" name="action" value="setPassword">
                <button type="submit" class="button">Save & Login</button>
            </form>
        </div>
    </body>
</html>
