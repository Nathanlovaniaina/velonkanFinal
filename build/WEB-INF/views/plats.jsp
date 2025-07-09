<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Plats | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/plats.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">Gestion des Plats</h1>
                    </div>

                    <div class="row">
                        <div class="col-12 col-lg-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Formulaire Plat</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/plats/save" method="post">
                                        <input type="hidden" name="id" value="${plat.id}" />
                                        
                                        <div class="mb-3">
                                            <label for="intitule" class="form-label">Nom du plat</label>
                                            <input type="text" class="form-control" id="intitule" name="intitule" value="${plat.intitule}" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="prix" class="form-label">Prix (Ar)</label>
                                            <input type="number" class="form-control" id="prix" name="prix" value="${plat.prix != 0 ? plat.prix : ''}" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="dateCreation" class="form-label">Date de création</label>
                                            <input type="date" class="form-control" id="dateCreation" name="dateCreation" value="<%= java.time.LocalDate.now() %>" readonly>
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
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Liste des Plats</h5>
                                    <a href="${pageContext.request.contextPath}/plats/creer_plat" class="btn btn-sm btn-primary">
                                        <i class="bi bi-plus-lg me-1"></i> Nouveau
                                    </a>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover" id="platsTable">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Nom</th>
                                                    <th>Prix</th>
                                                    <th>Date Création</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="e" items="${plats}">
                                                    <tr>
                                                        <td>${e.id}</td>
                                                        <td>${e.intitule}</td>
                                                        <td>${e.prix} Ar</td>
                                                        <td>${e.dateCreation}</td>
                                                        <td>
                                                            <div class="d-flex gap-2">
                                                                <a href="${pageContext.request.contextPath}/plats/edit/?id=${e.id}" class="btn btn-sm btn-outline-primary">
                                                                    <i class="bi bi-pencil"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/plats/delete/${e.id}" 
                                                                   onclick="return confirm('Confirmer la suppression ?')" 
                                                                   class="btn btn-sm btn-outline-danger">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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
    
    <script>
    $(document).ready(function() {
        // Initialisation de DataTables
        $('#platsTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
            },
            responsive: true,
            columnDefs: [
                { orderable: false, targets: 4 } // Désactiver le tri sur la colonne Actions
            ]
        });
    });
    </script>
</body>
</html>