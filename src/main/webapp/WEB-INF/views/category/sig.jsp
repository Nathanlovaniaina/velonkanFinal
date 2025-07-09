<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Catégories</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #888;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #eee;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">Liste des Catégories</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
