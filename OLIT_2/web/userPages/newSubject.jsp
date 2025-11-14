<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>New Subject</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>

        <div class="container mt-5">
            <h2>New Subject</h2>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/newSubject" method="post" enctype="multipart/form-data">
                <!-- Subject Name -->
                <div class="mb-3">
                    <label for="subjectName" class="form-label">Name</label>
                    <input type="text" class="form-control" id="subjectName" name="subjectName" required>
                </div>

                <!-- Images & Videos -->
                <div class="mb-3">
                    <label class="form-label">Images & Videos</label>
                    <div id="previewList" class="list-group mb-2"></div>
                    <input type="file"
                           id="mediaFiles"
                           name="mediaFiles"
                           multiple
                           accept="image/*,video/*"
                           class="form-control">
                </div>

                <!-- Featured -->
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="featured" name="featuredFlag">
                    <label class="form-check-label" for="featured">Featured</label>
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label>Category</label>
                    <select name="category" required>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Owner -->
                <div class="mb-3">
                    <label>Owner (Expert)</label>
                    <select name="ownerId" required>
                        <c:forEach var="expert" items="${expertList}">
                            <option value="${expert.userID}">${expert.fullName}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Status -->
                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input"
                                   type="radio"
                                   name="status"
                                   id="published"
                                   value="1"
                                   checked>
                            <label class="form-check-label" for="published">Published</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input"
                                   type="radio"
                                   name="status"
                                   id="draft"
                                   value="0">
                            <label class="form-check-label" for="draft">Draft</label>
                        </div>
                    </div>
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea id="description"
                              name="description"
                              class="form-control"
                              rows="3"></textarea>
                </div>

                <!-- Buttons -->
                <button type="submit" class="btn btn-primary">Save</button>
                <button type="reset" class="btn btn-outline-secondary">Reset</button>
                <a href="SubjectList" class="btn btn-outline-danger">Cancel</a>
            </form>
        </div>

        <script>
            const mediaInput = document.getElementById('mediaFiles');
            const previewList = document.getElementById('previewList');

            mediaInput.addEventListener('change', () => {
                previewList.innerHTML = '';
                Array.from(mediaInput.files).forEach((file, idx) => {
                    const item = document.createElement('div');
                    item.className = 'd-flex align-items-center mb-2 list-group-item';

                    let thumb;
                    if (file.type.startsWith('image/')) {
                        thumb = document.createElement('img');
                        thumb.src = URL.createObjectURL(file);
                        thumb.style.height = '40px';
                        thumb.className = 'me-2';
                    } else {
                        thumb = document.createElement('div');
                        thumb.textContent = 'Video';
                        thumb.className = 'me-2';
                    }

                    const label = document.createElement('span');
                    label.textContent = file.name;

                    // Input nhập tên file tuỳ chỉnh
                    const customInput = document.createElement('input');
                    customInput.type = 'text';
                    customInput.placeholder = 'Custom filename';
                    customInput.name = 'customFileName';   // servlet sẽ gọi getParameterValues
                    customInput.className = 'form-control form-control-sm mb-1';

                    const btn = document.createElement('button');
                    btn.type = 'button';
                    btn.innerHTML = '&times;';
                    btn.className = 'btn-close ms-auto';
                    btn.onclick = () => {
                        const dt = new DataTransfer();
                        Array.from(mediaInput.files)
                                .filter((_, i) => i !== idx)
                                .forEach(f => dt.items.add(f));
                        mediaInput.files = dt.files;
                        item.remove();
                    };

                    item.append(thumb, label, customInput, btn);
                    previewList.append(item);
                });
            });
        </script>
    </body>
</html>
