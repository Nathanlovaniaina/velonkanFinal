<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Nouvelle Commande | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">Nouvelle Commande</h1>
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
                                    <form action="CreerCommande" method="POST">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Entreprise</label>
                                                    <select class="form-select select2-entreprise" name="idEntreprise" required>
                                                        <option value="" selected disabled>Sélectionnez une entreprise</option>
                                                        <c:forEach var="entreprise" items="${entreprises}">
                                                            <option value="${entreprise.id}">${entreprise.nom} - ${entreprise.adresse}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date et heure de livraison</label>
                                                    <input type="datetime-local" class="form-control" name="dateLivraison" required>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Plats commandés</label>
                                                    <div id="plats-container">
                                                        <!-- Ligne de plat par défaut (cachée) -->
                                                        <div class="row mb-3 plat-row" style="display: none;">
                                                            <div class="col-md-6">
                                                                <input type="hidden" class="form-control plat-id" name="plats[0].id">
                                                                <input type="text" class="form-control plat-nom" readonly>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <input type="number" class="form-control" name="plats[0].quantite" min="1" value="1" required>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <button type="button" class="btn btn-danger btn-remove-plat">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <button type="button" id="btn-add-plat" class="btn btn-primary mt-2">
                                                        <i class="bi bi-plus-circle me-1"></i> Ajouter un plat
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Commentaires</label>
                                                    <textarea class="form-control" name="commentaires" rows="3" placeholder="Instructions spéciales, allergies, etc."></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-end">
                                            <button type="button" class="btn btn-outline-secondary me-2">
                                                Annuler
                                            </button>
                                            <button type="submit" class="btn btn-primary">
                                                Enregistrer la commande
                                            </button>
                                        </div>
                                    </form>
                                    <hr class="my-4">

                                    <h5 class="card-title mb-3">Importer une commande via CSV</h5>
                                                                    
                                    <form action="importCsvCommande" method="POST" enctype="multipart/form-data">
                                        <div class="row align-items-end">
                                            <div class="col-md-8">
                                                <div class="mb-3">
                                                    <label class="form-label">Fichier CSV</label>
                                                    <input type="file" class="form-control" name="file" accept=".csv" required>
                                                    <div class="form-text">
                                                        Format attendu : <code>NomPlat,Quantite,DateLivraison(yyyy-MM-dd'T'HH:mm),NomEntreprise</code>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 text-end">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-upload me-1"></i> Importer la commande
                                                </button>
                                            </div>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Modal pour la sélection des plats -->
            <div class="modal fade modal-plats" id="platsModal" tabindex="-1" aria-labelledby="platsModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="platsModalLabel">Sélectionner un plat</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fermer"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Barre de recherche -->
                            <div class="p-3 border-bottom">
                                <div class="input-group">
                                    <input type="text" id="searchPlat" class="form-control" placeholder="Rechercher un plat..." aria-label="Rechercher un plat">
                                    <button class="btn btn-primary" type="button" id="btnSearchPlat" aria-label="Lancer la recherche">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- États spéciaux -->
                            <div id="loadingState" class="state-container">
                                <div class="text-center">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Chargement...</span>
                                    </div>
                                    <p class="mt-2">Chargement des plats...</p>
                                </div>
                            </div>
                            
                            <div id="emptyState" class="state-container" style="display: none;">
                                <div class="text-center text-muted">
                                    <i class="bi bi-emoji-frown" style="font-size: 2rem;"></i>
                                    <p class="mt-2">Aucun plat disponible</p>
                                </div>
                            </div>
                            
                            <div id="errorState" class="state-container" style="display: none;">
                                <div class="text-center text-danger">
                                    <i class="bi bi-exclamation-triangle" style="font-size: 2rem;"></i>
                                    <p class="mt-2">Erreur de chargement des plats</p>
                                </div>
                            </div>
                            
                            <!-- Tableau des plats avec DataTables -->
                            <div id="platsTableContainer" style="display: none; height: 100%;">
                                <table id="platsTable" class="table table-striped table-hover" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Nom du plat</th>
                                            <th>Type</th>
                                            <th>Prix</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="platsTableBody">
                                        <!-- Rempli dynamiquement -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x-lg me-1"></i> Fermer
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Toast de confirmation -->
            <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                <div id="selectionToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-primary text-white">
                        <strong class="me-auto">Confirmation</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Fermer"></button>
                    </div>
                    <div class="toast-body">
                        Plat ajouté à la commande avec succès!
                    </div>
                </div>
            </div>
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
        // Variables
        let currentPlats = [];
        let platsDataTable = null;
        
        // Initialisation de Select2 pour les entreprises
        $('.select2-entreprise').select2({
            theme: 'bootstrap-5',
            placeholder: "Rechercher une entreprise...",
            width: '100%'
        });

        // Fonction pour afficher l'état de chargement
        function showLoading() {
            $('#loadingState').show();
            $('#emptyState').hide();
            $('#errorState').hide();
            $('#platsTableContainer').hide();
        }
        
        // Fonction pour afficher les données
        function showData(plats) {
            if (plats.length === 0) {
                $('#emptyState').show();
                $('#platsTableContainer').hide();
            } else {
                $('#platsTableContainer').show();
                renderPlatsTable(plats);
            }
            $('#loadingState').hide();
            $('#errorState').hide();
        }
        
        // Fonction pour afficher l'erreur
        function showError() {
            $('#errorState').show();
            $('#loadingState').hide();
            $('#emptyState').hide();
            $('#platsTableContainer').hide();
        }
        
        // Fonction pour rendre le tableau des plats
        function renderPlatsTable(plats) {
            // Détruire l'instance DataTables existante
            if (platsDataTable !== null) {
                platsDataTable.destroy();
                $('#platsTableBody').empty();
            }
            
            const tbody = $('#platsTableBody');
            tbody.empty();
            
            plats.forEach(plat => {
                const type = plat.type || 'Non spécifié';
                const prix = plat.prix ? `${plat.prix.toFixed(2)} Ar` : '-';

                const row = '<tr class="align-middle">' +
                    '<td class="fw-bold">' + (plat.intitule ? plat.intitule : 'N/A') + '</td>' +
                    '<td>' + type + '</td>' +
                    '<td>' + prix + '</td>' +
                    '<td class="text-end">' +
                        '<button class="btn btn-sm btn-primary btn-select-plat" ' +
                                'data-id="' + plat.id + '" ' +
                                'data-intitule="' + plat.intitule + '" ' +
                                'aria-label="Sélectionner ' + plat.intitule + '">' +
                            '<i class="bi bi-check-lg"></i>' +
                        '</button>' +
                    '</td>' +
                '</tr>';

                tbody.append(row);
            });
            
            // Initialiser DataTables
            platsDataTable = $('#platsTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                },
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                responsive: true,
                scrollY: '60vh',
                scrollCollapse: true,
                paging: true,
                columnDefs: [
                    { orderable: false, targets: 3 } // Désactiver le tri sur la colonne Action
                ],
                initComplete: function() {
                    // Ajustements après l'initialisation
                    $('.dataTables_scrollHead').css({
                        'position': 'sticky',
                        'top': '0',
                        'background-color': '#f8f9fa',
                        'z-index': '10'
                    });
                }
            });
        }
        
        // Fonction pour charger les plats
        function chargerPlats(search = '') {
            showLoading();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/commande/api/getPlat',
                type: 'GET',
                data: { search: search },
                success: function(data) {
                    currentPlats = data;
                    showData(data);
                },
                error: function(xhr) {
                    console.error('Erreur:', xhr.responseText);
                    showError();
                }
            });
        }
        
        // Gestion de l'ouverture de la modal
        $('#btn-add-plat').click(function() {
            $('#platsModal').modal('show');
        });
        
        $('#platsModal').on('shown.bs.modal', function() {
            chargerPlats();
        });
        
        // Recherche de plats
        $('#btnSearchPlat').click(function() {
            chargerPlats($('#searchPlat').val());
        });
        
        $('#searchPlat').keypress(function(e) {
            if (e.which === 13) {
                chargerPlats($(this).val());
            }
        });
        
        // Filtre en temps réel
        $('#searchPlat').on('input', function() {
            const searchTerm = $(this).val().toLowerCase();
            if (searchTerm.length === 0 || searchTerm.length > 2) {
                const filteredPlats = currentPlats.filter(plat => 
                    plat.intitule.toLowerCase().includes(searchTerm) ||
                    (plat.type && plat.type.toLowerCase().includes(searchTerm))
                );
                showData(filteredPlats);
            }
        });
        
        // Sélection d'un plat
        $(document).on('click', '.btn-select-plat', function() {
            const platId = $(this).data('id');
            const platIntitule = $(this).data('intitule');
            
            // Clone la ligne cachée
            const newRow = $('.plat-row').first().clone().removeAttr('style');
            const index = $('.plat-row:visible').length;
            
            // Met à jour les noms des champs avec l'index
            newRow.find('input.plat-id').attr('name', `plats[`+index+`].id`).val(platId);
            newRow.find('input.plat-nom').attr('name', `plats[`+index+`].nom`).val(platIntitule);
            newRow.find('input[type="number"]').attr('name', `plats[`+index+`].quantite`);
            
            // Ajoute la nouvelle ligne
            $('#plats-container').append(newRow);
            
            // Affiche le toast
            const toast = new bootstrap.Toast(document.getElementById('selectionToast'));
            toast.show();
            
            // Ferme la modal
            $('#platsModal').modal('hide');
        });
        
        // Suppression d'un plat
        $(document).on('click', '.btn-remove-plat', function() {
            if ($('.plat-row:visible').length > 1) {
                $(this).closest('.plat-row').remove();
                // Réindexer les champs si nécessaire
                $('.plat-row:visible').each(function(index) {
                    $(this).find('input.plat-id').attr('name', `plats[`+index+`].id`);
                    $(this).find('input.plat-nom').attr('name', `plats[`+index+`].nom`);
                    $(this).find('input[type="number"]').attr('name', `plats[`+index+`].quantite`);
                });
            }
        });
        
        // Nettoyage à la fermeture de la modal
        $('#platsModal').on('hidden.bs.modal', function() {
            if (platsDataTable !== null) {
                platsDataTable.destroy();
                platsDataTable = null;
            }
            $('#searchPlat').val('');
        });
    });
    </script>
</body>
</html>