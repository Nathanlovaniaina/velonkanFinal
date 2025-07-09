<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Mouvements de stock | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
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

        .sidebar-nav{
            flex-grow: 0;
        }

        .wrapper {
            background: var(--primary-light) !important;
        }
        
        /* Sidebar styling */
        #sidebar,
        .sidebar-content {
            background-color: #fff !important;
            color: #222e3c !important;
        }
        
        .sidebar-brand {
            color: #fff !important;
            font-weight: 700 !important;
            background-color: #fff  !important;
            letter-spacing: 2px;
            font-size: 1.3rem;
            text-align: center;
            padding: 1rem 0.5rem;
            border-radius: 8px;
            margin: 1rem 0.5rem 1.5rem 0.5rem;
            display: block;
            font-style: normal;
        }
        
        .sidebar-link.active {
            color: var(--secondary-color) !important;
        }
        
        .sidebar-link{
            background-color: white !important;
            color: #222e3c !important;
        }
        .sidebar-brand {
            color: var(--secondary-color)  !important;
            text-decoration: none;
        }
        
        .sidebar-link:hover {
            background-color: var(--secondary-light) !important;
            color: var(--primary-color) !important;
        }
        
        /* Navbar styling */
        .navbar-bg {
            background-color: white !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1) !important;
        }
        
        .sidebar-toggle {
            color: var(--primary-color) !important;
        }
        
        /* Card styling */
        .card {
            border: none !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05) !important;
            border-radius: 10px !important;
            overflow: hidden !important;
        }

        .sidebar-header{
            color: var(--primary-color);
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
        
        /* Form styling */
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
        }
        
        /* Table styling */
        .table {
            width: 100% !important;
            margin-bottom: 1rem;
        }
        
        .table th {
            background-color: var(--primary-light) !important;
            color: var(--primary-color) !important;
            font-weight: 600 !important;
            vertical-align: middle !important;
        }
        
        .table td {
            vertical-align: middle !important;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 126, 93, 0.05) !important;
        }
        
        /* Custom styles */
        .action-link {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white !important;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .action-link:hover {
            background-color: #006a4d;
            color: white;
            text-decoration: none;
        }
        
        .btn-add-row {
            margin-bottom: 1rem;
        }
        
        .btn-submit-form {
            margin-top: 1rem;
            padding: 0.5rem 1.5rem;
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
                        <h1 class="h3 d-inline align-middle">Mouvements de stock</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Formulaire de mouvements</h5>
                                </div>
                                <div class="card-body">
                                    <form:form method="post" action="${pageContext.request.contextPath}/stock/Stock/ajouter" modelAttribute="mouvements">
                                        <div class="table-responsive">
                                            <table id="mouvementTable" class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Composant</th>
                                                        <th>Type</th>
                                                        <th>Quantité</th>
                                                        <th>Prix unitaire</th>
                                                        <th>Jours conservation</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="mouvementBody">
                                                    <!-- Rows will be added dynamically -->
                                                </tbody>
                                            </table>
                                        </div>

                                        <button type="button" class="btn btn-primary btn-add-row" onclick="addRow()">
                                            <i class="bi bi-plus-circle me-1"></i> Ajouter une ligne
                                        </button>
                                        
                                        <div class="d-flex justify-content-between mt-4">
                                            <a href="${pageContext.request.contextPath}/stock/Stock/list" class="action-link">
                                                <i class="bi bi-list-ul me-1"></i> Voir l'historique
                                            </a>
                                            <button type="submit" class="btn btn-success btn-submit-form">
                                                <i class="bi bi-check-circle me-1"></i> Enregistrer tous les mouvements
                                            </button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Template caché -->
    <div style="display:none;">
        <table>
            <tbody>
                <tr id="templateRow">
                    <td>
                        <select name="listeMvt[__index__].stock.id" class="form-select">
                            <c:forEach var="s" items="${stocks}">
                                <option value="${s.id}">${s.composant.nom}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <select name="listeMvt[__index__].typeMvt" class="form-select">
                            <option value="1">Entrée</option>
                            <option value="0">Sortie</option>
                        </select>
                    </td>
                    <td><input type="number" step="0.01" name="listeMvt[__index__].quantite" class="form-control" required/></td>
                    <td><input type="number" step="0.01" name="listeMvt[__index__].prixUnitaire" class="form-control" required/></td>
                    <td><input type="number" name="listeMvt[__index__].nombreJourConservation" class="form-control" required/></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">
                            <i class="bi bi-trash"></i> Supprimer
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
        let index = 0;

        function addRow() {
            const table = document.getElementById("mouvementTable").getElementsByTagName('tbody')[0];
            const row = document.getElementById("templateRow").cloneNode(true);
            row.style.display = "";
            row.id = "";
            row.innerHTML = row.innerHTML.replace(/__index__/g, index);
            table.appendChild(row);
            index++;
        }

        function removeRow(btn) {
            const row = btn.closest("tr");
            if (document.getElementById("mouvementTable").getElementsByTagName('tbody')[0].rows.length > 1) {
                row.remove();
            } else {
                alert("Vous ne pouvez pas supprimer la dernière ligne.");
            }
        }

        window.onload = function() {
            addRow(); // ligne initiale
        };
    </script>
</body>
</html>