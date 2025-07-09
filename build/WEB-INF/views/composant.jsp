<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Composants | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">
                            <i class="bi bi-box-seam me-2"></i>Gestion des Composants
                        </h1>
                        <p class="text-muted mb-0">Gérez vos ingrédients et composants alimentaires avec facilité</p>
                    </div>

                    <c:if test="${not empty succes}">
                        <div class="success-message">
                            <i class="bi bi-check-circle-fill"></i>
                            ${succes}
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i class="bi bi-plus-circle me-2"></i>
                                        ${empty composant.id ? 'Ajouter un nouveau' : 'Modifier le'} composant
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="save" method="post">
                                        <input type="hidden" name="id" value="${composant.id}">
                                        
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label for="nom" class="form-label">
                                                        <i class="bi bi-tag me-1"></i>
                                                        Nom du composant
                                                    </label>
                                                    <input type="text" 
                                                           id="nom" 
                                                           name="nom" 
                                                           value="${composant.nom}" 
                                                           class="form-control"
                                                           required 
                                                           placeholder="Ex: Carotte, Tomate, Basilic...">
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label for="idType" class="form-label">
                                                        <i class="bi bi-tags me-1"></i>
                                                        Type de composant
                                                    </label>
                                                    <select id="idType" name="idType" class="form-select" required>
                                                        <option value="">-- Sélectionnez un type --</option>
                                                        <c:forEach items="${typesComposant}" var="type">
                                                            <option value="${type.id}" ${composant.typeComposant != null && composant.typeComposant.id == type.id ? 'selected' : ''}>
                                                                ${type.nom}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label for="idUnite" class="form-label">
                                                        <i class="bi bi-ruler me-1"></i>
                                                        Unité de mesure
                                                    </label>
                                                    <select id="idUnite" name="idUnite" class="form-select" required>
                                                        <option value="">-- Sélectionnez une unité --</option>
                                                        <c:forEach items="${unites}" var="unite">
                                                            <option value="${unite.id}" ${composant.unite != null && composant.unite.id == unite.id ? 'selected' : ''}>
                                                                ${unite.symbol} (${unite.nom})
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-1"></i>
                                                Enregistrer le composant
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i class="bi bi-list-check me-2"></i>
                                        Liste des composants
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty composants}">
                                        <div class="empty-state">
                                            <i class="bi bi-box"></i>
                                            <h3>Aucun composant disponible</h3>
                                            <p>Commencez par ajouter votre premier composant alimentaire</p>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty composants}">
                                        <div class="table-responsive">
                                            <table id="composantsTable" class="table table-hover" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Nom</th>
                                                        <th>Type</th>
                                                        <th>Unité</th>
                                                        <th class="text-end">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${composants}" var="comp">
                                                        <tr>
                                                            <td>${comp.id}</td>
                                                            <td>
                                                                <div class="d-flex align-items-center gap-2">
                                                                    <i class="bi bi-carrot" style="color: var(--primary-color);"></i>
                                                                    ${comp.nom}
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge-type">
                                                                    ${comp.typeComposant.nom}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <span class="badge bg-light text-dark">
                                                                    ${comp.unite.symbol} (${comp.unite.nom})
                                                                </span>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="d-flex gap-2 justify-content-end">
                                                                    <a href="edit?id=${comp.id}" class="action-btn action-edit">
                                                                        <i class="bi bi-pencil"></i>
                                                                        Modifier
                                                                    </a>
                                                                    <a href="delete?id=${comp.id}" 
                                                                       class="action-btn action-delete" 
                                                                       onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer le composant \"${comp.nom}\" ?')">
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
                                    </c:if>
                                    
                                    <div class="quick-actions">
                                        <a href="${pageContext.request.contextPath}/type_composant/" class="btn btn-outline-primary">
                                            <i class="bi bi-plus-circle me-1"></i>
                                            Nouveau type de composant
                                        </a>
                                        <a href="${pageContext.request.contextPath}/unite/" class="btn btn-outline-primary">
                                            <i class="bi bi-plus-circle me-1"></i>
                                            Nouvelle unité de mesure
                                        </a>
                                    </div>
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
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    $(document).ready(function() {
        // Initialisation des selects
        $('#idType, #idUnite').select2({
            theme: 'bootstrap-5',
            width: '100%'
        });

        // Initialisation de DataTable si le tableau existe
        if ($('#composantsTable').length) {
            $('#composantsTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                },
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                responsive: true,
                columnDefs: [
                    { 
                        targets: [4], 
                        orderable: false,
                        searchable: false
                    },
                    {
                        targets: [0],
                        width: '5%'
                    },
                    {
                        targets: [2, 3],
                        width: '15%'
                    },
                    {
                        targets: [4],
                        width: '20%'
                    }
                ],
                order: [[1, 'asc']], // Tri par nom par défaut
                pageLength: 10,
                initComplete: function() {
                    // Ajoute une classe au champ de recherche
                    $('.dataTables_filter input').addClass('form-control');
                }
            });
        }
    });
    </script>
</body>
</html>