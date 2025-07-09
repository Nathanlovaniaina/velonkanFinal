<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Calendrier - Planification | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css' rel='stylesheet' />
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
            margin-bottom: 1.5rem;
        }
        
        .card-header {
            background-color: white !important;
            border-bottom: none !important;
            padding: 1rem 1.5rem !important;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            color: var(--primary-color) !important;
            font-size: 1.25rem;
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        /* Calendar styling */
        .calendar-container {
            padding: 1rem;
        }
        
        .calendar-legend {
            display: flex;
            gap: 1rem;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: var(--dark-color);
        }
        
        .legend-color {
            width: 12px;
            height: 12px;
            border-radius: 2px;
        }
        
        /* FullCalendar overrides */
        .fc-daygrid-day-number {
            font-weight: 500;
            color: var(--dark-color);
        }
        
        .fc-col-header-cell {
            background-color: #f8f9fa !important;
            font-weight: 600;
            color: var(--dark-color);
            padding: 0.5rem 0;
        }
        
        .fc-daygrid-day.fc-day-other {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        .fc-daygrid-day.fc-day-other .fc-daygrid-day-number {
            color: #6c757d;
        }
        
        .fc-event {
            background-color: var(--success-color) !important;
            border-color: var(--success-color) !important;
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-size: 0.875rem;
        }
        
        /* Export section */
        .export-section {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .export-header {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .export-title {
            font-size: 1.125rem;
            color: var(--dark-color);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .export-form {
            padding: 1rem 1.5rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        
        @media (max-width: 768px) {
            .export-form {
                grid-template-columns: 1fr;
            }
        }
        
        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 800px;
            overflow: hidden;
        }
        
        .modal-header {
            padding: 1rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-title {
            margin: 0;
            font-size: 1.25rem;
        }
        
        .close {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }
        
        .reco-content {
            padding: 1.5rem;
            max-height: 60vh;
            overflow-y: auto;
        }
        
        .loading {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            padding: 2rem;
            color: var(--dark-color);
        }
        
        .spinner {
            width: 3rem;
            height: 3rem;
            border: 0.25rem solid rgba(0, 126, 93, 0.2);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .pubs-list {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .pubs-list h4 {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
            color: var(--dark-color);
        }
        
        .pubs-list ul {
            list-style: none;
            padding: 0;
            margin: 0.5rem 0 0 0;
        }
        
        .pubs-list li {
            padding: 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .reco-plat {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 1rem;
            margin: 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .reco-plat-info {
            flex: 1;
        }
        
        .reco-plat-title {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .reco-plat-score {
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .score-badge {
            background-color: var(--primary-light);
            color: var(--primary-color);
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-weight: 600;
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
        }
        
        .empty-state svg {
            width: 48px;
            height: 48px;
            margin-bottom: 1rem;
        }
        
        .empty-state h4 {
            font-weight: 600;
            color: var(--dark-color);
            margin: 0 0 0.5rem 0;
        }
        
        .empty-state p {
            margin: 0;
            font-size: 0.875rem;
        }
        
        .modal-actions {
            padding: 1rem 1.5rem;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
        }
        
        /* Notification styling */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideIn 0.3s ease-out;
        }
        
        .notification-success {
            background-color: rgba(46, 204, 113, 0.9);
            color: white;
        }
        
        .notification-error {
            background-color: rgba(231, 76, 60, 0.9);
            color: white;
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
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
                    <!-- Page Header -->
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle">Calendrier - Planification des plats</h1>
                        <p class="text-muted mb-0">Planifiez vos menus avec des recommandations intelligentes</p>
                    </div>

                    <!-- Export Section -->
                    <div class="export-section">
                        <div class="export-header">
                            <h3 class="export-title">
                                <i class="bi bi-file-earmark-text"></i>
                                Exporter les publications
                            </h3>
                        </div>
                        
                        <form class="export-form">
                            <div class="mb-3">
                                <label class="form-label">Date de début</label>
                                <input type="date" id="exportStart" class="form-control">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Date de fin</label>
                                <input type="date" id="exportEnd" class="form-control">
                            </div>
                            
                            <div class="mb-3">
                                <button type="button" class="btn btn-primary" id="btnExportPDF">
                                    <i class="bi bi-file-earmark-pdf me-1"></i>
                                    Exporter PDF
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Calendar Container -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">
                                <i class="bi bi-calendar-event"></i>
                                Calendrier des plats
                            </h5>
                            <div class="calendar-legend">
                                <div class="legend-item">
                                    <div class="legend-color" style="background-color: var(--success-color);"></div>
                                    <span>Plats publiés</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="calendar-container">
                            <div id='calendar'></div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal Popup -->
    <div id="recoModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Recommandations du jour</h2>
                <button class="close" id="closeModal">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
            
            <div id="recoContent" class="reco-content">
                <div class="loading">
                    <div class="spinner"></div>
                    Chargement des recommandations...
                </div>
            </div>
            
            <div class="modal-actions">
                <button class="btn btn-primary" id="btnValider">
                    <i class="bi bi-check-lg me-1"></i>
                    Valider
                </button>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
        // Déclarer et initialiser le calendrier en premier
var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
    locale: 'fr',
    initialView: 'dayGridMonth',
    headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: ''
    },
    dateClick: function(info) {
        openRecoModal(info.dateStr);
    },
    datesSet: function(info) {
        chargerPublications(info.startStr, info.endStr);
    },
    eventClick: function(info) {
        console.log('Event clicked:', info.event.title);
    }
});

document.addEventListener('DOMContentLoaded', function() {
    calendar.render();
    limiterSelectionRecommandations();
});
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'fr',
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            dateClick: function(info) {
                openRecoModal(info.dateStr);
            },
            datesSet: function(info) {
                // Charger les publications pour la période affichée
                chargerPublications(info.startStr, info.endStr);
            },
            eventClick: function(info) {
                // Optionnel : afficher les détails d'un événement
                console.log('Event clicked:', info.event.title);
            }
        });
        calendar.render();

        // Initialiser la limitation de sélection pour la modale
        limiterSelectionRecommandations();
    });

    // Modal logic
    var modal = document.getElementById('recoModal');
    var closeModalBtn = document.getElementById('closeModal');
    var btnValider = document.getElementById('btnValider');
    var recoContent = document.getElementById('recoContent');
    var selectedDate = null;
    var platsRecommandes = [];
    var platsRecommandesIds = [];
    var calendar; // Déclaré globalement pour être accessible partout

    // Fonction pour limiter la sélection à 2 plats recommandés
    function limiterSelectionRecommandations() {
        const checkboxes = document.querySelectorAll('.reco-checkbox');
        checkboxes.forEach(cb => {
            cb.addEventListener('change', function() {
                const checked = document.querySelectorAll('.reco-checkbox:checked');
                if (checked.length > 2) {
                    this.checked = false;
                    showNotification('Vous ne pouvez sélectionner que 2 recommandations maximum.', 'error');
                }
            });
        });
    }

    function openRecoModal(dateStr) {
        selectedDate = dateStr;
        modal.style.display = 'block';
        recoContent.innerHTML = `
            <div class="loading">
                <div class="spinner"></div>
                Chargement des recommandations...
            </div>
        `;
        platsRecommandes = [];
        platsRecommandesIds = [];
        
        var contextPath = '/' + window.location.pathname.split('/')[1];
        
        // 1. Charger les publications déjà faites pour ce jour
        fetch(contextPath + '/api/publications?start=' + dateStr + '&end=' + dateStr)
            .then(response => response.json())
            .then(pubs => {
                var pubsHtml = '';
                var dejaPubliesIds = pubs.map(function(pub) { return pub.id; });
                
                if (pubs && pubs.length > 0) {
                    pubsHtml = '<div class="pubs-list">' +
                        '<h4>' +
                            '<i class="bi bi-check-circle"></i>' +
                            'Déjà publiés ce jour' +
                        '</h4>' +
                        '<ul>';
                    
                    pubs.forEach(function(pub) {
                        var pubPlat = pub.plat || 'Sans nom';
                        pubsHtml += '<li>' +
                            '<span style="color: var(--secondary-color);">✔</span>' +
                            pubPlat +
                        '</li>';
                    });
                    pubsHtml += '</ul></div>';
                }
                
                // 2. Charger les recommandations
                fetch(contextPath + '/api/recommandation?date=' + dateStr)
                    .then(response => response.json())
                    .then(data => {
                        var html = pubsHtml;
                        
                        if (data && data.plats && data.plats.length > 0) {
                            // Ajouter un titre pour les recommandations
                            html += '<h4>Recommandations</h4>';

                            // Trier les plats : d'abord ceux déjà publiés, puis les autres, chacun trié par score décroissant
                            var platsPublies = data.plats.filter(function(plat) { return dejaPubliesIds.includes(plat.id); });
                            var platsNonPublies = data.plats.filter(function(plat) { return !dejaPubliesIds.includes(plat.id); });
                            platsPublies.sort(function(a, b) { return b.score - a.score; });
                            platsNonPublies.sort(function(a, b) { return b.score - a.score; });
                            var platsTries = platsPublies.concat(platsNonPublies);

                            platsTries.forEach(function(plat, idx) {
                                platsRecommandes.push(plat);
                                platsRecommandesIds.push(plat.id);
                                var dejaPublie = dejaPubliesIds.includes(plat.id);
                                
                                var platId = plat.id || '';
                                var platIntitule = plat.intitule || 'Sans nom';
                                var platScore = plat.score ? plat.score.toFixed(2) : '-';
                                
                                var checkedAttr = dejaPublie ? ' checked' : '';
                                var platHtml = '<div class="reco-plat">' +
                                    '<input type="checkbox" class="reco-checkbox" id="reco-plat-' + idx + '" data-plat-id="' + platId + '"' + checkedAttr + '>' +
                                    '<div class="reco-plat-info">' +
                                        '<div class="reco-plat-title">' + platIntitule + '</div>' +
                                        '<div class="reco-plat-score">' +
                                            'Score: <span class="score-badge">' + platScore + '</span>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>';
                                html += platHtml;
                            });
                        } else {
                            html += `
                                <div class="empty-state">
                                    <i class="bi bi-check-circle"></i>
                                    <h4>Aucune recommandation</h4>
                                    <p>Aucune recommandation disponible pour ce jour.</p>
                                </div>
                            `;
                        }
                        recoContent.innerHTML = html;
                        limiterSelectionRecommandations();
                    })
                    .catch(() => {
                        recoContent.innerHTML = pubsHtml + `
                            <div class="empty-state">
                                <i class="bi bi-exclamation-triangle"></i>
                                <h4>Erreur de chargement</h4>
                                <p>Erreur lors du chargement des recommandations.</p>
                            </div>
                        `;
                    });
            })
            .catch(() => {
                recoContent.innerHTML = `
                    <div class="empty-state">
                        <i class="bi bi-exclamation-triangle"></i>
                        <h4>Erreur de chargement</h4>
                        <p>Erreur lors du chargement des publications déjà faites.</p>
                    </div>
                `;
            });
    }

    closeModalBtn.onclick = function() { 
        modal.style.display = 'none'; 
    };

    window.onclick = function(event) { 
        if (event.target == modal) modal.style.display = 'none'; 
    };

    btnValider.onclick = function() {
        var contextPath = '/' + window.location.pathname.split('/')[1];
        // Récupère les IDs des plats cochés
        var platsCoches = [];
        document.querySelectorAll('.reco-checkbox').forEach(function(cb) {
            if (cb.checked) platsCoches.push(parseInt(cb.getAttribute('data-plat-id')));
        });
        
        fetch(contextPath + '/api/publication_plat', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({date: selectedDate, plats: platsCoches})
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Recommandation validée pour le ' + selectedDate, 'success');
            } else {
                showNotification('Erreur lors de la validation.', 'error');
            }
            modal.style.display = 'none';
            // Recharger le calendrier
            calendar.refetchEvents();
        })
        .catch(() => {
            showNotification('Erreur lors de la validation.', 'error');
            modal.style.display = 'none';
        });
    };

    function chargerPublications(start, end) {
        var contextPath = '/' + window.location.pathname.split('/')[1];
        console.log("Tentative de chargement des publications de", start, "à", end);
        
        fetch(contextPath + '/api/publications?start=' + start + '&end=' + end)
            .then(response => {
                console.log("Réponse reçue, status:", response.status);
                return response.json();
            })
            .then(data => {
                console.log("Données reçues:", data);
                var events = data.map(function(pub) {
                    return {
                        title: pub.plat,
                        start: pub.date,
                        allDay: true,
                        color: '#4CAF50',
                        extendedProps: { image: pub.image }
                    };
                });
                console.log("Événements transformés:", events);
                calendar.removeAllEvents();
                calendar.addEventSource(events);
            })
            .catch(error => {
                console.error("Erreur lors du chargement:", error);
            });
    }

    // Export PDF
    document.getElementById('btnExportPDF').onclick = function() {
        var start = document.getElementById('exportStart').value;
        var end = document.getElementById('exportEnd').value;
        
        if (!start || !end) {
            showNotification('Veuillez sélectionner une période.', 'error');
            return;
        }
        
        var contextPath = '/' + window.location.pathname.split('/')[1];
        window.open(contextPath + '/api/publications/pdf?start=' + start + '&end=' + end, '_blank');
    };

    // Notification system
    function showNotification(message, type) {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        
        const icon = type === 'success' ? 'bi-check-circle' : 'bi-exclamation-triangle';
        
        notification.innerHTML = `
            <i class="bi ${icon}"></i>
            ${message}
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.remove();
        }, 5000);
    }
    </script>
</body>
</html>