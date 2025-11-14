<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Student course management</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background: #f5f6fa;
                margin: 0;
                font-family: 'Segoe UI', Arial, sans-serif;
            }
            .container {
                max-width: 98vw;
                margin: 40px auto;
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 6px 32px rgba(30,136,229,0.10);
                padding: 18px 8px;
            }
            .header-bar {
                background: linear-gradient(90deg, #1e88e5 0%, #42a5f5 100%);
                color: #fff;
                border-radius: 14px 14px 0 0;
                padding: 28px 0 18px 0;
                text-align: center;
                box-shadow: 0 2px 8px rgba(30,136,229,0.08);
                margin-bottom: 24px;
            }
            .header-bar h1 {
                font-size: 2.3rem;
                font-weight: 700;
                margin: 0;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
            }
            .header-bar h1 i {
                font-size: 2.1rem;
            }
            .table-responsive {
                width: 100%;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                margin-bottom: 10px;
            }
            table {
                min-width: 1200px;
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 10px;
                background: #fafdff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 2px 12px rgba(30,136,229,0.06);
            }
            th, td {
                padding: 14px 10px;
                text-align: left;
                white-space: nowrap;
            }
            th {
                background: #e3f0fc;
                color: #0d6efd;
                font-size: 1.05em;
                font-weight: 600;
                border-bottom: 2px solid #cbe3fa;
            }
            td {
                background: #fff;
                border-bottom: 1px solid #f0f4f8;
                font-size: 1em;
            }
            tr:last-child td {
                border-bottom: none;
            }
            tr:hover td {
                background: #f0f7ff;
                transition: background 0.2s;
            }
            .btn-delete {
                background: linear-gradient(90deg, #e53935 0%, #ff7043 100%);
                color: #fff;
                border: none;
                padding: 8px 18px;
                border-radius: 7px;
                cursor: pointer;
                font-weight: 600;
                font-size: 1em;
                box-shadow: 0 2px 8px rgba(229,57,53,0.08);
                transition: background 0.2s, box-shadow 0.2s;
            }
            .btn-delete:hover {
                background: linear-gradient(90deg, #b71c1c 0%, #ff7043 100%);
                box-shadow: 0 4px 16px rgba(229,57,53,0.15);
            }
            .success-message {
                background: #d1fae5;
                color: #065f46;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 16px;
                text-align: center;
                font-weight: 500;
            }
            .error-message {
                background: #fee2e2;
                color: #991b1b;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 16px;
                text-align: center;
                font-weight: 500;
            }
            @media (max-width: 900px) {
                .container {
                    padding: 4px 0;
                }
                th, td {
                    padding: 8px 4px;
                    font-size: 0.98em;
                }
                .header-bar h1 {
                    font-size: 1.3rem;
                }
            }
            @media (max-width: 600px) {
                .table-responsive {
                    padding: 0;
                }
                table, thead, tbody, th, td, tr {
                    display: block;
                    min-width: unset;
                }
                th {
                    position: absolute;
                    left: -9999px;
                    top: -9999px;
                }
                tr {
                    margin-bottom: 18px;
                    border-radius: 10px;
                    box-shadow: 0 2px 8px #e3f0fc;
                }
                td {
                    border: none;
                    position: relative;
                    padding-left: 50%;
                    min-height: 38px;
                }
                td:before {
                    position: absolute;
                    left: 12px;
                    top: 12px;
                    width: 45%;
                    white-space: nowrap;
                    font-weight: bold;
                    color: #0d6efd;
                    font-size: 0.98em;
                }
                td:nth-of-type(1):before {
                    content: "ID";
                }
                td:nth-of-type(2):before {
                    content: "Họ tên";
                }
                td:nth-of-type(3):before {
                    content: "Email";
                }
                td:nth-of-type(4):before {
                    content: "Số điện thoại";
                }
                td:nth-of-type(5):before {
                    content: "Tên khoá học";
                }
                td:nth-of-type(6):before {
                    content: "Gói học";
                }
                td:nth-of-type(7):before {
                    content: "Giá";
                }
                td:nth-of-type(8):before {
                    content: "Ngày đăng ký";
                }
                td:nth-of-type(9):before {
                    content: "Thời hạn";
                }
                td:nth-of-type(10):before {
                    content: "Thao tác";
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="../userPages/components/header.jsp" />
        <div class="container">
            <div class="header-bar">
                <h1><i class="fa-solid fa-users"></i> Student course management</h1>
            </div>
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Number Phone</th>
                            <th>Course</th>
                            <th>Package</th>
                            <th>Price</th>
                            <th>Registration date</th>
                            <th>Duration</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reg" items="${registrationList}" varStatus="loop">
                            <tr>
                                <td><i class="fa-solid fa-id-badge" style="color:#1e88e5;"></i> ${loop.index + 1}</td>
                                <td><i class="fa-solid fa-user"></i> ${reg.userFullName}</td>
                                <td><i class="fa-solid fa-envelope"></i> ${reg.userEmail}</td>
                                <td><i class="fa-solid fa-phone"></i> ${reg.userPhone}</td>
                                <td><i class="fa-solid fa-book"></i> ${reg.course.courseTitle}</td>
                                <td><i class="fa-solid fa-box"></i> ${reg.pricePackage.name}</td>
                                <td><i class="fa-solid fa-money-bill-wave"></i> ${reg.pricePackage.salePrice} VNĐ</td>
                                <td><i class="fa-solid fa-calendar-plus"></i> ${reg.validFrom}</td>
                                <td><i class="fa-solid fa-calendar-days"></i> ${reg.validFrom} - ${reg.validTo}</td>
                                <td>
                                    <form method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this subscription?');">
                                        <input type="hidden" name="action" value="deleteRegistration" />
                                        <input type="hidden" name="registrationID" value="${reg.registrationID}" />
                                        <button type="submit" class="btn-delete"><i class="fa-solid fa-trash"></i> Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty registrationList}">
                            <tr><td colspan="10" style="text-align:center; color:#888;">No login data.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="../userPages/components/footer.jsp" />
    </body>
</html> 