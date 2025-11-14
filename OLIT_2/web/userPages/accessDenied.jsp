<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body {
            background: #f8f9fa;
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 70px;
        }
        .error-card {
            background: #fff;
            border-radius: 15px;
            padding: 36px 44px;
            display: inline-block;
            box-shadow: 0 2px 24px rgba(0,0,0,0.10);
        }
        h1 {
            color: #d22323;
            margin-bottom: 18px;
        }
        p {
            color: #2d334d;
            font-size: 1.15em;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 8px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .btn-login {
            background-color: #337af7;
            color: #fff;
        }
        .btn-home {
            background-color: #28a745;
            color: #fff;
        }
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="error-card">
        <h1>Access Denied</h1>
        <p>You do not have permission to view this page.<br>
        Only <b>Admin</b> or <b>Expert</b> can access this feature.</p>
        <p>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-login">Login</a>
            <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-home">Home</a>
        </p>
    </div>
</body>
</html>
