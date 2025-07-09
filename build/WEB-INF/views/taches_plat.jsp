<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Tâches Plat | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/poste.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/liste_tache_plat.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle">Gestion des Tâches Plat</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des tâches par plat</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Messages -->
                                    <c:if test="${not empty message}">
                                        <div class="message">${message}</div>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <div class="message error">${error}</div>
                                    </c:if>
                                    
                                    <!-- Recherche -->
                                    <div class="search-container">
                                        <input type="text" class="search-input" id="searchInput" placeholder="🔍 Rechercher par nom de plat ou tâche...">
                                    </div>
                                    
                                    <!-- Contenu principal -->
                                    <div id="mainContent">
                                        <c:choose>
                                            <c:when test="${empty tachesGroupeesParPlat}">
                                                <div class="empty-state">
                                                    <i class="fas fa-clipboard-list"></i>
                                                    <h3>Aucune tâche trouvée</h3>
                                                    <p>Commencez par ajouter des tâches à vos plats pour les voir apparaître ici.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div id="platsContainer">
                                                    <c:forEach var="platEntry" items="${tachesGroupeesParPlat}">
                                                        <c:set var="platId" value="${platEntry.key}" />
                                                        <c:set var="tachesPlat" value="${platEntry.value}" />
                                                        <c:set var="premiereTache" value="${tachesPlat[0]}" />
                                                        <c:set var="platNom" value="${premiereTache.plat.intitule}" />
                                                        
                                                        <div class="plat-group" data-plat-id="${platId}">
                                                            <div class="plat-header" onclick="togglePlat(${platId})">
                                                                <div class="plat-name">
                                                                    ${platNom}
                                                                    <span class="task-count">${fn:length(tachesPlat)} tâche(s)</span>
                                                                </div>
                                                                <i class="fas fa-chevron-down plat-toggle" id="toggle-${platId}"></i>
                                                            </div>
                                                            <div class="taches-container" id="taches-${platId}">
                                                                <table class="taches-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Nom de la tâche</th>
                                                                            <th>Ordre</th>
                                                                            <th>Actions</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="tache" items="${tachesPlat}">
                                                                            <tr data-task-id="${tache.id}">
                                                                                <td>
                                                                                    <div class="editable-cell" 
                                                                                         contenteditable="true" 
                                                                                         data-field="nom" 
                                                                                         data-id="${tache.id}"
                                                                                         data-plat-id="${tache.plat.id}"
                                                                                         onblur="saveField(this)" 
                                                                                         onkeypress="handleKeyPress(event, this)">${tache.nom}</div>
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" 
                                                                                           class="editable-input" 
                                                                                           value="${tache.ordre}" 
                                                                                           data-field="order"
                                                                                           data-id="${tache.id}"
                                                                                           data-plat-id="${tache.plat.id}"
                                                                                           onblur="saveField(this)" 
                                                                                           onkeypress="handleKeyPress(event, this)" 
                                                                                           min="1">
                                                                                </td>
                                                                                <td>
                                                                                    <a href="delete/${tache.id}" 
                                                                                       class="action-delete" 
                                                                                       onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer la tâche \"${tache.nom}\" ?\n\nCette action est définitive et ne peut pas être annulée.')">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}" class="btn btn-outline-secondary">
                                            <i class="fas fa-home me-1"></i> Accueil
                                        </a>
                                        <a href="${pageContext.request.contextPath}/taches_plat/ajout" class="btn btn-primary">
                                            <i class="fas fa-plus me-1"></i> Ajouter une tâche
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
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
        // Variables globales
        let isSearching = false;
        
        // Fonction pour basculer l'affichage des tâches d'un plat
        function togglePlat(platId) {
            const container = document.getElementById('taches-' + platId);
            const toggle = document.getElementById('toggle-' + platId);
            
            if (container.classList.contains('expanded')) {
                container.classList.remove('expanded');
                toggle.classList.remove('expanded');
            } else {
                container.classList.add('expanded');
                toggle.classList.add('expanded');
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
            form.action = 'save';
            form.style.display = 'none';
            
            // Ajouter les champs nécessaires
            const fields = {
                id: id,
                platId: platId,
                nom: field === 'nom' ? value : element.closest('tr').querySelector('[data-field="nom"]').textContent,
                order: field === 'order' ? value : element.closest('tr').querySelector('[data-field="order"]').value
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
            element.style.background = '#d4edda';
            setTimeout(() => {
                element.style.background = '';
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
        
        // Fonction de recherche dynamique
        function initSearch() {
            const searchInput = document.getElementById('searchInput');
            const platsContainer = document.getElementById('platsContainer');
            
            searchInput.addEventListener('input', function() {
                const query = this.value.toLowerCase().trim();
                const platGroups = platsContainer.querySelectorAll('.plat-group');
                
                if (query === '') {
                    // Afficher tous les groupes
                    platGroups.forEach(group => {
                        group.style.display = 'block';
                        const rows = group.querySelectorAll('tbody tr');
                        rows.forEach(row => row.style.display = '');
                    });
                    isSearching = false;
                } else {
                    isSearching = true;
                    
                    platGroups.forEach(group => {
                        const platName = group.querySelector('.plat-name').textContent.toLowerCase();
                        const rows = group.querySelectorAll('tbody tr');
                        let hasVisibleRows = false;
                        
                        // Filtrer les tâches
                        rows.forEach(row => {
                            const taskName = row.querySelector('[data-field="nom"]').textContent.toLowerCase();
                            if (platName.includes(query) || taskName.includes(query)) {
                                row.style.display = '';
                                hasVisibleRows = true;
                            } else {
                                row.style.display = 'none';
                            }
                        });
                        
                        // Afficher/masquer le groupe et l'ouvrir si nécessaire
                        if (hasVisibleRows) {
                            group.style.display = 'block';
                            const platId = group.dataset.platId;
                            const container = document.getElementById('taches-' + platId);
                            const toggle = document.getElementById('toggle-' + platId);
                            if (!container.classList.contains('expanded')) {
                                container.classList.add('expanded');
                                toggle.classList.add('expanded');
                            }
                        } else {
                            group.style.display = 'none';
                        }
                    });
                }
            });
        }
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            initSearch();
        });
    </script>
</body>
</html>