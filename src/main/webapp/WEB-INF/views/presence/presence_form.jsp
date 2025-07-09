<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Pointage Employé</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body">
            <h2 class="card-title mb-4">🕒 Pointage Employé</h2>

            <form action="${pageContext.request.contextPath}/presences/presence/save" method="post">
                <div class="mb-3">
                    <label for="identification" class="form-label">👤 Numéro d’identification</label>
                    <input type="text" id="identification" name="numero_identification" class="form-control" placeholder="EMP001" required>
                </div>
                <button type="submit" class="btn btn-primary">➕ Enregistrer la présence</button>
            </form>
        </div>
    </div>
</div>

<!-- Lien vers la liste des présences (à activer si nécessaire) -->
<!-- <a href="${pageContext.request.contextPath}/presences/presence/list">Voir la liste</a> -->

<!-- Scripts Bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
