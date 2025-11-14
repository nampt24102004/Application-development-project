<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.PricePackage" %>
<html>
<head>
    <title>Add Package to Course</title>
    <style>
        body {
            background: #f6f8fa;
            font-family: Arial, sans-serif;
        }
        .package-form {
            background: #fff;
            max-width: 400px;
            margin: 40px auto;
            padding: 32px 24px 24px 24px;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
        }
        .package-form h2 {
            text-align: center;
            margin-bottom: 24px;
        }
        .package-form label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }
        .package-form input, .package-form select, .package-form textarea {
            width: 100%;
            padding: 8px 10px;
            margin-bottom: 16px;
            border: 1px solid #d0d7de;
            border-radius: 6px;
            font-size: 15px;
        }
        .package-form button {
            width: 100%;
            padding: 10px;
            background: #0969da;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .package-form button:hover {
            background: #054da7;
        }
        .package-form .message {
            text-align: center;
            color: #22863a;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
<div class="package-form">
    <h2>Add Package to Course</h2>
    <% String message = (String) request.getAttribute("message"); if (message != null) { %>
        <div class="message"><%= message %></div>
    <% } %>
    <form action="AddPackageServlet" method="post">
        <input type="hidden" name="courseID" value="${courseID}" />
        <label for="packageName">Package Name:</label>
        <select id="packageName" name="packageName" required>
            <% 
                List<model.PricePackage> samplePackages = (List<model.PricePackage>) request.getAttribute("samplePackages");
                if (samplePackages != null) {
                    for (model.PricePackage pkg : samplePackages) {
            %>
                <option value="<%= pkg.getName() %>"><%= pkg.getName() %> (Duration: <%= pkg.getAccessDuration() %> days, List: <%= pkg.getListPrice() %>, Sale: <%= pkg.getSalePrice() %>)</option>
            <%      }
                }
            %>
        </select>
        <input type="hidden" id="duration" name="duration" />
        <input type="hidden" id="listPrice" name="listPrice" />
        <input type="hidden" id="salePrice" name="salePrice" />
        <input type="hidden" id="description" name="description" />
        <button type="submit">Add Package</button>
    </form>
    <script>
        var packages = [
            <% if (samplePackages != null) {
                for (int i = 0; i < samplePackages.size(); i++) {
                    model.PricePackage pkg = samplePackages.get(i);
            %>
            {
                name: "<%= pkg.getName().replaceAll("\"", "\\\"") %>",
                duration: "<%= pkg.getAccessDuration() %>",
                listPrice: "<%= pkg.getListPrice() %>",
                salePrice: "<%= pkg.getSalePrice() %>",
                description: "<%= pkg.getDescription() != null ? pkg.getDescription().replaceAll("\"", "\\\"") : "" %>"
            }<%= (i < samplePackages.size() - 1) ? "," : "" %>
            <%  }
            } %>
        ];
        function fillPackageFields() {
            var select = document.getElementById('packageName');
            var idx = select.selectedIndex;
            if (idx >= 0) {
                var pkg = packages[idx];
                document.getElementById('duration').value = pkg.duration;
                document.getElementById('listPrice').value = pkg.listPrice;
                document.getElementById('salePrice').value = pkg.salePrice;
                document.getElementById('description').value = pkg.description;
            }
        }
        document.getElementById('packageName').addEventListener('change', fillPackageFields);
        window.onload = fillPackageFields;
    </script>
</div>
</body>
</html> 