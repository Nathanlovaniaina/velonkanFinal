<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Composant" %>
<%
    List<Composant> composants = (List<Composant>) request.getAttribute("composants");
    org.example.entity.Stock stock = (org.example.entity.Stock) request.getAttribute("stock");
    boolean isUpdate = (stock != null);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title><%= isUpdate ? "Modifier" : "Ajouter" %> des stocks | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
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
        
        .btn-success {
            background-color: var(--success-color) !important;
            border-color: var(--success-color) !important;
        }
        
        /* Form styling */
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
        }
        
        /* Modal styling */
        .modal-header {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        .btn-close-white {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        
        /* Toast styling */
        .toast-header {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        /* Custom styles */
        .modal-body {
            max-height: 60vh;
            overflow-y: auto;
        }
        
        .plat-row {
            align-items: center;
            margin-bottom: 10px;
        }
        
        .btn-select-plat {
            white-space: nowrap;
        }
        
        /* Styles pour la modal des plats */
        .modal-plats .modal-content {
            height: 90vh;
            display: flex;
            flex-direction: column;
        }
        
        .modal-plats .modal-body {
            overflow: hidden;
            padding: 0;
            flex: 1;
        }
        
        .state-container {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        /* DataTables styling */
        .dataTables_wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .dataTables_scroll {
            flex: 1;
        }
        
        .dataTables_scrollHead {
            position: sticky;
            top: 0;
            z-index: 10;
            background-color: white !important;
        }
        
        .dataTables_scrollBody {
            overflow-y: auto !important;
        }
        
        /* Select2 styling */
        .select2-container--bootstrap-5 .select2-selection {
            min-height: 38px;
            border: 1px solid #ced4da !important;
        }
        
        .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered {
            padding-top: 4px;
        }
        
        .select2-container--bootstrap-5 .select2-dropdown {
            border-color: #ced4da !important;
        }
        
        .select2-container--bootstrap-5.select2-container--focus .select2-selection {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
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
                        <h1 class="h3 d-inline align-middle"><%= isUpdate ? "Modifier" : "Ajouter" %> un stock</h1>
                    </div>

                    <!-- Messages -->
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
                                    <h5 class="card-title mb-0">Informations du stock</h5>
                                </div>
                                <div class="card-body">
                                    <% if(isUpdate) { %>
                                    <form action="${pageContext.request.contextPath}/stock/Stock/update" method="post">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Composant</label>
                                                    <select class="form-select" name="id_composant" required>
                                                        <option value="">Sélectionner le composant</option>
                                                        <% for(Composant c : composants) { %>
                                                            <option value="<%=c.getId()%>" <%= (stock.getComposant().getId() == c.getId()) ? "selected" : "" %>>
                                                                <%=c.getNom()%>
                                                            </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Quantité en stock</label>
                                                    <input type="number" class="form-control" name="qtte_stock" required value="<%= stock.getQtteStock() %>">
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" value="<%= stock.getId() %>" />
                                        <div class="d-flex justify-content-end">
                                            <a href="${pageContext.request.contextPath}/stock/Stock/list" class="btn btn-outline-secondary me-2">
                                                Annuler
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                Mettre à jour
                                            </button>
                                        </div>
                                    </form>
                                    <% } else { %>
                                    <form action="${pageContext.request.contextPath}/stock/Stock/save" method="post" id="stockForm">
                                        <div id="lignes-stock">
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Composant</label>
                                                        <select class="form-select" name="id_composant" required>
                                                            <option value="">Sélectionner le composant</option>
                                                            <% for(Composant c : composants) { %>
                                                                <option value="<%=c.getId()%>"><%=c.getNom()%></option>
                                                            <% } %>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="mb-3">
                                                        <label class="form-label">Quantité</label>
                                                        <input type="number" class="form-control" name="qtte_stock" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 d-flex align-items-end">
                                                    <button type="button" class="btn btn-danger" onclick="supprimerLigne(this)">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary mt-2" onclick="ajouterLigne()">
                                            <i class="bi bi-plus-circle me-1"></i> Ajouter une ligne
                                        </button>
                                        <div class="d-flex justify-content-end mt-3">
                                            <a href="${pageContext.request.contextPath}/stock/Stock/list" class="btn btn-outline-secondary me-2">
                                                Annuler
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                Enregistrer
                                            </button>
                                        </div>
                                    </form>
                                    <% } %>
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
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
        // Fonction pour ajouter une nouvelle ligne de stock
        function ajouterLigne() {
            const conteneur = document.getElementById("lignes-stock");
            const ligne = document.createElement("div");
            ligne.className = "row mb-3";
            
            ligne.innerHTML = `
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Composant</label>
                        <select class="form-select" name="id_composant" required>
                            <option value="">Sélectionner le composant</option>
                            <% for(Composant c : composants) { %>
                            <option value="<%= c.getId() %>"><%= c.getNom() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="mb-3">
                        <label class="form-label">Quantité</label>
                        <input type="number" class="form-control" name="qtte_stock" required>
                    </div>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-danger" onclick="supprimerLigne(this)">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            `;
            conteneur.appendChild(ligne);
        }

        // Fonction pour supprimer une ligne
        function supprimerLigne(bouton) {
            const ligne = bouton.closest('.row.mb-3');
            // On ne supprime pas la dernière ligne
            if (document.querySelectorAll('#lignes-stock .row.mb-3').length > 1) {
                ligne.remove();
            }
        }

        // Initialisation des select2
        $(document).ready(function() {
            $('select.form-select').select2({
                theme: 'bootstrap-5',
                width: '100%'
            });
        });
    </script>
</body>
</html>