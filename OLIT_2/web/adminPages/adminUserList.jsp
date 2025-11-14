<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin - User List</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f8fafc;
            }
            .container {
                max-width: 1200px;
                margin: 30px auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.08);
                padding: 32px;
            }
            h1 {
                color: #4F46E5;
                text-align: center;
                margin-bottom: 32px;
            }
            .actions {
                margin-bottom: 18px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .actions form {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .actions .add-btn {
                background: #4F46E5;
                color: #fff;
                padding: 8px 18px;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                padding: 10px 8px;
                border-bottom: 1px solid #e5e7eb;
                text-align: left;
            }
            th {
                background: #f1f5f9;
                cursor: pointer;
            }
            tr:hover {
                background: #f3f4f6;
            }
            .pagination {
                margin-top: 18px;
                text-align: center;
            }
            .pagination a, .pagination span {
                display: inline-block;
                margin: 0 3px;
                padding: 6px 12px;
                border-radius: 5px;
                background: #e0e7ff;
                color: #3730a3;
                text-decoration: none;
            }
            .pagination .current {
                background: #4F46E5;
                color: #fff;
                font-weight: bold;
            }
            .filter-select, .search-input {
                padding: 6px 10px;
                border-radius: 5px;
                border: 1px solid #bcd;
            }
            .action-btn {
                padding: 5px 12px;
                border-radius: 5px;
                border: none;
                margin-right: 4px;
                cursor: pointer;
            }
            .view-btn {
                background: #38bdf8;
                color: #fff;
            }
            .edit-btn {
                background: #f59e42;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../userPages/components/header.jsp" />
        <div class="container">
            <h1>User List</h1>
            <div class="actions">
                <form method="get">
                    <input class="search-input" type="text" name="search" value="${search}" placeholder="Search by name, email, mobile..." />
                    <select class="filter-select" name="gender">
                        <option value="" <c:if test="${empty gender}">selected</c:if>>All Gender</option>
                        <option value="Male" <c:if test="${gender == 'Male'}">selected</c:if>>Male</option>
                        <option value="Female" <c:if test="${gender == 'Female'}">selected</c:if>>Female</option>
                        <option value="Other" <c:if test="${gender == 'Other'}">selected</c:if>>Other</option>
                        </select>
                        <select class="filter-select" name="role">
                            <option value="" <c:if test="${empty role}">selected</c:if>>All Role</option>
                        <c:forEach var="r" items="${roleList}">
                            <option value="${r.roleID}" <c:if test="${role == r.roleID}">selected</c:if>>${r.roleName}</option>
                        </c:forEach>
                    </select>
                    <select class="filter-select" name="status">
                        <option value="">All Status</option>
                        <option value="active" ${status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        <option value="banned" ${status == 'banned' ? 'selected' : ''}>Banned</option>
                    </select>
                    <button type="submit" class="action-btn view-btn">Filter/Search</button>
                </form>
                <a href="#" class="add-btn" onclick="openAddUserModal(); return false;">+ Add New User</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th><a>Full Name</a></th>
                        <th><a>Gender</a></th>
                        <th><a>Email</a></th>
                        <th><a>Mobile</a></th>
                        <th><a>Role</a></th>
                        <th><a>Status</a></th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}" varStatus="loop">
                        <c:choose>
                            <c:when test="${editUserID != null && editUserID == u.userID}">
                            <form method="post" action="AdminUserListServlet">
                                <tr>
                                    <td><input type="hidden" name="userID" value="${u.userID}" />${(currentPage-1)*10 + loop.index + 1}</td>
                                    <td><input type="text" name="fullName" value="${u.fullName}" style="width:120px;" required /></td>
                                    <td>
                                        <select name="gender" style="width:90px;">
                                            <option value="Male" <c:if test="${u.gender == 'Male'}">selected</c:if>>Male</option>
                                            <option value="Female" <c:if test="${u.gender == 'Female'}">selected</c:if>>Female</option>
                                            <option value="Other" <c:if test="${u.gender == 'Other'}">selected</c:if>>Other</option>
                                            </select>
                                        </td>
                                        <td><input type="email" name="email" value="${u.email}" style="width:160px;" required /></td>
                                    <td><input type="text" name="phoneNumber" value="${u.phoneNumber}" style="width:110px;" required /></td>
                                    <td>
                                        <select name="roleID" style="width:100px;">
                                            <c:forEach var="r" items="${roleList}">
                                                <option value="${r.roleID}" <c:if test="${u.roleID == r.roleID}">selected</c:if>>${r.roleName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <select name="status" style="width:90px;">
                                            <option value="active" <c:if test="${u.status == 'active'}">selected</c:if>>Active</option>
                                            <option value="inactive" <c:if test="${u.status == 'inactive'}">selected</c:if>>Inactive</option>
                                            <option value="banned" <c:if test="${u.status == 'banned'}">selected</c:if>>Banned</option>
                                            </select>
                                        </td>
                                        <td>
                                            <button type="submit" name="action" value="save" class="action-btn edit-btn">Save</button>
                                            <a href="AdminUserListServlet" class="action-btn view-btn">Cancel</a>
                                        </td>
                                    </tr>
                                </form>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td>${(currentPage-1)*10 + loop.index + 1}</td>
                                <td>${u.fullName}</td>
                                <td>${u.gender}</td>
                                <td>${u.email}</td>
                                <td>${u.phoneNumber}</td>
                                <td>
                                    <c:forEach var="r" items="${roleList}">
                                        <c:if test="${u.roleID == r.roleID}">${r.roleName}</c:if>
                                    </c:forEach>
                                </td>
                                <td>${u.status}</td>
                                <td>
                                    <form method="get" action="AdminUserListServlet" style="display:inline;">
                                        <input type="hidden" name="editUserID" value="${u.userID}" />
                                        <button type="submit" class="action-btn edit-btn">Edit</button>
                                    </form>
                                    <form method="post" action="AdminUserListServlet" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                        <input type="hidden" name="userID" value="${u.userID}" />
                                        <button type="submit" name="action" value="delete" class="action-btn view-btn" style="background:#ef4444; color:#fff;">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <c:choose>
                        <c:when test="${p == currentPage}">
                            <span class="current">${p}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${p}">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
        <!-- Modal Add User -->
        <div id="addUserModal" style="display:none; position:fixed; z-index:1000; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.3);">
            <div style="background:#fff; max-width:420px; margin:60px auto; border-radius:10px; box-shadow:0 8px 32px rgba(0,0,0,0.18); padding:32px; position:relative;">
                <span onclick="closeAddUserModal()" style="position:absolute; top:12px; right:18px; font-size:22px; cursor:pointer; color:#888;">&times;</span>
                <h2 style="margin-bottom:18px; color:#4F46E5;">Add New User</h2>
                <c:if test="${not empty errorAddUser}">
                    <div style="color:#dc2626; background:#fee2e2; border-radius:6px; padding:8px 12px; margin-bottom:12px;">${errorAddUser}</div>
                </c:if>
                <form method="post" action="AdminUserListServlet">
                    <input type="hidden" name="action" value="add" />
                    <div style="margin-bottom:12px;">
                        <label>Full Name</label>
                        <input type="text" name="fullName" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;" value="<c:out value='${addUserData[0]}'/>" />
                    </div>
                    <div style="margin-bottom:12px;">
                        <label>Gender</label>
                        <select name="gender" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;">
                            <option value="Male" <c:if test="${addUserData[1] == 'Male'}">selected</c:if>>Male</option>
                            <option value="Female" <c:if test="${addUserData[1] == 'Female'}">selected</c:if>>Female</option>
                            <option value="Other" <c:if test="${addUserData[1] == 'Other'}">selected</c:if>>Other</option>
                            </select>
                        </div>
                        <div style="margin-bottom:12px;">
                            <label>Email</label>
                            <input type="email" name="email" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;" value="<c:out value='${addUserData[2]}'/>" />
                    </div>
                    <div style="margin-bottom:12px;">
                        <label>Mobile</label>
                        <input type="text" name="phoneNumber" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;" value="<c:out value='${addUserData[3]}'/>" pattern="0\d{9}" title="Phone number must be 10 digits and start with 0" />
                    </div>
                    <div style="margin-bottom:12px;">
                        <label>Role</label>
                        <select name="roleID" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;">
                            <c:forEach var="r" items="${roleList}">
                                <option value="${r.roleID}" <c:if test="${addUserData[4] == r.roleID}">selected</c:if>>${r.roleName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="margin-bottom:12px;">
                        <label>Status</label>
                        <select name="status" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;">
                            <option value="active" <c:if test="${addUserData[5] == 'active'}">selected</c:if>>Active</option>
                            <option value="inactive" <c:if test="${addUserData[5] == 'inactive'}">selected</c:if>>Inactive</option>
                            <option value="banned" <c:if test="${addUserData[5] == 'banned'}">selected</c:if>>Banned</option>
                            </select>
                        </div>
                        <div style="margin-bottom:12px;">
                            <label>Password</label>
                            <input type="password" name="password" required style="width:100%; padding:7px; border-radius:5px; border:1px solid #ccc;" />
                        </div>
                        <div style="text-align:right;">
                            <button type="button" onclick="closeAddUserModal()" style="margin-right:10px; padding:7px 18px; border-radius:5px; border:none; background:#e5e7eb; color:#333;">Cancel</button>
                            <button type="submit" style="padding:7px 18px; border-radius:5px; border:none; background:#4F46E5; color:#fff; font-weight:600;">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <script>
                function openAddUserModal() {
                    document.getElementById('addUserModal').style.display = 'block';
                }
                function closeAddUserModal() {
                    document.getElementById('addUserModal').style.display = 'none';
                }
                // Tự động mở lại modal nếu có lỗi
            <c:if test="${showAddUserModal}">
                openAddUserModal();
            </c:if>
                // Validate phone 10 digits
                const addUserForm = document.querySelector('#addUserModal form');
                if (addUserForm) {
                    addUserForm.addEventListener('submit', function (e) {
                        const phone = addUserForm.phoneNumber.value.trim();
                        if (!/^0\d{9}$/.test(phone)) {
                            alert('Phone number must be 10 digits and start with 0!');
                            e.preventDefault();
                        }
                    });
                }
        </script>
        <jsp:include page="../userPages/components/footer.jsp" />
    </body>
</html> 