<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Composants du plat | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/choix_quantite.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">Composants du plat</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Quantité et unité pour chaque composant sélectionné</h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty composants}">
                                        <div class="alert alert-danger">
                                            Aucun composant sélectionné. 
                                            <a href="${pageContext.request.contextPath}/plats/creer_plat" class="alert-link">Retour à la création de plat</a>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty composants}">
                                        <form method="post" action="${pageContext.request.contextPath}/plats/inserer_details_plat">
                                            <div class="mb-4">
                                                <label class="form-label">Nom du plat :</label>
                                                <select name="nomPlat" class="form-select" required>
                                                    <option value="">-- Sélectionner un plat --</option>
                                                    <c:forEach var="p" items="${plats_montree}">
                                                        <option value="${p.intitule}">${p.intitule}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <!-- Transmettre les composants sélectionnés sous forme de champs hidden -->
                                            <c:forEach var="comp" items="${composants}">
                                                <input type="hidden" name="composantsSelectionnes" value="${comp.id}" />
                                            </c:forEach>

                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Composant</th>
                                                            <th>Quantité</th>
                                                            <th>Unité</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="comp" items="${composants}">
                                                            <tr>
                                                                <td>${comp.nom}</td>
                                                                <td>
                                                                    <input type="number" class="form-control" name="quantite_${comp.id}" step="0.01" min="0" required>
                                                                </td>
                                                                <td>
                                                                    <select name="unite_${comp.id}" class="form-select">
                                                                        <option value="kg">kg</option>
                                                                        <option value="g">g</option>
                                                                        <option value="L">L</option>
                                                                        <option value="ml">ml</option>
                                                                        <option value="pc">pc</option>
                                                                    </select>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="d-flex justify-content-end mt-4">
                                                <a href="${pageContext.request.contextPath}/plats/creer_plat" class="btn btn-outline-secondary me-2">
                                                    <i class="bi bi-arrow-left me-1"></i> Retour
                                                </a>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-save me-1"></i> Enregistrer le plat
                                                </button>
                                            </div>
                                        </form>
                                    </c:if>

                                    <c:if test="${not empty detailsPlats}">
                                        <hr class="my-4">
                                        <h5 class="card-title mb-3">Détails du plat sélectionné :</h5>
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Nom du plat</th>
                                                        <th>Composant</th>
                                                        <th>Quantité</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="dp" items="${detailsPlats}">
                                                        <tr>
                                                            <td>${dp.plat.intitule}</td>
                                                            <td>${dp.composant.nom}</td>
                                                            <td>${dp.quantite} ${dp.unite}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
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