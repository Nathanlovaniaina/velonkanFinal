<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des stocks</title>
</head>
<body>
    <h1>Gestion des stocks</h1>

    <!-- Messages -->
    <c:if test="${not empty erreur}">
        <div style="color: red;">${erreur}</div>
    </c:if>
    <c:if test="${not empty succes}">
        <div style="color: green;">${succes}</div>
    </c:if>

    <!-- Formulaire d'insertion / modification -->
    <form action="${pageContext.request.contextPath}/stock/save" method="post">
        <table>
            <tr>
            <th></th>
            <th>Composant</th>
            <th>Date de creation</th>
            <th>Quantité</th>
            <th>Nombre de jour conservation</th>
            </tr>
            <tr>
                <td><input type="hidden" name="id" value="${stock.id}" /></td>
                <td><select name="id_composant" required>
                    <c:if test="${not empty stock.composant}">
                    <option value="${stock.composant.id}" selected>${stock.composant.nom}</option>
                    </c:if>
                    <c:forEach var="c" items="${composants}">
                    <c:if test="${stock.composant == null || c.id != stock.composant.id}">
                    <option value="${c.id}">${c.nom}</option>
                    </c:if>
                    </c:forEach>
                    </select>
                </td>
                <td><input type="date" name="date_creation" value="${stock.date_creation}" /></td>
                <td><input type="number" name="qtte_stock" value="${stock.qtte_stock}"></td>
                <td><input type="number" name="nombre_jour_conservation" value="${stock.nombre_jour_conservation}"></td>
            </tr>
        </table>
        <button>Ajouter une ligne</button>
        <input type="submit" value="Enregistrer" />
    </form>
</body>
</html>
