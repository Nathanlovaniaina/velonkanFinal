<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Commandes | VELONKAN</title>

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
            background-color: var(--primary-light) !important;
        }

        /* Card styling */
        .card {
            border: none !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05) !important;
            border-radius: 10px !important;
            overflow: hidden !important;
            margin-bottom: 1.5rem;
        }

        .card-header {
            background-color: white !important;
            border-bottom: none !important;
            padding: 1rem 1.5rem !important;
        }

        .card-title {
            color: var(--primary-color) !important;
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

        .btn-secondary {
            background-color: #6c757d !important;
            border-color: #6c757d !important;
        }

        /* Stats cards */
        .stat-card {
            background-color: white;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
            display: block;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.9rem;
            color: var(--dark-color);
            opacity: 0.8;
        }

        /* Order card styling */
        .order-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
        }

        .order-header {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-id {
            font-weight: 600;
            color: var(--primary-color);
        }

        .status-badge {
            background-color: var(--secondary-light);
            color: var(--dark-color);
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .order-details {
            padding: 1.5rem;
        }

        .detail-item {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px dashed rgba(0, 0, 0, 0.1);
        }

        .detail-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .detail-item-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .detail-item-row:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            font-weight: 500;
            color: var(--dark-color);
            opacity: 0.7;
        }

        .detail-value {
            font-weight: 500;
        }

        .plat-name {
            color: var(--primary-color);
        }

        .quantity-highlight {
            color: var(--success-color);
            font-weight: 600;
        }

        .datetime-value {
            font-weight: 600;
        }

        .prix-total {
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .empty-icon {
            font-size: 3rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }

        .empty-title {
            font-size: 1.25rem;
            color: var(--dark-color);
            opacity: 0.7;
        }

        /* Filter form */
        .filter-form {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
        }

        .filter-group {
            margin-bottom: 1rem;
        }

        .filter-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
            opacity: 0.7;
        }

        .filter-input {
            width: 100%;
            padding: 0.5rem 1rem;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 1rem;
        }

        .filter-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        /* Page header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 600;
            margin: 0;
        }

        .date-info {
            color: var(--dark-color);
            opacity: 0.7;
            font-size: 0.9rem;
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
                    <!-- Page header -->
                    <div class="page-header">
                        <h1 class="page-title">Gestion des Commandes</h1>
                        <div class="date-info">${currentDate}</div>
                    </div>

                    <!-- Stats cards -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="stat-card">
                                <span class="stat-number">${commandes.size()}</span>
                                <span class="stat-label">Total commandes</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="stat-card">
                                <span class="stat-number">${totalPortions}</span>
                                <span class="stat-label">Portions totales</span>
                            </div>
                        </div>
                    </div>

                    <!-- Filter form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Filtres</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/commande/" method="get" class="row g-3">
                                <div class="col-md-5">
                                    <label class="form-label">Date début</label>
                                    <input type="date" name="dateDebut" class="form-control" value="${dateDebut}">
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">Date fin</label>
                                    <input type="date" name="dateFin" class="form-control" value="${dateFin}">
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-funnel me-1"></i> Filtrer
                                        </button>
                                        <button type="button" class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/commande/'">
                                            <i class="bi bi-arrow-counterclockwise me-1"></i> Réinitialiser
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Orders list -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Liste des commandes</h5>
                        </div>
                        <div class="card-body">
                            <c:forEach var="commande" items="${commandes}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="order-id">Commande #00${commande.id}</div>
                                        <div class="status-badge">${commande.entreprise.nom}</div>
                                    </div>
                                    
                                    <div class="order-details">
                                        <c:set var="platsVus" value="" />
                                        <c:set var="quantiteTotale" value="0" />
                                        <c:set var="prixTotalCommande" value="0" />
                                        
                                        <c:forEach var="detail" items="${commande.details}">
                                            <c:if test="${!fn:contains(platsVus, detail.plat.id)}">
                                                <c:set var="quantiteParPlat" value="0" />
                                                <c:forEach var="detail2" items="${commande.details}">
                                                    <c:if test="${detail2.plat.id == detail.plat.id}">
                                                        <c:set var="quantiteParPlat" value="${quantiteParPlat + detail2.quantite}" />
                                                        <c:set var="prixTotalCommande" value="${prixTotalCommande + (detail2.quantite * detail2.prixUnitaire)}" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:set var="quantiteTotale" value="${quantiteTotale + quantiteParPlat}" />

                                                <!-- Plat details -->
                                                <div class="detail-item">
                                                    <div class="detail-item-row">
                                                        <div class="detail-label">Plat</div>
                                                        <div class="detail-value plat-name">${detail.plat.intitule}</div>
                                                    </div>
                                                    <div class="detail-item-row">
                                                        <div class="detail-label">Prix unitaire</div>
                                                        <div class="detail-value">${detail.prixUnitaire} €</div>
                                                    </div>
                                                    <div class="detail-item-row">
                                                        <div class="detail-label">Quantité</div>
                                                        <div class="detail-value quantity-highlight">${quantiteParPlat}</div>
                                                    </div>
                                                </div>

                                                <c:set var="platsVus" value="${platsVus},${detail.plat.id}" />
                                            </c:if>
                                        </c:forEach>

                                        <!-- Delivery date -->
                                        <div class="detail-item">
                                            <div class="detail-item-row">
                                                <div class="detail-label">Date & Heure prévue</div>
                                                <div class="detail-value datetime-value">
                                                    <fmt:formatDate value="${commande.dateHeurePrevue}" pattern="dd/MM/yyyy HH:mm"/>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Total price -->
                                        <div class="detail-item">
                                            <div class="detail-item-row">
                                                <div class="detail-label">Total</div>
                                                <div class="detail-value" style="font-weight: 600; color: var(--primary-color);">
                                                    ${prixTotalCommande} €
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Actions -->
                                        <!-- <div class="d-flex justify-content-end gap-2 mt-3">
                                            <a href="edit/?id=${commande.id}" class="btn btn-primary btn-sm">
                                                <i class="bi bi-pencil me-1"></i> Modifier
                                            </a>
                                            <a href="delete?id=${commande.id}&dateDebut=${dateDebut}&dateFin=${dateFin}" 
                                               onclick="return confirm('Confirmer la suppression ?')" 
                                               class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash me-1"></i> Supprimer
                                            </a>
                                        </div> -->
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Empty state -->
                            <c:if test="${empty commandes}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                                    </div>
                                    <div class="empty-title">Aucune commande trouvée</div>
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
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>