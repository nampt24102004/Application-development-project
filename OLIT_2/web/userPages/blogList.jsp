<%-- 
    Document   : blogList
    Created on : Jun 1, 2025, 10:33:52 PM
    Author     : Khai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <style>

/* Box sizing and base styles */
*, *::before, *::after {
  box-sizing: border-box;
}
body {
  margin: 0;
  font-family: 'Segoe UI', sans-serif;
  background: linear-gradient(to right, #f9f9f9, #e6f0ff);
  color: #333;
  line-height: 1.5;
}

/* Header (included via components/header.jsp) */
.header {
  background: linear-gradient(to right, #4a90e2, #0077cc);
  color: white;
  padding: 20px 40px;
  min-height: 70px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 10;
}
.header .logo-text {
  font-size: 1.8rem;
  font-weight: 700;
  letter-spacing: 1.2px;
}
.header .nav-links {
  display: flex;
  align-items: center;
  gap: 30px;
}
.header .nav-links a {
  color: white;
  text-decoration: none;
  font-weight: 500;
  font-size: 1rem;
  transition: color 0.3s ease;
}
.header .nav-links a:hover {
  color: #ffcc00;
  text-decoration: underline;
}
.header .nav-links .admin-btn {
  background: #ffc107;
  color: #1e1e1e;
  padding: 6px 12px;
  border-radius: 4px;
}
.header .nav-links .admin-btn:hover {
  background: #e0a800;
}

/* Main container layout */
.container {
  display: flex;
  flex-wrap: wrap;
  padding: 30px 40px;
  gap: 30px;
}
.left {
  flex: 2;
  min-width: 300px;
}
.right {
  flex: 1;
  min-width: 250px;
}

/* Blog cards */
.blog-card {
  background: #fff;
  margin-bottom: 25px;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.05);
  display: flex;
  gap: 20px;
  transition: transform 0.2s ease;
}
.blog-card:hover {
  transform: translateY(-3px);
}
.blog-card img {
  width: 220px;
  height: 140px;
  object-fit: cover;
  border-radius: 10px;
}
.blog-info h3,
.latest-blogs h3 {
  margin-top: 0;
  margin-bottom: 10px;
  color: #0077cc;
}
.blog-info h3 a {
  text-decoration: none;
  color: inherit;
}
.blog-info p {
  margin: 5px 0;
}

/* Search box */
.search-box form {
  display: flex;
  gap: 8px;
}
.search-box input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 15px;
}
.search-box button {
  background-color: #0077cc;
  color: white;
  border: none;
  padding: 10px 14px;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
.search-box button:hover {
  background-color: #005fa3;
}

/* Filter form */
.filter-form {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}
.category-select {
  flex: 1;
  padding: 10px;
  font-size: 14px;
  background-color: #e0f4ff;
  border: 1px solid #0c98cf;
  border-radius: 6px;
  outline: none;
  transition: border-color 0.3s ease;
}
.category-select:focus {
  border-color: #2196f3;
  box-shadow: 0 0 5px rgba(33,150,243,0.4);
}
.filter-btn {
  padding: 6px 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}
.filter-btn:hover {
  background-color: #0056b3;
}

/* Latest blogs sidebar */
.latest-blogs .blog-card {
  flex-direction: column;
  align-items: start;
}
.latest-blogs .blog-card img {
  width: 100%;
  height: 150px;
  object-fit: cover;
}

/* Footer */
footer {
  background-color: #333;
  color: white;
  padding: 20px 40px;
  text-align: center;
  margin-top: 40px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .header {
    flex-direction: column;
    align-items: flex-start;
    padding: 15px 20px;
    gap: 10px;
  }
  .header .nav-links {
    flex-wrap: wrap;
    gap: 15px;
  }
  .container {
    flex-direction: column;
    padding: 20px;
  }
  .nav-links a {
    margin: 0;
  }
}
.latest-blogs h3 {
  font-size: 1.5rem;
  margin-top: 2rem;
  margin-bottom: 1rem;
  color: #333;
}

/* Blog cards */
.blog-card {
  display: flex;
  margin-bottom: 1rem;
}
.blog-card img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 1rem;
}
.blog-info h4 {
  margin: 0;
  font-size: 1.1rem;
}
.blog-info p {
  margin: 0.25rem 0 0;
  font-size: 0.85rem;
  color: #666;
}

