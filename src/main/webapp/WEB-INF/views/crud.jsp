<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Gestion des Tâches</h2>

    <!-- Formulaire Ajouter / Modifier -->
    <div class="card mb-4">
        <div class="card-header">
            ${empty tache.id ? 'Ajouter une tâche' : 'Modifier la tâche #'+tache.id}
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/taches/save" method="post">
                <input type="hidden" name="id" value="${tache.id}" />

                <div class="mb-3">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" class="form-control" id="nom" name="nom" value="${tache.nom}" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    ${empty tache.id ? 'Ajouter' : 'Mettre à jour'}
                </button>

                <c:if test="${not empty tache.id}">
                    <a href="${pageContext.request.contextPath}/taches" class="btn btn-secondary">Annuler</a>
                </c:if>
            </form>
        </div>
    </div>

    <!-- Tableau des Tâches -->
    <div class="card">
        <div class="card-header">Liste des Tâches</div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${taches}" var="t">
                    <tr>
                        <td>${t.id}</td>
                        <td>${t.nom}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/taches/edit?id=${t.id}" class="btn btn-sm btn-warning">Modifier</a>
                            <a href="${pageContext.request.contextPath}/taches/delete?id=${t.id}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Supprimer cette tâche ?')">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
