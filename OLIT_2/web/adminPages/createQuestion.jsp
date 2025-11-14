<%-- 
    Document   : createQuestion
    Created on : Jul 24, 2025, 4:15:16 PM
    Author     : Long0
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Create Question</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #f0f2f5;
                color: #333;
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
                padding: 40px 16px;
            }


            .form-section {
                width: 100%;
                max-width: 600px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                padding: 24px;
            }

            h1 {
                margin-bottom: 24px;
                font-size: 26px;
                font-weight: 600;
                color: #22313f;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #555;
            }

            .form-control,
            .form-select {
                width: 100%;
                padding: 10px 14px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color .3s, box-shadow .3s;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
                outline: none;
            }

            .answer-group {
                position: relative;
                margin-bottom: 16px;
                padding: 16px;
                border: 1px solid #e5e7eb;
                border-radius: 6px;
                background: #fafafa;
            }

            .deleteAnswer-btn {
                position: absolute;
                top: 12px;
                right: 12px;
                background: #ef4444;
                color: #fff;
                border: none;
                border-radius: 4px;
                width: 28px;
                height: 28px;
                font-weight: bold;
                cursor: pointer;
                transition: background .3s;
            }

            .deleteAnswer-btn:hover {
                background: #dc2626;
            }

            .add-btn,
            .save-btn,
            .delete-btn {
                margin-top: 20px;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background .3s, box-shadow .3s;
            }

            .add-btn {
                background: #3b82f6;
                color: #fff;
            }

            .add-btn:hover {
                background: #2563eb;
            }

            .save-btn {
                background: #10b981;
                color: #fff;
                float: right;
            }

            .save-btn:hover {
                background: #059669;
            }

            .delete-btn {
                background: #ef4444;
                color: #fff;
                float: left;
            }

            .delete-btn:hover {
                background: #dc2626;
            }

            .arrow-btn {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(255, 255, 255, 0.8);
                border: none;
                font-size: 24px;
                cursor: pointer;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                transition: background .3s, transform .3s;
                z-index: 10;
            }

            .back-btn {
                display: inline-block;
                margin-bottom: 16px;
                padding: 8px 16px;
                background: #f1f5f9;
                color: #2563eb;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                transition: background .2s, color .2s;
                border: 1px solid #cbd5e1;
            }

            .back-btn:hover {
                background: #2563eb;
                color: #fff;
            }

            .page-wrapper {
                display: flex;
                justify-content: center;
                align-items: flex-start; /* hoặc center nếu muốn giữa cả theo chiều dọc */
                min-height: 100vh;
                padding: 40px 16px;
            }

        </style>
    </head>

    <body>
        <div class="container">
            <div class="form-section">
                <a href="${pageContext.request.contextPath}/QuestionListServlet" class="back-btn">← Back to Question List</a>

                <h1>Create A New Question</h1>

                <c:if test="${not empty errorMessage}">
                    <p style="color: red; margin-bottom: 15px;">${errorMessage}</p>
                </c:if>

                <form action="${pageContext.request.contextPath}/CreateQuestionServlet" method="post">
                    <input type="hidden" name="userID" value="${sessionScope.userID}" />

                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <select id="subject" name="subject" class="form-select" required="true">
                            <c:forEach var="sj" items="${subjects}">
                                <option value="${sj.subjectID}" ${selectedSubject == sj.subjectID ? 'selected' : ''}>${sj.subjectName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Dimension(s)</label>
                        <c:forEach var="d" items="${dimensions}">
                            <input type="checkbox" name="dimensions" value="${d.dimensionID}"
                                   ${fn:contains(paramValues.dimensions, d.dimensionID) ? 'checked' : ''}>${d.dimensionName}<br>
                        </c:forEach>
                    </div>
                    <div class="form-group">
                        <label>Lesson</label>
                        <select name="lesson" class="form-select" required="true">
                            <c:forEach var="l" items="${lessons}">
                                <option value="${l.lessonID}" ${selectedLesson == l.lessonID ? 'selected' : ''}>${l.lessonTitle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" class="form-select" required="true">
                            <option value="1" ${selectedStatus == 1 ? 'selected' : ''}>Active</option>
                            <option value="0" ${selectedStatus == 0 ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="lv">Level</label>
                        <select id="lv" name="lv" class="form-select" required="true">
                            <option value="1" ${selectedLevel == 1 ? 'selected' : ''}>Easy</option>
                            <option value="2" ${selectedLevel == 2 ? 'selected' : ''}>Medium</option>
                            <option value="3" ${selectedLevel == 3 ? 'selected' : ''}>Hard</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="questionContent">Content</label>
                        <input id="questionContent" name="questionContent" class="form-control" required value="${questionContent != null ? fn:escapeXml(questionContent) : ''}"/>
                    </div>

                    <div id="answersContainer">
                        <c:choose>
                            <c:when test="${not empty paramValues.newAnswerDetail}">
                                <c:forEach var="i" begin="0" end="${fn:length(paramValues.newAnswerDetail) - 1}">
                                    <div class="answer-group">
                                        <div class="form-group">
                                            <label>Answer</label>
                                            <input name="newAnswerDetail" class="form-control" placeholder="Answer" required value="${fn:escapeXml(paramValues.newAnswerDetail[i])}"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Explanation</label>
                                            <input name="newExplanation" class="form-control" placeholder="Explanation" value="${fn:escapeXml(paramValues.newExplanation[i])}"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Correct?</label>
                                            <select name="newIsCorrect" class="form-select" required="true">
                                                <option value="1" ${paramValues.newIsCorrect[i] == 1 ? 'selected' : ''}>Correct</option>
                                                <option value="0" ${paramValues.newIsCorrect[i] == 0 ? 'selected' : ''}>Incorrect</option>
                                            </select>
                                        </div>
                                        <button type="button" class="deleteAnswer-btn" onclick="this.parentElement.remove()">&times;</button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="answer-group">
                                    <div class="form-group">
                                        <label>Answer</label>
                                        <input name="newAnswerDetail" class="form-control" placeholder="Answer" required="true"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Explanation</label>
                                        <input name="newExplanation" class="form-control" placeholder="Explanation"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Correct?</label>
                                        <select name="newIsCorrect" class="form-select" required="true">
                                            <option value="1">Correct</option>
                                            <option value="0">Incorrect</option>
                                        </select>
                                    </div>
                                    <button type="button" class="deleteAnswer-btn" onclick="this.parentElement.remove()">&times;</button>
                                </div>
                                <div class="answer-group">
                                    <div class="form-group">
                                        <label>Answer</label>
                                        <input name="newAnswerDetail" class="form-control" placeholder="Answer" required="true"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Explanation</label>
                                        <input name="newExplanation" class="form-control" placeholder="Explanation"/>
                                    </div>
                                    <div class="form-group">
                                        <label>Correct?</label>
                                        <select name="newIsCorrect" class="form-select" required="true">
                                            <option value="1">Correct</option>
                                            <option value="0">Incorrect</option>
                                        </select>
                                    </div>
                                    <button type="button" class="deleteAnswer-btn" onclick="this.parentElement.remove()">&times;</button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button type="button" class="add-btn" onclick="addAnswer()">+ Add Answer</button>
                    <button type="submit" class="save-btn">Add new question</button>
                </form>
            </div>

            <script>
                
                // Delete an existing answer using AJAX
                function deleteAnswer(id) {
                    const params = new URLSearchParams({action: 'deleteAnswer', qaId: id, questionID: questionID});
                    fetch('${pageContext.request.contextPath}/QuestionDetailServlet', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                        body: params.toString()
                    })
                            .then(res => res.text()).then(txt => {
                        if (txt.trim() === 'success')
                            document.getElementById('ans-' + id).remove();
                        else
                            alert('Delete failed: ' + txt);
                    });
                }
                
                // Dynamically add a new answer block to the form
                function addAnswer() {
                    const c = document.getElementById('answersContainer'), d = document.createElement('div');
                    d.className = 'answer-group';
                    d.innerHTML = `
                        <div class="form-group">
                            <label>Answer</label>
                            <input name="newAnswerDetail" class="form-control" placeholder="Answer" required/>
                        </div>
                        <div class="form-group">
                            <label>Explanation</label>
                            <input name="newExplanation" class="form-control" placeholder="Explanation"/>
                        </div>
                        <div class="form-group">
                            <label>Correct?</label>
                            <select name="newIsCorrect" class="form-select">
                                <option value="1">Correct</option>
                                <option value="0">Incorrect</option>
                            </select>
                        </div>
                        <button type="button" class="deleteAnswer-btn" onclick="this.parentElement.remove()">&times;</button>
                    `;
                    c.appendChild(d);
                }

                // Validate form before submitting
                document.querySelector('form').addEventListener('submit', function(event) {
                    // Count new answer inputs
                const answerDetails = document.querySelectorAll('input[name="newAnswerDetail"]');
                // Check for at least two answers
                if (answerDetails.length < 2) {
                alert('A question must have at least 2 answers.');
                        event.preventDefault(); // Ngăn form gửi đi
                        return;
                }

                // Ensure at least one correct answer is selected
                let hasCorrectAnswer = false;
                        const isCorrectOptions = document.querySelectorAll('select[name="newIsCorrect"]');
                        for (let i = 0; i < isCorrectOptions.length; i++) {
                if (isCorrectOptions[i].value === '1') { // Value '1' cho Correct
                hasCorrectAnswer = true;
                        break;
                }
                }

                if (!hasCorrectAnswer) {
                alert('At least one answer must be marked as correct.');
                        event.preventDefault(); // Ngăn form gửi đi
                        return;
                }

                // Check all 'required' input fields dynamically
                const requiredInputs = document.querySelectorAll('#answersContainer input[required], #answersContainer select[required]');
                        for (let i = 0; i < requiredInputs.length; i++) {
                if (!requiredInputs[i].value.trim()) {
                alert('Please fill in all required answer fields.');
                        event.preventDefault();
                        return;
                }
                }

            </script>

    </body>

</html>
