<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Stock" %>
<%@ page import="org.example.entity.Composant" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Stocks | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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

        .sidebar-nav{
            flex-grow: 0;
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
        
        .btn-danger {
            background-color: var(--danger-color) !important;
            border-color: var(--danger-color) !important;
        }

        /* Table styling */
        .table {
            width: 100% !important;
        }
        
        .table th {
            background-color: var(--primary-light) !important;
            color: var(--primary-color) !important;
            font-weight: 600 !important;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 126, 93, 0.05) !important;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(0, 126, 93, 0.1) !important;
        }
        
        /* Expired items */
        .expired {
            background-color: #ffebee !important;
        }
        
        .expired td {
            color: var(--danger-color) !important;
            font-weight: bold !important;
        }

        /* Action links */
        .action-links {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-link {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white !important;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
            margin-bottom: 1rem;
        }
        
        .action-link:hover {
            background-color: #006a4d;
            color: white;
            text-decoration: none;
        }
        
        .action-link.delete-link {
            background-color: var(--danger-color);
        }
        
        .action-link.delete-link:hover {
            background-color: #c0392b;
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
                        <h1 class="h3 d-inline align-middle">Gestion des Stocks</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des stocks</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-4">
                                        <a href="${pageContext.request.contextPath}/stock/Stock/form" class="action-link">
                                            <i class="bi bi-plus-circle me-1"></i> Ajouter/Retirer un stock
                                        </a>
                                        <a href="${pageContext.request.contextPath}/stock/Stock/list" class="action-link">
                                            <i class="bi bi-clock-history me-1"></i> Voir l'historique
                                        </a>
                                    </div>

                                    <div class="table-responsive">
                                        <table id="stocksTable" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Composant</th>
                                                    <th>Quantité</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="s" items="${stock}">
                                                    <tr>
                                                        <td>${s.id}</td>
                                                        <td>
                                                            <c:forEach var="c" items="${composants}">
                                                                <c:if test="${c.id == s.composant.id}">
                                                                    ${c.nom}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>${s.qtteStock}</td>
                                                        <td>
                                                            <div class="action-links">
                                                                <a href="#" onclick="confirmAction('Confirmer la suppression ?', '${pageContext.request.contextPath}/stock/Stock/delete?id=${s.id}')" 
                                                                   class="btn btn-danger btn-sm">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/stock/Stock/create" class="action-link">
                                            <i class="bi bi-plus-lg me-1"></i> Ajouter un nouveau stock
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
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
        function confirmAction(msg, url) {
            if(confirm(msg)) {
                window.location.href = url;
            }
        }

        $(document).ready(function() {
            // Initialize DataTable
            $('#stocksTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                },
                responsive: true,
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                pageLength: 10
            });
        });
    </script>
</body>
</html>