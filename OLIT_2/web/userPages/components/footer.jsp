<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%-- footer.jsp --%>


<style>
    @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

    .footer {
        background: linear-gradient(135deg, #1E88E5 0%, #42A5F5 100%);
        color: #f1f1f1;
        padding: 40px 20px;
        font-family: 'Segoe UI', sans-serif;
    }
    .footer-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        max-width: 1200px;
        margin: auto;
    }
    .footer-column {
        flex: 1 1 200px;
        margin: 10px;
    }
    .footer-column h4 {
        margin-bottom: 16px;
        font-size: 1.2rem;
        letter-spacing: 0.5px;
    }
    .footer-column ul {
        list-style: none;
        padding: 0;
    }
    .footer-column ul li {
        margin-bottom: 8px;
    }
    .footer-column ul li a {
        color: #f1f1f1;
        text-decoration: none;
        transition: color 0.3s;
    }
    .footer-column ul li a:hover {
        color: #FFC107;
    }
    .social-icons {
        display: flex;
        gap: 12px;
        margin-top: 8px;
    }
    .social-icons a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: #fff;
        color: #1E88E5;
        border-radius: 50%;
        width: 36px;
        height: 36px;
        text-decoration: none;
        transition: transform 0.2s;
    }
    .social-icons a:hover {
        transform: scale(1.1);
    }
    .footer-bottom {
        text-align: center;
        margin-top: 30px;
        font-size: 0.9rem;
        border-top: 1px solid rgba(255,255,255,0.2);
        padding-top: 20px;
    }
</style>

<footer class="footer">
    <div class="footer-container">

        <div class="footer-column">
            <h4>About Online Course</h4>
            <p>We provide high-quality online courses to help you master new skills and advance your career.</p>
        </div>

        <div class="footer-column">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/MyRegistration">Courses</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h4>Connect With Us</h4>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank" aria-label="Facebook">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="https://twitter.com" target="_blank" aria-label="Twitter">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="https://linkedin.com" target="_blank" aria-label="LinkedIn">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                <a href="https://instagram.com" target="_blank" aria-label="Instagram">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
        </div>

    </div>

    <div class="footer-bottom">
        © 2025 Course Aura. All rights reserved.
    </div>
</footer>
