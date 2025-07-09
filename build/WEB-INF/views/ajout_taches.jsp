<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Ajout de Tâches | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/poste.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        
        /* Form styling */
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
        }
        
        /* Table styling */
        .table {
            --bs-table-bg: transparent;
        }
        
        .table-hover tbody tr:hover {
            background-color: var(--primary-light) !important;
        }
        
        /* Content editable styling */
        [contenteditable="true"] {
            padding: 0.375rem 0.75rem;
            border: 1px solid transparent;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        
        [contenteditable="true"]:hover {
            border-color: #dee2e6;
            background-color: var(--secondary-light);
        }
        
        [contenteditable="true"]:focus {
            outline: none;
            border-color: var(--primary-color);
            background-color: white;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25);
        }
        
        /* Custom styles for the page */
        .plat-selector {
            margin-bottom: 1.5rem;
        }
        
        .selected-plat-display {
            background-color: var(--primary-light);
            padding: 1rem;
            border-radius: 0.375rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary-color);
        }
        
        .task-form {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: flex-end;
        }
        
        .task-form .form-group {
            flex: 1;
            min-width: 200px;
        }
        
        .task-form .form-group-order {
            min-width: 100px;
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
                        <h1 class="h3 d-inline align-middle">Ajout de Tâches</h1>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>
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
                                    <h5 class="card-title mb-0"><i class="fas fa-utensils me-2"></i>Ajouter des tâches à un plat</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Sélection du plat -->
                                    <div class="mb-4">
                                        <label class="form-label">Sélectionner un plat :</label>
                                        <select id="platSelector" onchange="selectPlat(this.value)" class="form-select">
                                            <option value="">Choisir un plat...</option>
                                            <c:forEach var="plat" items="${plats}">
                                                <option value="${plat.id}" ${selectedPlatId == plat.id ? 'selected' : ''}>${plat.intitule}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <!-- Plat sélectionné -->
                                    <div id="selectedPlatDisplay" class="selected-plat-display" style="display: ${not empty selectedPlatId ? 'block' : 'none'}">
                                        <strong class="text-primary">
                                            <i class="fas fa-utensils me-2"></i> Plat sélectionné : 
                                            <span id="selectedPlatName">
                                                <c:forEach var="plat" items="${plats}">
                                                    <c:if test="${plat.id == selectedPlatId}">${plat.intitule}</c:if>
                                                </c:forEach>
                                            </span>
                                        </strong>
                                    </div>
                                    
                                    <!-- Formulaire d'ajout de tâche -->
                                    <form id="tacheForm" action="ajout/save" method="POST" class="task-form" style="display: ${not empty selectedPlatId ? 'flex' : 'none'}">
                                        <div class="form-group">
                                            <label class="form-label">Nom de la tâche :</label>
                                            <input type="text" name="nom" class="form-control" required placeholder="Ex: Laver les légumes...">
                                        </div>
                                        
                                        <div class="form-group form-group-order">
                                            <label class="form-label">Ordre :</label>
                                            <input type="number" name="order" class="form-control" required min="1" value="1">
                                        </div>
                                        
                                        <input type="hidden" name="platId" id="hiddenPlatId" value="${selectedPlatId}">
                                        
                                        <button type="submit" class="btn btn-primary mb-3">
                                            <i class="fas fa-plus me-2"></i> Ajouter Tâche
                                        </button>
                                    </form>
                                    
                                    <!-- Boutons d'actions -->
                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}/taches_plat/" class="btn btn-outline-primary">
                                            <i class="fas fa-list me-2"></i> Voir liste des tâches
                                        </a>
                                        <button onclick="showSuccessMessage()" class="btn btn-success">
                                            <i class="fas fa-check me-2"></i> Enregistrer
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Liste des tâches du plat sélectionné -->
                            <div id="tachesSection" style="display: ${not empty selectedPlatId ? 'block' : 'none'}; margin-top: 2rem;">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0"><i class="fas fa-tasks me-2"></i>Tâches du plat sélectionné</h5>
                                    </div>
                                    <div class="card-body">
                                        <c:choose>
                                            <c:when test="${empty tachesPlat}">
                                                <div class="text-center py-4 text-muted">
                                                    <i class="fas fa-clipboard-list fa-3x mb-3" style="color: #dee2e6;"></i>
                                                    <h4>Aucune tâche pour ce plat</h4>
                                                    <p>Commencez par ajouter des tâches pour les voir apparaître ici.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-responsive">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>Nom de la tâche</th>
                                                                <th>Ordre</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="tache" items="${tachesPlat}" varStatus="status">
                                                                <tr data-task-id="${tache.id}">
                                                                    <td>
                                                                        <div contenteditable="true" 
                                                                             data-field="nom" 
                                                                             data-id="${tache.id}"
                                                                             data-plat-id="${tache.plat.id}"
                                                                             onblur="saveField(this)" 
                                                                             onkeypress="handleKeyPress(event, this)"
                                                                             class="editable-field">${tache.nom}</div>
                                                                    </td>
                                                                    <td>
                                                                        <input type="number" 
                                                                               value="${tache.ordre}" 
                                                                               data-field="order"
                                                                               data-id="${tache.id}"
                                                                               data-plat-id="${tache.plat.id}"
                                                                               onblur="saveField(this)" 
                                                                               onkeypress="handleKeyPress(event, this)" 
                                                                               min="1"
                                                                               class="form-control form-control-sm d-inline-block" style="width: 80px;">
                                                                    </td>
                                                                    <td>
                                                                        <a href="ajout/delete/${tache.id}" 
                                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer la tâche \"${tache.nom}\" ?')"
                                                                           class="btn btn-sm btn-outline-danger">
                                                                            <i class="fas fa-trash-alt"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Toast de succès -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-success text-white">
                <strong class="me-auto">Succès</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Fermer"></button>
            </div>
            <div class="toast-body">
                <i class="fas fa-check-circle me-2"></i> Les tâches sont enregistrées avec succès !
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    
    <script>
        // Fonction pour sélectionner un plat
        function selectPlat(platId) {
            if (platId) {
                // Rediriger vers la page avec le plat sélectionné
                window.location.href = 'ajout?platId=' + platId;
            } else {
                // Masquer les sections
                document.getElementById('selectedPlatDisplay').style.display = 'none';
                document.getElementById('tacheForm').style.display = 'none';
                document.getElementById('tachesSection').style.display = 'none';
            }
        }
        
        // Fonction pour sauvegarder un champ modifié
        function saveField(element) {
            const id = element.dataset.id;
            const field = element.dataset.field;
            const platId = element.dataset.platId;
            let value = element.textContent || element.value;
            
            // Créer et soumettre un formulaire caché
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'ajout/save';
            form.style.display = 'none';
            
            // Récupérer les valeurs actuelles
            const row = element.closest('tr');
            const nomElement = row.querySelector('[data-field="nom"]');
            const orderElement = row.querySelector('[data-field="order"]');
            
            const fields = {
                id: id,
                platId: platId,
                nom: field === 'nom' ? value : nomElement.textContent,
                order: field === 'order' ? value : orderElement.value
            };
            
            Object.keys(fields).forEach(key => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            });
            
            document.body.appendChild(form);
            
            // Effet visuel de sauvegarde
            element.classList.add('bg-success', 'bg-opacity-10');
            setTimeout(() => {
                element.classList.remove('bg-success', 'bg-opacity-10');
                form.submit();
            }, 200);
        }
        
        // Fonction pour gérer la touche Entrée
        function handleKeyPress(event, element) {
            if (event.key === 'Enter') {
                event.preventDefault();
                element.blur();
            }
        }
        
        // Fonction pour afficher le message de succès
        function showSuccessMessage() {
            const toast = new bootstrap.Toast(document.getElementById('successToast'));
            toast.show();
        }
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus sur le champ nom si un plat est sélectionné
            const platSelector = document.getElementById('platSelector');
            if (platSelector.value) {
                const nomInput = document.querySelector('input[name="nom"]');
                if (nomInput) {
                    nomInput.focus();
                }
            }
        });
    </script>
</body>
</html>