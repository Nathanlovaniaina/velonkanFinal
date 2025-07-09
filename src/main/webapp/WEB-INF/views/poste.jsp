<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Postes | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/poste.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>

    </style>
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
                        <h1 class="h3 d-inline align-middle">Gestion des Postes</h1>
                    </div>

                    <!-- Affichage des messages -->
                    <c:if test="${not empty succes}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${succes}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12 col-lg-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Formulaire Poste</h5>
                                </div>
                                <div class="card-body">
                                    <form action="save" method="post">
                                        <input type="hidden" name="id" value="${poste.id}">
                                        <div class="mb-3">
                                            <label class="form-label">Nom du poste</label>
                                            <input type="text" class="form-control" name="nom" value="${poste.nom}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Salaire</label>
                                            <input type="number" class="form-control" name="salaire" step="0.01" value="${poste.salaire}" required>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-1"></i> Enregistrer
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-lg-6">
                            <c:if test="${not empty postes}">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Liste des Postes</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table id="postesTable" class="table table-striped" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Nom</th>
                                                        <th>Salaire</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="p" items="${postes}">
                                                        <tr>
                                                            <td>${p.nom}</td>
                                                            <td>${p.salaire}</td>
                                                            <td>
                                                                <a href="edit?id=${p.id}" class="btn btn-sm btn-outline-primary me-1" title="Modifier">
                                                                    <i class="bi bi-pencil"></i>
                                                                </a>
                                                                <a href="delete?id=${p.id}" class="btn btn-sm btn-outline-danger" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce poste ?')">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
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
        // Initialisation de DataTable
        $('#postesTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
            },
            responsive: true,
            columnDefs: [
                { orderable: false, targets: 2 }, // Désactiver le tri sur la colonne Actions
                { className: "dt-center", targets: [1, 2] }, // Centrer les colonnes
                { 
                    targets: 1, // Colonne Salaire
                    render: function(data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toFixed(2) + ' Ar';
                        }
                        return data;
                    }
                }
            ],
            order: [[0, 'asc']], // Tri par défaut sur la colonne Nom
            dom: '<"top"f>rt<"bottom"lip><"clear">',
            pageLength: 10,
            initComplete: function() {
                // Personnalisation après l'initialisation
                $('.dataTables_filter input').attr('placeholder', 'Rechercher...');
            }
        });
        
        // Confirmation avant suppression
        $('.btn-outline-danger').click(function(e) {
            if (!confirm('Êtes-vous sûr de vouloir supprimer ce poste ?')) {
                e.preventDefault();
            }
        });
    });
    </script>
</body>
</html>