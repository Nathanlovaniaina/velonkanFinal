<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Unités | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/unite.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/navbar.jsp" />

        <div class="main">
            <!-- Navbar -->
            <nav class="navbar navbar-expand navbar-light navbar-bg">
                <a class="sidebar-toggle js-sidebar-toggle">
                    <i class="hamburger align-self-center"></i>
                </a>

                <div class="navbar-collapse collapse">
                    <ul class="navbar-nav navbar-align">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                                <span class="text-dark">Administrateur</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle">Gestion des Unités de Mesure</h1>
                    </div>

                    <c:if test="${not empty succes}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle me-2"></i>${succes}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i class="bi ${empty unite.id ? 'bi-plus-circle' : 'bi-pencil'} me-2"></i>
                                        ${empty unite.id ? 'Ajouter une nouvelle' : 'Modifier cette'} unité
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="save" method="post" class="row g-3">
                                        <input type="hidden" name="id" value="${unite.id}">
                                        
                                        <div class="col-md-6">
                                            <label for="nom" class="form-label">
                                                <i class="bi bi-tag me-2"></i>
                                                Nom de l'unité
                                            </label>
                                            <input type="text" id="nom" name="nom" value="${unite.nom}" required 
                                                   class="form-control" placeholder="Ex: Kilogramme, Litre, Pièce...">
                                            <div class="form-text">Le nom complet de l'unité de mesure</div>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="symbol" class="form-label">
                                                <i class="bi bi-symbols me-2"></i>
                                                Symbole
                                            </label>
                                            <input type="text" id="symbol" name="symbol" value="${unite.symbol}" required 
                                                   class="form-control" maxlength="5" placeholder="Ex: kg, L, pce...">
                                            <div class="form-text">Symbole court (5 caractères max)</div>
                                        </div>
                                        
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-2"></i>
                                                ${empty unite.id ? 'Créer cette unité' : 'Mettre à jour'}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i class="bi bi-list-ul me-2"></i>
                                        Liste des Unités Disponibles
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty unites}">
                                            <div class="empty-state">
                                                <i class="bi bi-rulers"></i>
                                                <h3>Aucune unité disponible</h3>
                                                <p>Commencez par ajouter votre première unité de mesure</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Détails</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${unites}" var="unite">
                                                            <tr>
                                                                <td>#${unite.id}</td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <span class="unit-symbol">${unite.symbol}</span>
                                                                        <span class="unit-name">${unite.nom}</span>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="d-flex">
                                                                        <a href="edit?id=${unite.id}" class="action-btn action-edit">
                                                                            <i class="bi bi-pencil"></i>
                                                                            Modifier
                                                                        </a>
                                                                        <a href="delete?id=${unite.id}" 
                                                                           class="action-btn action-delete"
                                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer l\\'unité ${unite.nom} (${unite.symbol}) ?')">
                                                                            <i class="bi bi-trash"></i>
                                                                            Supprimer
                                                                        </a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>