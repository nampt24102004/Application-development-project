<%-- 
    Document   : waitingEmail
    Created on : Jun 23, 2025, 11:16:57 AM
    Author     : Long0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Waiting Email</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/login.css">
    </head>
    <body>
        <div class="login-container">
            <h2>${action}</h2>
            <p>The link has been sent to email: 
                <a href="#" onclick="openWebmail('${email}'); return false;">
                    ${email}
                </a>
            </p>
        </div>
        <script>
            function openWebmail(email) {
                const domain = email.split('@')[1].toLowerCase();
                const webmailUrls = {
                    'gmail.com': 'https://mail.google.com/mail/u/0',
                    'fpt.edu.vn': 'https://mail.google.com/mail/u/0'
                };

                if (webmailUrls[domain]) {
                    window.open(webmailUrls[domain], '_blank');
                } else {
                    // Fallback to mailto for other email providers
                    window.location.href = 'mailto:' + email;
                }
            }
        </script>
    </body>
</html>