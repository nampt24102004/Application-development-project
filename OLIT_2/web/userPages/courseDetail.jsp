<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${course.courseTitle} - Course Detail</title>
        <style>
            :root {
                --primary: #4361ee;
                --primary-dark: #3a56d4;
                --secondary: #3f37c9;
                --accent: #4895ef;
                --danger: #f72585;
                --success: #4cc9f0;
                --warning: #f8961e;
                --light: #f8f9fa;
                --dark: #212529;
                --gray: #6c757d;
                --light-gray: #e9ecef;
                --white: #ffffff;
                --border-radius: 8px;
                --box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
                line-height: 1.6;
                color: var(--dark);
                background-color: #f5f7ff;
                margin: 0;
                padding: 0;
            }

            .container {
                display: flex;
                max-width: 1400px;
                margin: 0 auto;
                padding: 2rem;
                gap: 2rem;
            }



            .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .nav-links a {
                color: white;
                margin-left: 20px;
                text-decoration: none;
                font-weight: 500;
                transition: opacity 0.2s ease;
            }

            .nav-links a:hover {
                opacity: 0.8;
            }

            .main {
                flex: 3;
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 2.5rem;
                transition: var(--transition);
            }

            /* IMPROVED SIDEBAR STYLES */
            .sidebar {
                flex: 1;
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 0;
                align-self: flex-start;
                position: sticky;
                top: 1rem;
                overflow: hidden;
            }

            /* Add gradient top border */
            .sidebar::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary), var(--accent), var(--success));
                z-index: 1;
            }

            /* Sidebar sections */
            .sidebar-section {
                border-bottom: 1px solid var(--light-gray);
                padding: 2rem;
                transition: var(--transition);
            }

            .sidebar-section:last-child {
                border-bottom: none;
            }

            .sidebar-section:hover {
                background: rgba(67, 97, 238, 0.02);
            }

            .sidebar-section h3 {
                font-size: 1.25rem;
                font-weight: 700;
                color: var(--dark);
                margin: 0 0 1.5rem 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .sidebar-section h3::before {
                content: "";
                width: 4px;
                height: 20px;
                background: linear-gradient(135deg, var(--primary), var(--accent));
                border-radius: 2px;
            }

            /* Sidebar lists */
            .sidebar ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar li {
                margin: 0;
                animation: slideIn 0.3s ease forwards;
            }

            .sidebar a {
                display: flex;
                align-items: center;
                padding: 0.875rem 1rem;
                margin: 0.25rem 0;
                color: var(--gray);
                text-decoration: none;
                font-weight: 500;
                border-radius: 6px;
                position: relative;
                transition: var(--transition);
                background: transparent;
                border: 1px solid transparent;
            }

            .sidebar a::before {
                content: "";
                width: 6px;
                height: 6px;
                background: var(--primary);
                border-radius: 50%;
                margin-right: 0.75rem;
                opacity: 0;
                transform: scale(0);
                transition: var(--transition);
            }

            .sidebar a:hover {
                background: linear-gradient(135deg, rgba(67, 97, 238, 0.08), rgba(72, 149, 239, 0.05));
                color: var(--primary);
                transform: translateX(3px);
                border-color: rgba(67, 97, 238, 0.2);
            }

            .sidebar a:hover::before {
                opacity: 1;
                transform: scale(1);
            }

            /* Active state for current page */
            .sidebar a.active {
                background: linear-gradient(135deg, var(--primary), var(--accent));
                color: var(--white);
                font-weight: 600;
                box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
            }

            .sidebar a.active::before {
                background: var(--white);
                opacity: 1;
                transform: scale(1);
            }

            /* Special styling for "All courses" link */
            .sidebar .all-courses-link {
                background: var(--light);
                border: 2px dashed var(--light-gray);
                font-weight: 600;
                color: var(--dark);
            }

            .sidebar .all-courses-link:hover {
                background: var(--primary);
                color: var(--white);
                border-style: solid;
                border-color: var(--primary);
            }

            .sidebar .all-courses-link::before {
                content: "📚";
                font-size: 1rem;
                margin-right: 0.5rem;
                opacity: 1;
                transform: scale(1);
            }

            /* Featured courses special styling */
            .featured-courses .sidebar a {
                background: linear-gradient(135deg, rgba(72, 149, 239, 0.05), rgba(76, 201, 240, 0.03));
                border-left: 3px solid transparent;
            }

            .featured-courses .sidebar a:hover {
                border-left-color: var(--accent);
                background: linear-gradient(135deg, rgba(72, 149, 239, 0.12), rgba(76, 201, 240, 0.08));
            }

            .featured-courses .sidebar a::before {
                content: "⭐";
                font-size: 0.875rem;
                margin-right: 0.5rem;
                opacity: 1;
                transform: scale(1);
                background: transparent;
            }

            /* Stagger animation for list items */
            .sidebar li:nth-child(1) {
                animation-delay: 0.1s;
            }
            .sidebar li:nth-child(2) {
                animation-delay: 0.15s;
            }
            .sidebar li:nth-child(3) {
                animation-delay: 0.2s;
            }
            .sidebar li:nth-child(4) {
                animation-delay: 0.25s;
            }
            .sidebar li:nth-child(5) {
                animation-delay: 0.3s;
            }
            .sidebar li:nth-child(6) {
                animation-delay: 0.35s;
            }

            /* Slide in animation */
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            /* Responsive adjustments */
            @media (max-width: 992px) {
                .sidebar {
                    position: static;
                    width: 100%;
                    margin-top: 2rem;
                }

                .sidebar-section {
                    padding: 1.5rem;
                }
            }

            @media (max-width: 768px) {
                .sidebar-section {
                    padding: 1rem;
                }

                .sidebar a {
                    padding: 0.75rem;
                    font-size: 0.95rem;
                }
            }

            .title {
                font-size: 2.25rem;
                font-weight: 700;
                margin-bottom: 1rem;
                color: var(--dark);
                line-height: 1.2;
            }

            .price {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--danger);
                display: inline-block;
                margin: 0.5rem 0;
            }

            .price del {
                color: var(--gray);
                font-size: 1rem;
                margin-right: 0.5rem;
                opacity: 0.7;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: var(--primary);
                color: var(--white);
                border: none;
                padding: 0.8rem 1.75rem;
                font-size: 1rem;
                font-weight: 600;
                border-radius: var(--border-radius);
                text-decoration: none;
                cursor: pointer;
                transition: var(--transition);
                box-shadow: 0 4px 12px rgba(67, 97, 238, 0.25);
                margin: 1.5rem 0;
            }

            .btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(67, 97, 238, 0.3);
            }

            .btn:active {
                transform: translateY(0);
            }

            h2, h3, h4 {
                margin-top: 2rem;
                margin-bottom: 1rem;
                color: var(--dark);
                font-weight: 600;
            }

            h2 {
                font-size: 1.75rem;
                border-bottom: 2px solid var(--light-gray);
                padding-bottom: 0.5rem;
            }

            h3 {
                font-size: 1.5rem;
            }

            h4 {
                font-size: 1.25rem;
            }

            p {
                margin-bottom: 1rem;
                color: var(--gray);
            }



            .slider-container {
                position: relative;
                width: 100%;
                height: 500px;
                /*overflow: hidden;*/
                margin: 0;
                padding: 0;
            }

            /* Slider Controls Fix */
            .slider-controls {
                position: absolute;
                bottom: 20px;
                right: 20px;
                z-index: 100;
                display: flex;
                gap: 10px;
            }

            .slider-controls button {
                background-color: rgba(0, 0, 0, 0.7);
                color: white;
                border: none;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 1.2rem;
            }

            .slider-controls button:hover {
                background-color: rgba(0, 0, 0, 0.9);
                transform: scale(1.1);
            }

            /* Ensure slider content fills container */
            .slide-media {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .slide {
                display: none;
            }

            .slide.active {
                display: block;
            }

            /* Review Slider */
            .review-slider-container {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 2rem;
                margin: 3rem 0;
                box-shadow: var(--box-shadow);
                position: relative;
            }

            .review-slide {
                display: none;
                text-align: center;
                padding: 1rem;
            }

            .review-slide.active {
                display: block;
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .review-content {
                font-style: italic;
                font-size: 1.1rem;
                line-height: 1.7;
                color: var(--dark);
                margin-bottom: 1.5rem;
                position: relative;
            }

            .review-content::before,
            .review-content::after {
                content: '"';
                font-size: 2rem;
                color: var(--primary);
                opacity: 0.3;
                position: absolute;
            }

            .review-content::before {
                top: -1rem;
                left: -1rem;
            }

            .review-content::after {
                bottom: -2rem;
                right: -1rem;
            }

            .review-meta {
                font-size: 0.9rem;
                color: var(--gray);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .review-meta .stars {
                color: #ffc107;
                font-size: 1.1rem;
            }

            .review-slider-controls {
                margin-top: 1.5rem;
                text-align: center;
            }

            .review-slider-controls button {
                background-color: transparent;
                border: 2px solid var(--light-gray);
                color: var(--gray);
                padding: 0.5rem 1rem;
                font-size: 1rem;
                margin: 0 0.5rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                transition: var(--transition);
            }

            .review-slider-controls button:hover {
                background-color: var(--primary);
                color: var(--white);
                border-color: var(--primary);
            }

            /* Search and Subjects */
            input[type="text"] {
                width: 100%;
                padding: 0.75rem 1rem;
                margin-bottom: 1.5rem;
                border: 1px solid var(--light-gray);
                border-radius: var(--border-radius);
                font-size: 1rem;
                transition: var(--transition);
            }

            input[type="text"]:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            }

            .subjects {
                margin: 2rem 0;
            }

            #subjectList {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .subject-item {
                padding: 0.75rem 1rem;
                margin: 0.25rem 0;
                border-radius: var(--border-radius);
                transition: var(--transition);
                cursor: pointer;
                display: flex;
                align-items: center;
            }

            .subject-item::before {
                content: "•";
                color: var(--primary);
                margin-right: 0.75rem;
                font-size: 1.5rem;
            }

            .subject-item:hover {
                background-color: rgba(67, 97, 238, 0.1);
                color: var(--primary);
                transform: translateX(5px);
            }

            /* Featured Courses */
            .featured {
                margin: 2rem 0;
            }

            .featured ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .featured li {
                padding: 0.75rem 1rem;
                margin: 0.5rem 0;
                background-color: var(--light);
                border-radius: var(--border-radius);
                transition: var(--transition);
            }

            .featured li:hover {
                background-color: rgba(67, 97, 238, 0.1);
                transform: translateX(5px);
            }

            .featured a {
                color: var(--dark);
                text-decoration: none;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .featured a::before {
                content: "→";
                color: var(--primary);
                transition: var(--transition);
            }

            .featured li:hover a::before {
                transform: translateX(3px);
            }

            .featured a:hover {
                color: var(--primary);
                text-decoration: none;
            }

            /* Alerts */
            .alert {
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: var(--border-radius);
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .alert-success {
                background-color: rgba(76, 201, 240, 0.15);
                color: #0a9396;
                border-left: 4px solid var(--success);
            }

            .alert-error {
                background-color: rgba(247, 37, 133, 0.15);
                color: var(--danger);
                border-left: 4px solid var(--danger);
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .container {
                    flex-direction: column;
                }

                .sidebar {
                    position: static;
                    width: 100%;
                }

                .slider-container {
                    height: 400px;
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                }

                .main, .sidebar {
                    padding: 1.5rem;
                }

                .title {
                    font-size: 1.75rem;
                }

                .slider-container {
                    height: 300px;
                }

                .slide-info {
                    padding: 1rem;
                }

                .slide-info h3 {
                    font-size: 1.25rem;
                }
            }

            /* Animation for interactive elements */
            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }

            .highlight {
                animation: pulse 2s infinite;
            }

            /* Badge for featured items */
            .badge {
                display: inline-block;
                padding: 0.25rem 0.5rem;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50px;
                background-color: var(--primary);
                color: white;
                margin-left: 0.5rem;
                vertical-align: middle;
            }
            .review-form {
                margin-top: 30px;
                padding: 20px;
                border: 1px solid #ccc;
                background-color: #fafafa;
                border-radius: 8px;
            }
            .review-form textarea, .review-form select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
            .review-form button {
                padding: 10px 15px;
                background-color: #0066cc;
                color: white;
                border: none;
                border-radius: 5px;
            }

            .slider-wrapper {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .course-image {
                width: 100%;
                max-width: 600px;
                height: 300px;
                object-fit: cover;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .btn {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #0077cc;
                color: #fff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                text-align: center;
            }

            .btn:hover {
                background-color: #005fa3;
            }

            .main {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            .media-slider-wrapper {
                position: relative;
                width: 100%;
                max-width: 800px;
                margin: 20px auto;
                background: #f5f5f5;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .media-slider-container {
                position: relative;
                width: 100%;
                height: 400px;
                overflow: hidden;
            }

            .media-slide {
                display: none;
                width: 100%;
                height: 100%;
                position: relative;
            }

            .media-slide.active {
                display: block;
            }

            .media-slide img, .media-slide video {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .media-slide iframe {
                width: 100%;
                height: 100%;
                border: none;
            }

            .media-info {
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                background: linear-gradient(transparent, rgba(0,0,0,0.8));
                color: white;
                padding: 20px;
            }

            .media-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .media-description {
                font-size: 14px;
                opacity: 0.9;
            }

            .media-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                background: white;
                border-top: 1px solid #ddd;
            }

            .media-nav-btn {
                background: #007bff;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background 0.3s;
            }

            .media-nav-btn:hover {
                background: #0056b3;
            }

            .media-nav-btn:disabled {
                background: #ccc;
                cursor: not-allowed;
            }

            .media-indicators {
                display: flex;
                gap: 8px;
            }

            .media-indicator {
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background: #ddd;
                cursor: pointer;
                transition: background 0.3s;
            }

            .media-indicator.active {
                background: #007bff;
            }

            .media-counter {
                font-size: 14px;
                color: #666;
            }

            .no-media {
                text-align: center;
                padding: 40px;
                color: #666;
                font-style: italic;
            }
        </style>
    </head>
    <body>

        <jsp:include page="components/header.jsp"></jsp:include>

            <div class="container">
                <!-- MAIN -->
                <div class="main">

                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType}">
                        ${message}
                    </div>
                </c:if>

                <div class="title">${course.courseTitle}</div>
                <p><em>Start your coding journey with hands-on practice.</em></p>

                <p>
                    <strong>Lowest Price Package:</strong>
                    <c:choose>
                        <c:when test="${not empty lowestPackage}">
                            <del>${lowestPackage.listPrice}đ</del>
                            <span class="price" style="color:red; font-weight:bold">${lowestPackage.salePrice}đ</span>
                        </c:when>
                        <c:otherwise>
                            <span>Chưa có gói giá nào.</span>
                        </c:otherwise>
                    </c:choose>
                </p>

                <div>
                    <h4>Course Description</h4>
                    <p>${course.courseDetail}</p>
                </div>

                <!-- Media Slider Section -->
                <div class="media-slider-wrapper">
                    <c:choose>
                        <c:when test="${not empty mediaList}">
                            <div class="media-slider-container" id="mediaSliderContainer">
                                <c:forEach var="media" items="${mediaList}" varStatus="status">
                                    <div class="media-slide ${status.index == 0 ? 'active' : ''}" data-index="${status.index}">
                                        <c:choose>
                                            <c:when test="${media.mediaType == 'image'}">
                                                <img src="${media.mediaURL}" 
                                                     onerror="this.src='${pageContext.request.contextPath}/images/default-course.jpg'">
                                            </c:when>
                                            <c:when test="${media.mediaType == 'video'}">
                                                <c:choose>
                                                    <c:when test="${media.mediaURL.contains('youtube.com') || media.mediaURL.contains('youtu.be')}">
                                                        <c:set var="youtubeId" value="${media.mediaURL}" />
                                                        <c:choose>
                                                            <c:when test="${youtubeId.contains('watch?v=')}">
                                                                <c:set var="youtubeId" value="${fn:substringAfter(youtubeId, 'watch?v=')}" />
                                                                <c:set var="youtubeId" value="${fn:substringBefore(youtubeId, '&')}" />
                                                            </c:when>
                                                            <c:when test="${youtubeId.contains('youtu.be/')}">
                                                                <c:set var="youtubeId" value="${fn:substringAfter(youtubeId, 'youtu.be/')}" />
                                                            </c:when>
                                                        </c:choose>
                                                        <iframe src="https://www.youtube.com/embed/${youtubeId}" 
                                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                                                allowfullscreen>
                                                        </iframe>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <video controls preload="metadata">
                                                            <source src="${pageContext.request.contextPath}/${media.mediaURL}" type="video/mp4">
                                                            <source src="${pageContext.request.contextPath}/${media.mediaURL}" type="video/webm">
                                                            <source src="${pageContext.request.contextPath}/${media.mediaURL}" type="video/ogg">
                                                            Trình duyệt của bạn không hỗ trợ video.
                                                        </video>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>

                                        <div class="media-info">
                                            <div class="media-title"></div>

                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="media-controls">
                                <button class="media-nav-btn" id="prevMediaBtn" onclick="changeMediaSlide(-1)">❮ Back</button>

                                <div class="media-indicators" id="mediaIndicators">
                                    <c:forEach var="media" items="${mediaList}" varStatus="status">
                                        <div class="media-indicator ${status.index == 0 ? 'active' : ''}" 
                                             onclick="goToMediaSlide(${status.index})"></div>
                                    </c:forEach>
                                </div>

                                <div class="media-counter">
                                    <span id="currentMediaIndex">1</span> / <span id="totalMediaCount">${mediaList.size()}</span>
                                </div>

                                <button class="media-nav-btn" id="nextMediaBtn" onclick="changeMediaSlide(1)">Next ❯</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-media">
                                <p>Chưa có hình ảnh hoặc video cho khóa học này.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty reviews}">
                    <h3>Student Reviews</h3>
                    <c:if test="${not empty sessionScope.userID}">
                        <form action="${pageContext.request.contextPath}/AddReviewServlet" method="post" enctype="multipart/form-data" class="review-form">
                            <input type="hidden" name="courseId" value="${course.courseID}" />
                            <input type="hidden" name="userId" value="${sessionScope.userID}" />

                            <label for="star">Review star (• ⭐ 1-5):</label>
                            <select name="star" id="star" required>
                                <c:forEach begin="1" end="5" var="i">
                                    <option value="${i}">${i}</option>
                                </c:forEach>
                            </select>

                            <label for="content">Review content:</label>
                            <textarea name="content" id="content" rows="4" required></textarea>
                            <label for="image">Image(optional):</label>
                            <input type="file" name="image" id="image" accept="image/*" />
                            <button type="submit">Send Review</button>
                        </form>
                    </c:if>

                    <c:if test="${empty sessionScope.userID}">
                        <p>Please <a href="${pageContext.request.contextPath}/login.jsp">login</a> to submit a review.</p>
                    </c:if>

                    <div class="review-slider-container">
                        <c:forEach var="review" items="${reviews}" varStatus="loop">
                            <div class="review-slide ${loop.index == 0 ? 'active' : ''}">
                                <div class="review-content">
                                    <p>"${review.content}"</p>
                                    <div class="review-meta">
                                        <strong>${review.userFullName}</strong> • ⭐ ${review.star} stars — ${review.createdAt}
                                    </div>
                                    <c:if test="${not empty review.imageURL}">
                                        <div>
                                            <img src="${pageContext.request.contextPath}/${review.imageURL}" alt="review image"
                                                 style="max-width: 200px; border-radius: 8px; margin-top: 10px;">
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="review-slider-controls">
                            <button onclick="changeReview(-1)">❮</button>
                            <button onclick="changeReview(1)">❯</button>
                        </div>
                    </div>
                </c:if>

                <a class="btn" href="CourseRegisterServlet?courseID=${course.courseID}">Registration Now</a>

            </div>

            <!-- SIDEBAR -->
            <div class="sidebar">
                <div class="sidebar-section">
                    <h3>Course Catalog</h3>
                    <ul>
                        <li><a href="CourseList" class="all-courses-link">All Courses</a></li>
                            <c:forEach var="cat" items="${categories}">
                            <li><a href="CourseList?category=${cat}">${cat}</a></li>
                            </c:forEach>
                    </ul>
                </div>

                <div class="sidebar-section featured-courses">
                    <h3>Featured Courses</h3>
                    <ul>
                        <c:forEach var="f" items="${featuredSubjects}">
                            <li><a href="CourseDetail?id=${f.courseID}"><i class="fas fa-crown"></i> ${f.courseTitle}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <script>
            let currentMediaIndex = 0;
            const totalMediaSlides = document.querySelectorAll('.media-slide').length;

            function showMediaSlide(index) {
                // Ẩn tất cả slides
                document.querySelectorAll('.media-slide').forEach((slide, i) => {
                    slide.classList.remove('active');
                    if (i === index) {
                        slide.classList.add('active');
                    }

                    // Pause video nếu có
                    const video = slide.querySelector('video');
                    if (video) {
                        video.pause();
                    }
                });

                // Update indicators
                document.querySelectorAll('.media-indicator').forEach((indicator, i) => {
                    indicator.classList.remove('active');
                    if (i === index) {
                        indicator.classList.add('active');
                    }
                });

                // Update counter
                document.getElementById('currentMediaIndex').textContent = index + 1;

                // Update button states
                document.getElementById('prevMediaBtn').disabled = (index === 0);
                document.getElementById('nextMediaBtn').disabled = (index === totalMediaSlides - 1);
            }

            function changeMediaSlide(direction) {
                if (totalMediaSlides === 0)
                    return;

                currentMediaIndex += direction;
                if (currentMediaIndex < 0) {
                    currentMediaIndex = 0;
                } else if (currentMediaIndex >= totalMediaSlides) {
                    currentMediaIndex = totalMediaSlides - 1;
                }

                showMediaSlide(currentMediaIndex);
            }

            function goToMediaSlide(index) {
                if (index >= 0 && index < totalMediaSlides) {
                    currentMediaIndex = index;
                    showMediaSlide(currentMediaIndex);
                }
            }

            // Auto-slide functionality (optional)
            function startMediaAutoSlide() {
                setInterval(() => {
                    if (totalMediaSlides > 1) {
                        currentMediaIndex = (currentMediaIndex + 1) % totalMediaSlides;
                        showMediaSlide(currentMediaIndex);
                    }
                }, 5000); // Change slide every 5 seconds
            }

            // Initialize media slider
            function initMediaSlider() {
                if (totalMediaSlides > 0) {
                    showMediaSlide(0);
                    // Uncomment below line to enable auto-slide
                    // startMediaAutoSlide();
                }
            }

            // Review slider functions (existing code)
            let currentReview = 0;
            function showReview(index) {
                const slides = document.querySelectorAll(".review-slide");
                slides.forEach((s, i) => {
                    s.classList.remove("active");
                    if (i === index)
                        s.classList.add("active");
                });
            }

            function changeReview(offset) {
                const slides = document.querySelectorAll(".review-slide");
                currentReview = (currentReview + offset + slides.length) % slides.length;
                showReview(currentReview);
            }

            // Initialize when page loads
            window.addEventListener('DOMContentLoaded', function () {
                initMediaSlider();
            });
        </script>

    </body>
</html>