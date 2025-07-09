<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Types de Composant | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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
                            <i class="bi bi-layer-group me-2"></i>Gestion des Types de Composant
                        </h1>
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
                                        ${empty typeComposant.id ? 'Créer un nouveau' : 'Modifier le'} type de composant
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="save" method="post">
                                        <input type="hidden" name="id" value="${typeComposant.id}">
                                        
                                        <div class="mb-3">
                                            <label for="nom" class="form-label">
                                                <i class="bi bi-tag me-2"></i>
                                                Nom du type
                                            </label>
                                            <input type="text" 
                                                   id="nom" 
                                                   name="nom" 
                                                   value="${typeComposant.nom}" 
                                                   class="form-control"
                                                   required 
                                                   placeholder="Ex: Légume, Fruit, Épice, Viande, Poisson, Céréale...">
                                        </div>
                                        
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-2"></i>
                                                Enregistrer
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
                                    <h5 class="card-title mb-0">
                                        <i class="bi bi-list-ul me-2"></i>
                                        Liste des types de composant
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty typesComposant}">
                                        <div class="empty-state">
                                            <i class="bi bi-layer-group"></i>
                                            <h3>Aucun type de composant disponible</h3>
                                            <p>Créez votre premier type pour organiser vos ingrédients</p>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty typesComposant}">
                                        <div class="table-responsive">
                                            <table id="typesTable" class="table table-hover" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Nom du type</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${typesComposant}" var="type">
                                                        <tr>
                                                            <td>${type.id}</td>
                                                            <td>
                                                                <div class="type-badge">
                                                                    <i class="bi bi-circle-fill" style="font-size: 0.5rem;"></i>
                                                                    ${type.nom}
                                                                </div>
                                                            </td>
                                                            <td class="table-actions">
                                                                <a href="edit?id=${type.id}" class="action-btn action-edit">
                                                                    <i class="bi bi-pencil"></i>
                                                                    Modifier
                                                                </a>
                                                                <a href="delete?id=${type.id}" 
                                                                   class="action-btn action-delete" 
                                                                   onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer le type \"${type.nom}\" ?\\n\\nAttention : Cette action supprimera aussi tous les composants associés à ce type.')">
                                                                    <i class="bi bi-trash"></i>
                                                                    Supprimer
                                                                </a>
                                                            </td>
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
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    $(document).ready(function() {
        // Initialisation de DataTables
        if ($('#typesTable').length) {
            $('#typesTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                },
                responsive: true,
                columnDefs: [
                    { 
                        targets: 0,
                        className: 'dt-body-center',
                        width: '80px'
                    },
                    { 
                        targets: 2,
                        orderable: false,
                        searchable: false,
                        width: '200px'
                    }
                ],
                order: [[1, 'asc']], // Tri par nom par défaut
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                pageLength: 10,
                initComplete: function() {
                    // Personnalisation du champ de recherche
                    $('.dataTables_filter input')
                        .attr('placeholder', 'Rechercher un type...')
                        .addClass('form-control form-control-sm');
                    
                    // Personnalisation du select de pagination
                    $('.dataTables_length select')
                        .addClass('form-select form-select-sm');
                }
            });
        }

        // Confirmation avant suppression
        $('.action-delete').on('click', function(e) {
            if (!confirm($(this).attr('onclick').match(/return confirm\('([^']+)'/)[1])) {
                e.preventDefault();
            }
        });
    });
    </script>
</body>
</html>