<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Créer un plat | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/creer_plats.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">Créer un plat</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Sélection des composants</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Formulaire de filtre (GET) -->
                                    <form method="get" action="${pageContext.request.contextPath}/plats/creer_plat" class="mb-4">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <label class="form-label">Filtrer par type :</label>
                                                <select name="typeComposantId" class="form-select" onchange="this.form.submit()">
                                                    <option value="">-- Tous les types --</option>
                                                    <c:forEach items="${typesComposant}" var="type">
                                                        <option value="${type.id}" ${param.typeComposantId == type.id ? 'selected' : ''}>
                                                            ${type.nom}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </form>

                                    <form method="get" action="${pageContext.request.contextPath}/plats/choix_quantite">
                                        <h5 class="mb-3">Composants disponibles</h5>

                                        <div class="row">
                                            <c:forEach items="${composants}" var="composant">
                                                <c:if test="${empty param.typeComposantId || fn:trim(composant.typeComposant.id) == fn:trim(param.typeComposantId)}">
                                                    <div class="col-md-4 mb-3">
                                                        <div class="composant-item">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" name="composants" value="${composant.id}" id="composant-${composant.id}">
                                                                <label class="form-check-label" for="composant-${composant.id}">
                                                                    <strong>${composant.nom}</strong>
                                                                    <div class="text-muted small">Type: ${composant.typeComposant.nom}</div>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <div class="d-flex justify-content-end mt-4">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-check-circle me-1"></i> Valider la sélection
                                            </button>
                                        </div>
                                    </form>
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