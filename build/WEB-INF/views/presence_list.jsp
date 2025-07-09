<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des présences</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card p-4 shadow">
        <h2 class="mb-4">
            Liste des présences
            <img src="${pageContext.request.contextPath}/pic/vélokan.png" alt="Présence Icon" style="width: 30px; height: 30px; vertical-align: middle;">
        </h2>

        <!-- Filtrage (à connecter au backend si besoin) -->
        <form method="get" action="${pageContext.request.contextPath}/presences/presence/list">
            <div class="d-flex gap-2 mb-3">
                <input type="date" class="form-control" name="date" value="${param.date}">
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        Tous
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <button class="dropdown-item" type="submit" name="filtre" value="poste">Poste</button>
                        <button class="dropdown-item" type="submit" name="filtre" value="statut">Statut</button>
                    </div>
                </div>
                <button class="btn btn-secondary" style="background:#007e5d;">🔍 Filtrer</button>
            </div>
        </form>

        <!-- Table de présence -->
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Date</th>
                <th>Employé</th>
                <th>Poste</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="presence" items="${presences}">
                <tr>
                    <td><c:out value="${presence.datePresence}"/></td>
                    <td><c:out value="${presence.employe.nom}"/></td>
                    <td><c:out value="${presence.employe.poste.nom}"/></td>
                    <td>
                        <span class="badge bg-success"
                        </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="d-flex justify-content-end gap-2 mt-3">
            <a href="${pageContext.request.contextPath}/presences/presence/export" class="btn btn-light">⬇️ Export Excel</a>
            <a href="${pageContext.request.contextPath}/presences/presence/add" class="btn btn-light" style="background:#007e5d;">➕ Ajouter une présence</a>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
