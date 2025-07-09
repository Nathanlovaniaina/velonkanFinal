<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard Suivi Recettes</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/suivirecette.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/navbar.jsp" />

        <div class="main">
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
                    <h1 class="h3 mb-3"><strong>Suivi</strong> des Recettes</h1>

                    <!-- Section Revenu Mensuel -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Revenu Mensuel par Année</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="dateForm" class="row g-3">
                                            <div class="col-md-2">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDate" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDate" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Entreprise :</label>
                                                <select class="form-select" id="entrepriseId" name="entrepriseId">
                                                    <option value="">Toutes les entreprises</option>
                                                    <c:forEach items="${entreprises}" var="entreprise">
                                                        <option value="${entreprise.id}">${entreprise.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Plat :</label>
                                                <select class="form-select" id="platId" name="platId">
                                                    <option value="">Tous les plats</option>
                                                    <c:forEach items="${plats}" var="plat">
                                                        <option value="${plat.id}">${plat.intitule}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-filter me-1"></i> Afficher
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Revenu Mensuel -->
                                    <div class="chart-container">
                                        <canvas id="revenuMensuelChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableRevenuMensuel">
                                            <thead>
                                                <tr>
                                                    <th>Mois</th>
                                                    <th>Année</th>
                                                    <th class="text-end">Revenu Mensuel</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Revenu par Entreprise -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Revenu par Entreprise</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="entrepriseForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateEntreprise" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateEntreprise" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Entreprise :</label>
                                                <input type="text" class="form-control" id="entrepriseFilter" name="entrepriseFilter" placeholder="Filtrer par entreprise">
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-filter me-1"></i> Filtrer
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Conteneur pour graphique et tableau côte à côte -->
                                    <div class="row mt-3">
                                        <!-- Colonne graphique -->
                                        <div class="col-md-6">
                                            <div class="chart-container" style="height: 400px;">
                                                <canvas id="revenuEntrepriseChart"></canvas>
                                            </div>
                                        </div>
                                        
                                        <!-- Colonne tableau -->
                                        <div class="col-md-6">
                                            <div class="table-responsive">
                                                <table class="table table-hover my-0" id="tableRevenuEntreprise">
                                                    <thead>
                                                        <tr>
                                                            <th>Entreprise</th>
                                                            <th class="text-end">Revenu</th>
                                                            <th class="text-end">Commandes</th>
                                                            <th class="text-end">Plats</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- Données chargées via AJAX -->
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Revenu Journalier -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Revenu Journalier et Évolution</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="revenuJournalierForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateJournalier" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateJournalier" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-filter me-1"></i> Afficher
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Revenu Journalier -->
                                    <div class="chart-container">
                                        <canvas id="revenuJournalierChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableRevenuJournalier">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th class="text-end">Revenu Journalier</th>
                                                    <th class="text-end">Revenu Veille</th>
                                                    <th class="text-end">Évolution</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Factures en Retard -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Factures en Retard</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="facturesRetardForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateRetard" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateRetard" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Seuil de retard (jours) :</label>
                                                <input type="number" class="form-control" id="seuilRetard" name="seuilRetard" min="0" value="30">
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-search me-1"></i> Rechercher
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableFacturesRetard">
                                            <thead>
                                                <tr>
                                                    <th>N° Facture</th>
                                                    <th>Entreprise</th>
                                                    <th class="text-end">Montant</th>
                                                    <th class="text-end">Date émission</th>
                                                    <th class="text-end">Jours retard</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="footer">
                <div class="container-fluid">
                    <div class="row text-muted">
                        <div class="col-6 text-start">
                            <p class="mb-0">
                                <strong>Suivi Recettes</strong> &copy;
                            </p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <script>
    // Variables pour stocker les instances de graphiques et DataTables
    let revenuMensuelChart, revenuEntrepriseChart, revenuJournalierChart, facturesRetardChart;
    let tableRevenuMensuel, tableRevenuEntreprise, tableRevenuJournalier, tableFacturesRetard;
    
    $(document).ready(function() {
        // Initialisation des DataTables avec configuration commune
        function initDataTable(tableId, options = {}) {
            return $(tableId).DataTable({
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    'copy', 'csv', 'excel', 'pdf', 'print'
                ],
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
                },
                responsive: true,
                order: [],
                ...options
            });
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';
            const date = new Date(dateStr);
            return date.toLocaleDateString('fr-FR');
        }

        function getEvolutionClass(evolution) {
            if (evolution === null || evolution === undefined) return '';
            return evolution > 0 ? 'positive' : (evolution < 0 ? 'negative' : '');
        }

        function getRetardClass(joursRetard, seuil) {
            if (joursRetard >= seuil * 2) return 'high-retard';
            if (joursRetard >= seuil) return 'medium-retard';
            return '';
        }

        // Initialisation des DataTables
        tableRevenuMensuel = initDataTable('#tableRevenuMensuel', {
            columns: [
                { data: 'mois' },
                { data: 'annee' },
                { 
                    data: 'revenuMensuel',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : '0.00 Ar';
                    }
                }
            ]
        });

        tableRevenuEntreprise = initDataTable('#tableRevenuEntreprise', {
            columns: [
                { data: 'entreprise' },
                { 
                    data: 'revenuEntreprise',
                    className: 'text-end',
                    render: function(data) {
                        return parseFloat(data || 0).toFixed(2) + ' Ar';
                    }
                },
                { 
                    data: 'nombre_total_commandes',
                    className: 'text-end',
                    render: function(data) {
                        return data || 0;
                    }
                },
                { 
                    data: 'nombre_total_plats',
                    className: 'text-end',
                    render: function(data) {
                        return data || 0;
                    }
                }
            ]
        });

        tableRevenuJournalier = initDataTable('#tableRevenuJournalier', {
            columns: [
                { 
                    data: 'date_emission',
                    render: function(data) {
                        return formatDate(data);
                    }
                },
                { 
                    data: 'revenu_journalier',
                    className: 'text-end',
                    render: function(data) {
                        return parseFloat(data || 0).toFixed(2) + ' Ar';
                    }
                },
                { 
                    data: 'revenu_veille',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : 'N/A';
                    }
                },
                { 
                    data: 'evolution',
                    className: 'text-end',
                    render: function(data, type, row) {
                        const evolutionClass = getEvolutionClass(data);
                        const evolutionText = data !== null ? 
                            (data > 0 ? '+' : '') + parseFloat(data).toFixed(2) + 'Ar' : 'N/A';
                        return '<span class="' + evolutionClass + '">' + evolutionText + '</span>';
                    }
                }
            ],
            order: [[0, 'desc']]
        });

        tableFacturesRetard = initDataTable('#tableFacturesRetard', {
            columns: [
                { 
                    data: 'facture',
                    render: function(data, type, row) {
                        return data !== undefined && data !== null ? 'FACT-' + data.toString().padStart(3, '0') : 'N/A';
                    }
                },
                { 
                    data: 'entreprise',
                    defaultContent: 'Inconnu'
                },
                { 
                    data: 'montant_total',
                    className: 'text-end',
                    render: function(data) {
                        return data !== undefined ? parseFloat(data).toFixed(2) + ' Ar' : '0.00 Ar';
                    }
                },
                { 
                    data: 'date_emission',
                    className: 'text-end',
                    render: function(data) {
                        return data ? new Date(data).toLocaleDateString('fr-FR') : 'N/A';
                    }
                },
                { 
                    data: 'jours_retard',
                    className: 'text-end',
                    render: function(data, type, row) {
                        const seuil = $('#seuilRetard').val() || 30;
                        const retardClass = getRetardClass(data, seuil);
                        const badge = data >= seuil ? ' <span class="badge-retard">Retard</span>' : '';
                        return '<span class="' + retardClass + '">' + (data !== undefined ? data : '0') + badge + '</span>';
                    }
                }
            ],
            order: [[4, 'desc']],
            createdRow: function(row, data, dataIndex) {
                const seuil = $('#seuilRetard').val() || 30;
                if (data.jours_retard >= seuil) {
                    $(row).addClass('depasse-seuil');
                }
            }
        });

        function updateRevenuMensuelChart(labels, data) {
            const ctx = document.getElementById('revenuMensuelChart').getContext('2d');
            
            if (revenuMensuelChart) {
                revenuMensuelChart.destroy();
            }
            
            revenuMensuelChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Revenu Mensuel (Ar)',
                        data: data,
                        backgroundColor: 'rgba(0, 126, 93, 0.5)',
                        borderColor: 'rgba(0, 126, 93, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Montant (Ar)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Période'
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + context.raw.toFixed(2) + ' Ar';
                                }
                            }
                        }
                    }
                }
            });
        }

        function updateRevenuEntrepriseChart(labels, data) {
            const ctx = document.getElementById('revenuEntrepriseChart').getContext('2d');
            
            if (revenuEntrepriseChart) {
                revenuEntrepriseChart.destroy();
            }
            
            revenuEntrepriseChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Revenu par Entreprise (Ar)',
                        data: data,
                        backgroundColor: [
                            'rgba(0, 126, 93, 0.6)',
                            'rgba(248, 200, 40, 0.6)',
                            'rgba(46, 204, 113, 0.6)',
                            'rgba(52, 152, 219, 0.6)',
                            'rgba(155, 89, 182, 0.6)',
                            'rgba(231, 76, 60, 0.6)',
                            'rgba(241, 196, 15, 0.6)',
                            'rgba(44, 62, 80, 0.6)'
                        ],
                        borderColor: [
                            'rgba(0, 126, 93, 1)',
                            'rgba(248, 200, 40, 1)',
                            'rgba(46, 204, 113, 1)',
                            'rgba(52, 152, 219, 1)',
                            'rgba(155, 89, 182, 1)',
                            'rgba(231, 76, 60, 1)',
                            'rgba(241, 196, 15, 1)',
                            'rgba(44, 62, 80, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right',
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const label = context.label || '';
                                    const value = context.raw || 0;
                                    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    const percentage = Math.round((value / total) * 100);
                                    return `${label}: ${value.toFixed(2)} Ar (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            });
        }

        function updateRevenuJournalierChart(labels, data) {
            const ctx = document.getElementById('revenuJournalierChart').getContext('2d');
            
            if (revenuJournalierChart) {
                revenuJournalierChart.destroy();
            }
            
            revenuJournalierChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Revenu Journalier (Ar)',
                        data: data.map(item => item.revenu),
                        borderColor: 'rgba(0, 126, 93, 1)',
                        backgroundColor: 'rgba(0, 126, 93, 0.1)',
                        borderWidth: 2,
                        tension: 0.1,
                        fill: true
                    }, {
                        label: 'Revenu Veille (Ar)',
                        data: data.map(item => item.veille || null),
                        borderColor: 'rgba(248, 200, 40, 1)',
                        backgroundColor: 'rgba(248, 200, 40, 0.1)',
                        borderWidth: 2,
                        borderDash: [5, 5],
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Montant (Ar)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Date'
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + (context.raw ? context.raw.toFixed(2) + ' Ar' : 'N/A');
                                }
                            }
                        }
                    }
                }
            });
        }

        function loadData(startDate, endDate, entrepriseId, platId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviRecette/revenu_mensuel',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate,
                    entrepriseId: entrepriseId || '',
                    platId: platId || ''
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableRevenuMensuel.clear().draw();
                        tableRevenuMensuel.row.add(['Aucune donnée trouvée', '', '']).draw();
                        updateRevenuMensuelChart([], []);
                    } else {
                        const labels = data.map(item => `${item.mois}/${item.annee}`);
                        const chartData = data.map(item => item.revenuMensuel || 0);
                        
                        updateRevenuMensuelChart(labels, chartData);
                        tableRevenuMensuel.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableRevenuMensuel.clear().draw();
                    tableRevenuMensuel.row.add(['Erreur lors du chargement des données', '', '']).draw();
                }
            });
        }

        function loadEntrepriseData(startDate, endDate, entrepriseFilter) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviRecette/revenu_par_entreprise',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate,
                    entreprise: entrepriseFilter || ''
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableRevenuEntreprise.clear().draw();
                        tableRevenuEntreprise.row.add(['Aucune donnée trouvée', '', '', '']).draw();
                        updateRevenuEntrepriseChart([], []);
                    } else {
                        data.sort((a, b) => (b.revenuEntreprise || 0) - (a.revenuEntreprise || 0));
                        
                        // Préparer les données pour le graphique (top 10 entreprises)
                        const topEntreprises = data.slice(0, 10);
                        const labels = topEntreprises.map(item => item.entreprise || 'Inconnu');
                        const chartData = topEntreprises.map(item => item.revenuEntreprise || 0);
                        
                        updateRevenuEntrepriseChart(labels, chartData);
                        tableRevenuEntreprise.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableRevenuEntreprise.clear().draw();
                    tableRevenuEntreprise.row.add(['Erreur lors du chargement des données', '', '', '']).draw();
                }
            });
        }

        function loadRevenuJournalierData(startDate, endDate) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviRecette/revenu_journalier',
                method: 'GET',
                data: { startDate: startDate, endDate: endDate },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableRevenuJournalier.clear().draw();
                        tableRevenuJournalier.row.add(['Aucune donnée trouvée', '', '', '']).draw();
                        updateRevenuJournalierChart([], []);
                    } else {
                        data.sort((a, b) => new Date(b.date_emission) - new Date(a.date_emission));
                        
                        // Préparer les données pour le graphique (30 derniers jours max)
                        const recentData = data.slice(0, 30).reverse();
                        const labels = recentData.map(item => formatDate(item.date_emission));
                        const chartData = recentData.map(item => ({
                            revenu: item.revenu_journalier || 0,
                            veille: item.revenu_veille || null
                        }));
                        
                        updateRevenuJournalierChart(labels, chartData);
                        tableRevenuJournalier.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableRevenuJournalier.clear().draw();
                    tableRevenuJournalier.row.add(['Erreur lors du chargement des données', '', '', '']).draw();
                }
            });
        }

        function loadFacturesRetardData(startDate, endDate, seuilRetard) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviRecette/factures_retard',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate,
                    seuilRetard: seuilRetard || 30
                },
                success: function(data) {
                    if (!data || !Array.isArray(data)) {
                        console.error('Données invalides reçues');
                        tableFacturesRetard.clear().draw();
                        return;
                    }
                
                    // Mettre à jour les données de la table
                    tableFacturesRetard.clear().rows.add(data).draw();
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', error);
                    tableFacturesRetard.clear().draw();
                    tableFacturesRetard.row.add([
                        'Erreur',
                        error.message || status,
                        '',
                        '',
                        ''
                    ]).draw();
                }
            });
        }

        // Chargement initial
        loadData($('#startDate').val(), $('#endDate').val(), $('#entrepriseId').val(), $('#platId').val());
        loadEntrepriseData($('#startDateEntreprise').val(), $('#endDateEntreprise').val(), $('#entrepriseFilter').val());
        loadRevenuJournalierData($('#startDateJournalier').val(), $('#endDateJournalier').val());
        loadFacturesRetardData($('#startDateRetard').val(), $('#endDateRetard').val(), $('#seuilRetard').val());

        // Gestion des formulaires
        $('#dateForm').submit(function(e) {
            e.preventDefault();
            loadData($('#startDate').val(), $('#endDate').val(), $('#entrepriseId').val(), $('#platId').val());
        });

        $('#entrepriseForm').submit(function(e) {
            e.preventDefault();
            loadEntrepriseData($('#startDateEntreprise').val(), $('#endDateEntreprise').val(), $('#entrepriseFilter').val());
        });

        $('#revenuJournalierForm').submit(function(e) {
            e.preventDefault();
            loadRevenuJournalierData($('#startDateJournalier').val(), $('#endDateJournalier').val());
        });

        $('#facturesRetardForm').submit(function(e) {
            e.preventDefault();
            loadFacturesRetardData($('#startDateRetard').val(), $('#endDateRetard').val(), $('#seuilRetard').val());
        });
    });
    </script>
</body>
</html>