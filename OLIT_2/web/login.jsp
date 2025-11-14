<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/login.css">
    </head>
    <body>
        <div class="login-container">
            <h2>Welcome Back</h2>
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <input type="email" class="input-field" name="email" placeholder="Enter Your Email" required>
                <input type="password" class="input-field" name="password" placeholder="Enter Your Password" required>

                <div class="links">
                    <a href="${pageContext.request.contextPath}/forgotPassword.jsp">Forgot Password?</a>
                    <a href="${pageContext.request.contextPath}/signUp.jsp">Sign up</a>
                </div>

                <c:if test="${not empty err}">
                    <p class="err">${err}</p>
                </c:if>

                <button type="submit" class="button">Sign In</button>
            </form>
        </div>
    </body>
</html>