/* Contact links styled like a list of cards */
.contact-links {
  list-style: none;
  padding: 0;
  margin: 1rem 0 0;
}
.contact-links li {
  display: flex;
  align-items: center;
  margin-bottom: 0.75rem;
}
.contact-links i {
  font-size: 1.2rem;
  margin-right: 0.5rem;
  color: #0077cc;
}
.contact-links a {
  font-size: 1rem;
  color: #0077cc;
  text-decoration: none;
}
.contact-links a:hover {
  text-decoration: underline;
}

    </style>
    <header>

        <jsp:include page="components/header.jsp"/>

        

    </header>


    <body>       

        <div class="container">

            <!-- Phần hiển thị danh sách blog -->
            <div class="left" id="blog-list">
                <c:choose>
                    <c:when test="${not empty blogList}">
                        <c:forEach var="blog" items="${blogList}">
                            <div class="blog-card">
                                <a href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${blog.postID}">
                                    <img src="${blog.thumbnailURL}" alt="Blog Image">
                                </a>
                                <div class="blog-info">
                                    <h3>
                                        <a href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${blog.postID}">                                      
                                            ${blog.blogTitle}</a></h3>
                                    <p>Tác giả: <strong>${blog.getAccount().getFullName()}</strong></p> <!-- Bạn có thể sửa userID thành tên nếu truy vấn SQL có -->
                                    <p>Ngày đăng: ${blog.updatedDate}</p>
                                    <p>Thể loại: <strong>${blog.getPostCategory().getCategoryName()}</strong></p> <!-- Tương tự categoryID có thể đổi tên thể loại -->
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>Không có blog nào được tìm thấy.</p>
                    </c:otherwise>
                </c:choose>

                <!-- Bạn có thể thêm nhiều blog-card ở đây -->
            </div>

            <!-- Phần sidebar: tìm kiếm, thể loại, blog mới -->
            <div class="right">

                <!-- Search box -->
                <div class="search-box">
                    <form action="${pageContext.request.contextPath}/BlogListServlet" method="get">
                        <input
                            type="text"
                            name="search"
                            placeholder="🔍 Tìm kiếm blog..."
                            value="${param.search}"
                            />
                        <button type="submit">Tìm kiếm</button>
                    </form>
                </div>

                <!-- Category filter -->
                <form action="${pageContext.request.contextPath}/BlogListServlet" method="get" class="filter-form">
                    <label for="category-select">Category:</label>
                    <select id="category-select" name="categoryId" class="category-select">
                        <option value="">-- Pick a Category --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option
                                value="${cat.categoryID}"
                                <c:if test="${param.categoryId == cat.categoryID}">selected</c:if>
                                    >
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="filter-btn">Lọc</button>
                </form>

                <!-- …rest of your widgets (latest posts, contacts…)… -->



                <div class="latest-blogs">
                    <h3>🆕 Newest Posts</h3>
                    <c:forEach var="post" items="${newestPosts}">
                        <div class="blog-card">
                            <a href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${post.postID}">
                                <img src="${post.thumbnailURL}" alt="Latest Blog">
                            </a>
                            <div class="blog-info">
                                <h4>
                                    <a href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${post.postID}">
                                        ${post.blogTitle}
                                    </a>
                                </h4>
                                <p>${post.updatedDate} – ${post.postCategory.categoryName}</p>
                            </div>
                        </div>
                    </c:forEach>
                <h3>Contact &amp; Links</h3>
                <ul>
                    <li>
                        <i class="bi bi-facebook"></i>
                        <a href="${facebookLink}" target="_blank">Facebook</a>
                    </li>
                    <li>
                        <i class="bi bi-envelope-fill"></i>
                        <a href="mailto:${supportEmail}">Email Us</a>
                    </li>
                    <li>
                        <i class="bi bi-info-circle-fill"></i>
                        <a href="${pageContext.request.contextPath}${aboutPage}">About Us</a>
                    </li>
                    <li>
                        <i class="bi bi-telephone-fill"></i>
                        <a href="${pageContext.request.contextPath}${contactPage}">Contact Page</a>
                    </li>
                </ul>
                </div>
            </div>
        </div>

        <jsp:include page="components/footer.jsp"/>

    </body>

</html>

