<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Tâches | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007e5d !important;
            --secondary-color: #f8c828 !important;
            --primary-light: #e6f2ef !important;
            --secondary-light: #fef8e6 !important;
            --dark-color: #2c3e50 !important;
            --light-color: #f8f9fa !important;
            --danger-color: #e74c3c !important;
            --success-color: #2ecc71 !important;
            --info-color: #3498db !important;
        }
        
        body {
            font-family: 'Inter', sans-serif !important;
            color: var(--dark-color) !important;
        }

        .wrapper {
            background: var(--primary-light) !important;
        }
        
        /* Card styling */
        .card {
            border: none !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05) !important;
            border-radius: 10px !important;
            overflow: hidden !important;
        }
        
        .card-header {
            background-color: white !important;
            border-bottom: none !important;
            padding: 1rem 1.5rem !important;
        }

        .card-title {
            color: #007e5d !important;
            font-size: 20px;
        }
        
        /* Button styling */
        .btn-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        .btn-primary:hover {
            background-color: #006a4d !important;
            border-color: #006a4d !important;
        }
        
        .btn-outline-primary {
            color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        /* Form styling */
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
        }
        
        /* Table styling */
        .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background-color: var(--primary-light);
            color: var(--primary-color);
            border-bottom: 1px solid #dee2e6;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 126, 93, 0.05);
        }
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
                        <h1 class="h3 d-inline align-middle">Gestion des Tâches</h1>
                    </div>

                    <!-- Affichage des erreurs -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <!-- Formulaire Ajouter / Modifier -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">${empty tache.id ? 'Ajouter une tâche' : 'Modifier la tâche #'+=tache.id}</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/taches/save" method="post">
                                        <input type="hidden" name="id" value="${tache.id}" />

                                        <div class="mb-3">
                                            <label for="nom" class="form-label">Nom</label>
                                            <input type="text" class="form-control" id="nom" name="nom" value="${tache.nom}" required>
                                        </div>

                                        <div class="d-flex justify-content-end">
                                            <c:if test="${not empty tache.id}">
                                                <a href="${pageContext.request.contextPath}/taches" class="btn btn-outline-secondary me-2">Annuler</a>
                                            </c:if>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi ${empty tache.id ? 'bi-plus-circle' : 'bi-pencil'} me-1"></i>
                                                ${empty tache.id ? 'Ajouter' : 'Mettre à jour'}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Tableau des Tâches -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des Tâches</h5>
                                </div>
                                <div class="card-body p-0">
                                    <table class="table table-striped mb-0">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nom</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${taches}" var="t">
                                            <tr>
                                                <td>${t.id}</td>
                                                <td>${t.nom}</td>
                                                <td class="text-end">
                                                    <a href="${pageContext.request.contextPath}/taches/edit?id=${t.id}" 
                                                       class="btn btn-sm btn-outline-primary me-1">
                                                        <i class="bi bi-pencil"></i> Modifier
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/taches/delete?id=${t.id}" 
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette tâche ?')">
                                                        <i class="bi bi-trash"></i> Supprimer
                                                    </a>
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
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>