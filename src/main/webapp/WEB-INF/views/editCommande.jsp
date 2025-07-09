<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Modifier Commande #00${commande.id} | VELONKAN</title>

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

        .detail-item {
            background-color: white;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
        }

        .detail-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 126, 93, 0.1);
        }

        .plat-quantity-input {
            max-width: 100px;
        }

        .plat-price-input {
            max-width: 120px;
        }

        @media (max-width: 768px) {
            .detail-item > div {
                margin-bottom: 12px;
            }
            
            .plat-quantity-input,
            .plat-price-input {
                max-width: 100%;
            }
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
                        <h1 class="h3 d-inline align-middle">Modifier Commande #00${commande.id}</h1>
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
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Informations de la commande</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/commande/update" method="post">
                                        <input type="hidden" name="id" value="${commande.id}">
                                        <input type="hidden" name="dateDebut" value="${dateDebut}">
                                        <input type="hidden" name="dateFin" value="${dateFin}">

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Entreprise</label>
                                                    <select class="form-select select2-entreprise" name="idEntreprise" required>
                                                        <option value="">Sélectionner une entreprise</option>
                                                        <c:forEach var="entreprise" items="${entreprises}">
                                                            <option value="${entreprise.id}" ${entreprise.id == commande.entreprise.id ? 'selected' : ''}>
                                                                ${entreprise.nom} - ${entreprise.adresse}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date et heure prévue</label>
                                                    <input type="datetime-local" class="form-control" name="dateHeurePrevue" 
                                                           value="<fmt:formatDate value='${commande.dateHeurePrevue}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Détails de la commande</label>
                                                    
                                                    <c:forEach var="detail" items="${commande.details}" varStatus="status">
                                                        <div class="detail-item">
                                                            <input type="hidden" name="details[${status.index}].id" value="${detail.id}">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label class="form-label">Plat</label>
                                                                    <select class="form-select" name="details[${status.index}].idPlat" required>
                                                                        <option value="">Sélectionner un plat</option>
                                                                        <c:forEach var="plat" items="${plats}">
                                                                            <option value="${plat.id}" ${detail.plat != null && plat.id == detail.plat.id ? 'selected' : ''}>
                                                                                ${plat.intitule} (${plat.prix} Ar)
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="form-label">Quantité</label>
                                                                    <input type="number" class="form-control plat-quantity-input" 
                                                                           name="details[${status.index}].quantite" value="${detail.quantite}" min="1" required>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label class="form-label">Prix unitaire</label>
                                                                    <input type="number" class="form-control plat-price-input" 
                                                                           name="details[${status.index}].prixUnitaire" value="${detail.prixUnitaire}" min="0" step="1" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-end">
                                            <a href="${pageContext.request.contextPath}/commande/?dateDebut=${dateDebut}&dateFin=${dateFin}" 
                                               class="btn btn-outline-secondary me-2">
                                                Annuler
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                Enregistrer les modifications
                                            </button>
                                        </div>
                                    </form>
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
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    $(document).ready(function() {
        // Initialisation de Select2 pour les entreprises
        $('.select2-entreprise').select2({
            theme: 'bootstrap-5',
            placeholder: "Rechercher une entreprise...",
            width: '100%'
        });

        // Validation du formulaire
        $('form').on('submit', function(e) {
            let isValid = true;
            
            // Vérification des plats
            $('select[name^="details"]').each(function() {
                if (!$(this).val()) {
                    isValid = false;
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Veuillez sélectionner un plat pour tous les détails de commande.');
            }
        });
    });
    </script>
</body>
</html>