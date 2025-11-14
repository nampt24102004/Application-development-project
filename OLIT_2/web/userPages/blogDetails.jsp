<%-- 
    Document   : blogDetails
    Created on : Jul 14, 2025, 2:55:02 PM
    Author     : khain
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
    />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${post.blogTitle}</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/userPages/assets/css/blog-details.css">
        <jsp:include page="components/header.jsp"/>
    </head>
    <body>


        <!-- Breadcrumb -->
        <nav class="breadcrumb">
            <a href="${pageContext.request.contextPath}/HomeServlet">Home</a> 
            <a href="${pageContext.request.contextPath}/BlogListServlet">Blog</a> 
            <a href="${pageContext.request.contextPath}/BlogListServlet?categoryId=${post.postCategory.categoryID}">
                ${post.postCategory.categoryName}
            </a> 
            <span>${post.blogTitle}</span>
        </nav>

        <div class="container">
            <!-- Main Article -->
            <article class="post-detail">
                <h1>${post.blogTitle}</h1>
                <div class="post-meta">
                    <span class="author">By ${post.account.fullName}</span>
                    <span class="date">${post.updatedDate}</span>
                </div>

                <c:if test="${not empty post.thumbnailURL}">
                    <img src="${post.thumbnailURL}" 
                         alt="${post.blogTitle}" 
                         class="featured-img"/>
                </c:if>

                <div class="post-body">
                    <pre style="text-align: left;"><c:out value="${post.postDetails}" escapeXml="false"/></pre>
                </div>
            </article>

            <!-- Sidebar -->
            <aside class="sidebar">
                <!-- Search -->
                <section class="widget search-widget">
                    <form action="${pageContext.request.contextPath}/BlogListServlet" method="get">
                        <input
                            type="text"
                            name="search"
                            placeholder="Search posts..."
                            value="${param.search}"
                            />
                        <button type="submit">Go</button>
                    </form>
                </section>
                <br><!-- comment -->
                <!-- Categories -->
                <form action="${pageContext.request.contextPath}/BlogListServlet" method="get" class="filter-form">
                    <label for="category-select">Category:</label>
                    <select id="category-select" name="categoryId" class="category-select">
                        <option value="">-- Pick a category --</option>
                        <c:forEach var="category" items="${categories}">
                            <option
                                value="${category.categoryID}"
                                <c:if test="${param.categoryId == category.categoryID}">selected</c:if>
                                    >
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="filter-btn">Search</button>
                </form>


                <!-- Latest Posts -->
                <section class="widget latest-widget">
                    <h2>Latest Posts</h2>
                    <div class="latest-posts-list">
                        <c:forEach var="lp" items="${latestPosts}">
                            <div class="latest-post-item">
                                <a href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${lp.postID}">
                                    <img 
                                        src="${lp.thumbnailURL}" 
                                        alt="${lp.blogTitle}" 
                                        class="latest-thumb"/>
                                </a>
                                <div class="latest-info">
                                    <a 
                                        href="${pageContext.request.contextPath}/BlogDetailsServlet?postID=${lp.postID}" 
                                        class="latest-title">
                                        ${lp.blogTitle}
                                    </a>
                                    <div class="latest-meta">
                                        <span class="latest-author">By ${lp.account.fullName}</span>
                                        <span class="latest-date">${lp.updatedDate}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Contact & Links -->
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
                    </br>
                </section>    
            </aside>
        </div>

        <!-- Footer -->
        <footer>
            <jsp:include page="components/footer.jsp"/>

        </footer>
    </body>
</html>
