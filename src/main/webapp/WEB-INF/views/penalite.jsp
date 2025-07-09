<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion de pénalité | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/penalite.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <!-- Sidebar -->
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
                        <h1 class="h3 d-inline align-middle">Gestion des pénalités</h1>
                    </div>

                    <!-- Affichage des messages -->
                    <c:if test="${not empty erreur}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${erreur}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty succes}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${succes}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <c:choose>
                                            <c:when test="${empty penalite.id}">Ajouter une pénalité</c:when>
                                            <c:otherwise>Modifier la pénalité</c:otherwise>
                                        </c:choose>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="save" method="post">
                                        <input type="hidden" name="id" value="${penalite.id}" />
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="nb_jour" class="form-label">Nombre de jours d'absence</label>
                                                    <input type="number" class="form-control" id="nb_jour" name="nb_jour" 
                                                           value="${penalite.nbJour}" required min="1">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="pourcent" class="form-label">Pourcentage de réduction</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" id="pourcent" name="pourcent" 
                                                               value="${penalite.pourcentage}" required min="0" max="100">
                                                        <span class="input-group-text">%</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-check-lg me-1"></i> Enregistrer
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des pénalités</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${not empty penalites}">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Nombre de jours d'absence</th>
                                                            <th>Pourcentage de réduction</th>
                                                            <th class="text-end">Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="p" items="${penalites}">
                                                            <tr>
                                                                <td>${p.nbJour}</td>
                                                                <td>${p.pourcentage}%</td>
                                                                <td class="text-end">
                                                                    <a href="edit?id=${p.id}" class="btn btn-sm btn-outline-primary me-1">
                                                                        <i class="bi bi-pencil"></i> Modifier
                                                                    </a>
                                                                    <a href="delete?id=${p.id}" class="btn btn-sm btn-outline-danger">
                                                                        <i class="bi bi-trash"></i> Supprimer
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted py-4">
                                                <i class="bi bi-info-circle" style="font-size: 2rem;"></i>
                                                <p class="mt-2">Aucune pénalité définie</p>
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