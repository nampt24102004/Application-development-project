<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign Up</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/login.css">
    </head>
    <body>
        <div class="login-container">
            <h2>Create Your Account</h2>
            <form action="${pageContext.request.contextPath}/SignupServlet" method="post">
                <input type="text" class="input-field" name="fullName" placeholder="Full Name" required>

                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select name="gender" class="input-field" id="gender" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other" selected>Other</option>
                    </select>
                </div>

                <input type="email" class="input-field" name="email" placeholder="Email Address" required>
                <input type="tel" class="input-field" name="phone" placeholder="Phone Number" required>

                <div class="links">
                    <a href="${pageContext.request.contextPath}/login.jsp">Sign in</a>
                </div>

                <button type="submit" class="button">Sign Up</button>

                <c:if test="${not empty err}">
                    <p class="err">${err}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>