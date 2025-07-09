<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Accueil | VELONKAN</title>

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
        
        .home-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .home-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
        }
        
        .home-card-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
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
                        <h1 class="h3 d-inline align-middle">Liste des modules</h1>
                        <nav aria-label="breadcrumb" class="mt-2">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active" aria-current="page">Accueil</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Bienvenue dans l'application</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row g-4">
                                        <!-- Carte Contrats -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-file-earmark-text"></i>
                                                    </div>
                                                    <h5 class="card-title">Contrats</h5>
                                                    <p class="card-text">Gestion des contrats et mouvements</p>
                                                    <a href="${pageContext.request.contextPath}/mvtcontrat/create" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Entreprises -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-building"></i>
                                                    </div>
                                                    <h5 class="card-title">Entreprises</h5>
                                                    <p class="card-text">Gestion des entreprises clientes</p>
                                                    <a href="${pageContext.request.contextPath}/entreprise/create" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Catégories -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-tags"></i>
                                                    </div>
                                                    <h5 class="card-title">Catégories</h5>
                                                    <p class="card-text">Gestion des catégories</p>
                                                    <a href="${pageContext.request.contextPath}/categories" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Paiement salaire -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-cash-coin"></i>
                                                    </div>
                                                    <h5 class="card-title">Paiement salaire</h5>
                                                    <p class="card-text">Gestion des paiements de salaire</p>
                                                    <a href="${pageContext.request.contextPath}/employe/paiement_salaire" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Pénalités -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-exclamation-triangle"></i>
                                                    </div>
                                                    <h5 class="card-title">Pénalités</h5>
                                                    <p class="card-text">Gestion des pénalités</p>
                                                    <a href="${pageContext.request.contextPath}/penalite/" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Dépenses -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-currency-dollar"></i>
                                                    </div>
                                                    <h5 class="card-title">Dépenses</h5>
                                                    <p class="card-text">Gestion des dépenses</p>
                                                    <a href="${pageContext.request.contextPath}/depense/" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Postes -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-briefcase"></i>
                                                    </div>
                                                    <h5 class="card-title">Postes</h5>
                                                    <p class="card-text">Gestion des postes</p>
                                                    <a href="${pageContext.request.contextPath}/poste/" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Employés -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-people"></i>
                                                    </div>
                                                    <h5 class="card-title">Employés</h5>
                                                    <p class="card-text">Gestion des employés</p>
                                                    <a href="${pageContext.request.contextPath}/employe/" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Carte Stocks -->
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card home-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="home-card-icon">
                                                        <i class="bi bi-box-seam"></i>
                                                    </div>
                                                    <h5 class="card-title">Stocks</h5>
                                                    <p class="card-text">Gestion des stocks</p>
                                                    <a href="${pageContext.request.contextPath}/listStock/" class="btn btn-primary">
                                                        <i class="bi bi-arrow-right me-1"></i> Accéder
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
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
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>
