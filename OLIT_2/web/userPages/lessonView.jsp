<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Online Learning Platform - Course Viewer</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/userPages/assets/css/lesson-view.css" rel="stylesheet">
        <style>
            .lesson.completed {
                background-color: #2e2e42;
                border-left: 4px solid #00c896;
                color: #ccc;
            }
            .lesson.completed:hover {
                background-color: #3a3a5c;
            }
            .lesson.completed i,
            .lesson.completed span {
                color: #00c896;
            }

            .quiz-section {
                background-color: #1a1a2e;
                border: 1px solid #2e2e42;
                border-radius: 10px;
                padding: 12px 16px;
                margin: 12px 0;
                color: #f0f0f0;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s ease, box-shadow 0.3s ease;
                font-size: 14px;
            }

            .quiz-section:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            .quiz-section h4 {
                font-size: 15px;
                margin-bottom: 6px;
                color: #fff;
                display: flex;
                align-items: center;
                gap: 6px;
                line-height: 1.3;

            }

            .quiz-section p {
                font-size: 13px;
                color: #ccc;
                margin-bottom: 10px;
                line-height: 1.4;
            }

            .quiz-section button {
                background-color: #fff;
                color: #000;
                border: none;
                padding: 6px 12px;
                border-radius: 5px;
                font-size: 13px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .quiz-section button:hover {
                background-color: #ff6b81;
            }
            .course-progress {
                margin: 20px 0;
            }

            .progress-bar {
                background-color: #2a2a3b;
                height: 14px;
                width: 100%;
                border-radius: 10px;
                overflow: hidden;
                margin-bottom: 5px;
            }

            .progress-fill {
                background-color: #00c896;
                height: 100%;
                width: 0%;
                transition: width 0.4s ease-in-out;
            }

            .progress-percent {
                font-size: 13px;
                color: #ccc;
            }

        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h1 class="logo"><i class="fas fa-graduation-cap"></i>Course Aura</h1>
                </div>
                <nav class="sidebar-nav">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/HomeServlet"><i class="fas fa-home"></i> Home</a></li>
                        <li class="active"><a href="#"><i class="fas fa-book-open"></i> My Courses</a></li>
                        <li><a href="${pageContext.request.contextPath}/UserProfile"><i class="fas fa-user"></i> Profile</a></li>
                        <li><a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div class="content-header">
                    <h2>${course.courseTitle}</h2>
                    <div class="course-actions">
                        <div class="layout-toggle">
                            <button id="list-view" class="active"><i class="fas fa-list"></i> List</button>
                            <button id="grid-view"><i class="fas fa-th-large"></i> Grid</button>
                        </div>
                    </div>
                </div>

                <div class="course-progress">
                    <div class="progress-bar">
                        <div class="progress-fill"
                             style="width:
                             <c:choose>
                                 <c:when test='${totalLessons > 0}'>
                                     <fmt:formatNumber value='${(completedCount * 100.0) / totalLessons}' maxFractionDigits='2' />%
                                 </c:when>
                                 <c:otherwise>0%</c:otherwise>
                             </c:choose>;"
                             ></div>
                    </div>
                    <div class="progress-percent">
                        <c:choose>
                            <c:when test="${totalLessons > 0}">
                                <fmt:formatNumber value="${(completedCount * 100.0) / totalLessons}" maxFractionDigits="2" />%

                            </c:when>
                            <c:otherwise>0%</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="course-content-area">
                    <!-- Vertical List View (Default) -->
                    <div id="list-container" class="course-list-container">
                        <c:forEach var="section" items="${sectionList}">
                            <div class="section">
                                <div class="section-header">
                                    <h3>${section.sectionTitle}</h3>
                                    <span class="section-info"></span>
                                    <i class="fas fa-chevron-down"></i>
                                </div>

                                <div class="section-content">
                                    <c:forEach var="module" items="${section.modules}">
                                        <div class="module">
                                            <div class="module-header">
                                                <h4>${module.moduleTitle}</h4>
                                                <i class="fas fa-chevron-down"></i>
                                            </div>

                                            <div class="module-content">
                                                <c:forEach var="lesson" items="${module.lessons}">
                                                    <div class="lesson ${completedLessonSet.contains(lesson.lessonID) ? 'completed' : ''}" 
                                                         data-lesson-id="${lesson.lessonID}" 
                                                         data-url="${lesson.URLLesson}" 
                                                         onclick="console.log('📦 lessonID =', '${lesson.lessonID}'); selectLesson(this)">

                                                        <div class="lesson-icon">
                                                            <c:choose>
                                                                <c:when test="${fn:endsWith(lesson.URLLesson, '.html')}">
                                                                    <i class="fas fa-file-alt"></i> <!-- Icon cho HTML bài học -->
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-play-circle"></i> <!-- Icon cho YouTube -->
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <span>${lesson.lessonTitle}</span>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${section.quiz != null}">
                                    <div class="quiz-section">
                                        <h4><i class="fas fa-question-circle"></i> Quiz: ${section.quiz.quizName}</h4>
                                        <p>Type: ${section.quiz.quizType} | Duration: ${section.quiz.quizDuration} mins | Level: ${section.quiz.quizLevel}</p>
                                        <button onclick="startQuiz(${section.quiz.quizID})">Start Quiz</button>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Grid View (Hidden by default) -->
                    <div id="grid-container" class="course-grid-container" style="display: none;">
                        <!-- Grid items will be populated by JavaScript -->
                    </div>

                    <!-- Lesson Content Area -->
                    <div class="lesson-content">
                        <div class="empty-lesson">
                            <i class="fas fa-book-open"></i>
                            <h3>Select a lesson to begin</h3>
                            <p>Choose a lesson from the list to start learning</p>
                        </div>                       
                    </div>
                </div>
            </main>
        </div>
        <div id="grid-modal" class="modal-overlay" style="display: none;">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <h2>Choose a lesson</h2>
                <div id="modal-grid-container" class="modal-grid-container"></div>
            </div>
        </div>
        <script>
            const contextPath = '${pageContext.request.contextPath}';
            function selectLesson(el) {
            const title = el.querySelector('span').textContent;
            const url = el.getAttribute('data-url');
            const lessonId = el.getAttribute('data-lesson-id');
            console.log("📥 Selected lessonId =", lessonId);
            if (!lessonId) {
            alert("⚠️ lessonId missing!");
            return;
            }

            const lessonContent = document.querySelector('.lesson-content');
            let html = '<div class="selected-lesson"><h3>' + title + '</h3>';
            document.querySelectorAll('.lesson').forEach(el => el.classList.remove('active'));
            el.classList.add('active');
            // 4a. Nếu .html nội bộ
            if (url.endsWith('.html')) {
            const cleanPath = url.startsWith('/') ? url : '/' + url;
            const src = contextPath.replace(/\/$/, '') + cleanPath;
            // show header luôn, rồi mới fetch nội dung
            lessonContent.innerHTML = html;
            fetch(src)
                    .then(res => {
                    if (!res.ok) throw new Error(res.status);
                    return res.text();
                    })
                    .then(html => {
                    const wrapper = document.createElement('div');
                    wrapper.className = 'lesson-html-content';
                    wrapper.innerHTML = html;
                    lessonContent.appendChild(wrapper);
                    lessonContent.appendChild(wrapper);
                    setTimeout(() => markLessonCompleted(lessonId), 30000);
                    })
                    .catch(err => {
                    console.error(err);
                    const errP = document.createElement('p');
                    errP.style.color = 'red';
                    errP.textContent = 'Không tải được nội dung bài học.';
                    lessonContent.appendChild(errP);
                    lessonContent.appendChild(errP);
                    });
            // 4b. Nếu YouTube
            } else {
            const id = extractYouTubeId(url);
            html += `<div id="yt-player"></div>`;
            html += '</div>';
            lessonContent.innerHTML = html;
            // Load YouTube iframe API nếu chưa có
            if (!window.YT) {
            const tag = document.createElement('script');
            tag.src = "https://www.youtube.com/iframe_api";
            document.body.appendChild(tag);
            }

            // Lưu để gọi sau khi API sẵn sàng
            window.onYouTubeIframeAPIReady = function () {
            window.ytPlayer = new YT.Player('yt-player', {
            height: '315',
                    width: '560',
                    videoId: id,
                    events: {
                    'onStateChange': function (event) {
                    if (event.data === YT.PlayerState.ENDED) {
                    markLessonCompleted(lessonId);
                    }
                    }
                    }
            });
            };
            // Nếu API đã sẵn sàng rồi
            if (window.YT && YT.Player) {
            window.onYouTubeIframeAPIReady();
            }
            }
            }






            function markLessonCompleted(lessonId) {
            console.log('✅ Marking completed lessonId =', lessonId);
            fetch(contextPath + '/lesson-progress', {
            method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'lessonId=' + encodeURIComponent(lessonId)
            })
                    .then(res => res.text())
                    .then(text => {
                    console.log('📨 Response from server:', text);
                    location.reload(); // Hoặc update progress UI thay vì reload
                    })
                    .catch(err => console.error('❌ Error marking complete:', err));
            }



            function selectLessonByData(title, url, lessonId) {
            const lessonContent = document.querySelector('.lesson-content');
            let html = '<div class="selected-lesson"><h3>' + title + '</h3>';
            if (url.match(/^https?:\/\//) && url.endsWith('.html')) {
            html += `<iframe src="${url}" frameborder="0" style="width:100%;height:100%;"></iframe>`;
            } else if (url.endsWith('.html')) {
            html += `<iframe src="${contextPath + url}" frameborder="0" style="width:100%;height:100%;"></iframe>`;
            } else {
            const id = extractYouTubeId(url);
            html += `<iframe width="560" height="315" src="https://www.youtube.com/embed/${id}" frameborder="0" allowfullscreen></iframe>`;
            }

            html += '</div>';
            lessonContent.innerHTML = html;
            fetch(contextPath + '/lesson-progress', {
            method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({ lessonId })
            }).then(res => {
            if (!res.ok) throw new Error('Failed to mark complete');
            return res.json();
            }).then(data => {
            console.log('Marked completed!', data);
            location.reload();
            }).catch(console.error);
            }

            function extractYouTubeId(url) {
            const regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
            const match = url.match(regExp);
            return (match && match[7].length === 11) ? match[7] : null;
            }

            document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.section-header').forEach(header => {
            header.addEventListener('click', () => {
            header.classList.toggle('open');
            header.nextElementSibling.classList.toggle('open');
            });
            });
            document.querySelectorAll('.module-header').forEach(header => {
            header.addEventListener('click', () => {
            header.classList.toggle('open');
            header.nextElementSibling.classList.toggle('open');
            });
            });
            });
            function renderListLayout(data) {
            const container = document.querySelector('.course-list-container');
            container.innerHTML = '';
            data.forEach((section, sIndex) => {
            const sectionEl = document.createElement('div');
            sectionEl.className = 'section';
            const sectionHeader = document.createElement('div');
            sectionHeader.className = 'section-header';
            const h3 = document.createElement('h3');
            h3.textContent = section.title;
            const span = document.createElement('span');
            span.className = 'section-info';
            const icon = document.createElement('i');
            icon.className = 'fas fa-chevron-down';
            sectionHeader.appendChild(h3);
            sectionHeader.appendChild(span);
            sectionHeader.appendChild(icon);
            const sectionContent = document.createElement('div');
            sectionContent.className = 'section-content';
            section.modules.forEach((module, mIndex) => {
            const moduleEl = document.createElement('div');
            moduleEl.className = 'module';
            const moduleHeader = document.createElement('div');
            moduleHeader.className = 'module-header';
            const h4 = document.createElement('h4');
            h4.textContent = module.title;
            const icon = document.createElement('i');
            icon.className = 'fas fa-chevron-down';
            moduleHeader.appendChild(h4);
            moduleHeader.appendChild(icon);
            const moduleContent = document.createElement('div');
            moduleContent.className = 'module-content';
            // Append lessons
            module.lessons.forEach((lesson, lIndex) => {
            const lessonEl = document.createElement('div');
            lessonEl.className = 'lesson';
            const iconDiv = document.createElement('div');
            iconDiv.className = 'lesson-icon';
            iconDiv.innerHTML = '<i class="fas fa-play-circle"></i>';
            const span = document.createElement('span');
            span.textContent = lesson;
            lessonEl.appendChild(iconDiv);
            lessonEl.appendChild(span);
            lessonEl.onclick = () => {
            document.querySelectorAll('.lesson').forEach(l => l.classList.remove('active'));
            lessonEl.classList.add('active');
            selectLesson(lesson);
            };
            moduleContent.appendChild(lessonEl);
            });
            moduleHeader.onclick = () => {
            moduleHeader.classList.toggle('open');
            moduleContent.classList.toggle('open');
            };
            moduleEl.appendChild(moduleHeader);
            moduleEl.appendChild(moduleContent);
            sectionContent.appendChild(moduleEl);
            });
            sectionHeader.onclick = () => {
            sectionHeader.classList.toggle('open');
            sectionContent.classList.toggle('open');
            console.log(sectionContent);
            };
            sectionEl.appendChild(sectionHeader);
            sectionEl.appendChild(sectionContent);
            container.appendChild(sectionEl);
            });
            }


            document.addEventListener('DOMContentLoaded', () => {
            renderListLayout(courseData);
            });
            document.addEventListener('DOMContentLoaded', () => {
            const listBtn = document.getElementById('list-view');
            const gridBtn = document.getElementById('grid-view');
            const listContainer = document.getElementById('list-container');
            const modal = document.getElementById('grid-modal');
            const modalGrid = document.getElementById('modal-grid-container');
            const closeModal = document.querySelector('.close-modal');
            // Hiện list view
            listBtn.addEventListener('click', () => {
            listContainer.style.display = 'block';
            modal.style.display = 'none';
            listBtn.classList.add('active');
            gridBtn.classList.remove('active');
            });
            // Hiện modal grid
            gridBtn.addEventListener('click', () => {
            listContainer.style.display = 'none';
            modal.style.display = 'flex';
            listBtn.classList.remove('active');
            gridBtn.classList.add('active');
            renderModalGrid();
            });
            closeModal.addEventListener('click', () => {
            modal.style.display = 'none';
            });
            function renderModalGrid() {
            modalGrid.innerHTML = '';
            const courseData = [
            <c:forEach var="section" items="${sectionList}" varStatus="sIndex">
            {
            title: "Section ${sIndex.index + 1}",
                    modules: [
                <c:forEach var="module" items="${section.modules}" varStatus="mIndex">
                    {
                    title: "Module ${mIndex.index + 1}",
                            lessons: [
                    <c:forEach var="lesson" items="${module.lessons}" varStatus="lIndex">
                            {
                            id: "${lesson.lessonID}",
                                    title: "${lesson.lessonTitle}",
                                    url: "${lesson.URLLesson}"
                            }<c:if test="${!lIndex.last}">,</c:if>
                    </c:forEach>
                            ]
                    }<c:if test="${!mIndex.last}">,</c:if>
                </c:forEach>
                    ]
            }<c:if test="${!sIndex.last}">,</c:if>
            </c:forEach>
            ];
            courseData.forEach(section => {
            section.modules.forEach(module => {
            module.lessons.forEach(lesson => {
            const card = document.createElement('div');
            card.className = 'grid-card';
            const iconDiv = document.createElement('div');
            iconDiv.className = 'grid-icon';
            iconDiv.innerHTML = lesson.url.endsWith('.html')
                    ? '<i class="fas fa-file-alt"></i>'
                    : '<i class="fas fa-play-circle"></i>';
            const lessonTitleEl = document.createElement('h4');
            lessonTitleEl.className = 'grid-title';
            lessonTitleEl.textContent = lesson.title;
            const infoEl = document.createElement('div');
            infoEl.className = 'grid-meta';
            const sectionSpan = document.createElement('span');
            sectionSpan.textContent = section.title;
            const separator = document.createElement('span');
            separator.textContent = ' • ';
            const moduleSpan = document.createElement('span');
            moduleSpan.textContent = module.title;
            infoEl.appendChild(sectionSpan);
            infoEl.appendChild(separator);
            infoEl.appendChild(moduleSpan);
            card.appendChild(iconDiv);
            card.appendChild(lessonTitleEl);
            card.appendChild(infoEl);
            card.onclick = () => {
            selectLessonByData(lesson.title, lesson.url, lesson.id);
            modal.style.display = 'none';
            };
            modalGrid.appendChild(card);
            });
            });
            });
            }
            });

        </script>
    </body>
</html> 