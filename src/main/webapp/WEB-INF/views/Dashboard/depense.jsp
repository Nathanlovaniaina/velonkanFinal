<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard Suivi Dépenses | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/suividepense.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle"><strong>Suivi</strong> des Dépenses</h1>
                    </div>

                    <!-- Section Dépenses par Composant -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Dépenses par Composant</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="composantForm" class="row g-3">
                                            <div class="col-md-2">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateComposant" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateComposant" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Catégorie :</label>
                                                <select class="form-select" id="categorieId" name="categorieId">
                                                    <option value="">Toutes les catégories</option>
                                                    <c:forEach items="${categories}" var="categorie">
                                                        <option value="${categorie.id}">${categorie.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Composant :</label>
                                                <select class="form-select" id="composantId" name="composantId">
                                                    <option value="">Tous les composants</option>
                                                    <c:forEach items="${composants}" var="composant">
                                                        <option value="${composant.id}">${composant.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-funnel me-1"></i> Filtrer
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Dépenses par Composant -->
                                    <div class="chart-container">
                                        <canvas id="depensesComposantChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableDepensesComposant">
                                            <thead>
                                                <tr>
                                                    <th>Composant</th>
                                                    <th>Catégorie</th>
                                                    <th class="text-end">Quantité</th>
                                                    <th class="text-end">Montant Total</th>
                                                    <th class="text-end">Prix Moyen</th>
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

                    <!-- Section Évolution des Dépenses -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Évolution des Dépenses Mensuelles</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="evolutionForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateEvolution" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateEvolution" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-funnel me-1"></i> Filtrer
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Évolution -->
                                    <div class="chart-container">
                                        <canvas id="evolutionDepensesChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableEvolutionDepenses">
                                            <thead>
                                                <tr>
                                                    <th>Mois</th>
                                                    <th>Année</th>
                                                    <th class="text-end">Dépenses</th>
                                                    <th class="text-end">Mois précédent</th>
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

                    <!-- Section Comparaison Consommation -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Comparaison Consommation (Théorique vs Réelle)</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="comparaisonForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateComparaison" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateComparaison" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-funnel me-1"></i> Filtrer
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- Graphique Comparaison Consommation -->
                                    <div class="chart-container">
                                        <canvas id="comparaisonConsommationChart"></canvas>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableComparaisonConsommation">
                                            <thead>
                                                <tr>
                                                    <th>Composant</th>
                                                    <th>Unité</th>
                                                    <th class="text-end">Quantité Théorique</th>
                                                    <th class="text-end">Quantité Réelle</th>
                                                    <th class="text-end">Différence</th>
                                                    <th class="text-end">% Écart</th>
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
                                <strong>Suivi Dépenses</strong> &copy;
                            </p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <script>
    // Variables pour stocker les instances de graphiques et DataTables
    let depensesComposantChart, evolutionDepensesChart, comparaisonConsommationChart;
    let tableDepensesComposant, tableEvolutionDepenses, tableComparaisonConsommation;
    
    $(document).ready(function() {
        // Initialisation des DataTables avec configuration commune
        function initDataTable(tableId, options = {}) {
            return $(tableId).DataTable({
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn'
                    },
                    {
                        extend: 'csv',
                        className: 'btn'
                    },
                    {
                        extend: 'excel',
                        className: 'btn'
                    },
                    {
                        extend: 'pdf',
                        className: 'btn'
                    },
                    {
                        extend: 'print',
                        className: 'btn'
                    }
                ],
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
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

        function getCostClass(montant, moyenne) {
            if (montant === null || montant === undefined) return '';
            return montant > moyenne * 1.5 ? 'high-cost' : (montant > moyenne ? 'medium-cost' : '');
        }

        // Initialisation des DataTables
        tableDepensesComposant = initDataTable('#tableDepensesComposant', {
            columns: [
                { data: 'composant' },
                { data: 'categorie' },
                { 
                    data: 'quantite_totale',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) : '0.00';
                    }
                },
                { 
                    data: 'montant_total',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : '0.00 Ar';
                    }
                },
                { 
                    data: 'prix_moyen_unitaire',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : '0.00 Ar';
                    }
                }
            ]
        });

        tableEvolutionDepenses = initDataTable('#tableEvolutionDepenses', {
            columns: [
                { data: 'mois' },
                { data: 'annee' },
                { 
                    data: 'depenses_mensuelles',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : '0.00 Ar';
                    }
                },
                { 
                    data: 'depenses_mois_precedent',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' Ar' : 'N/A';
                    }
                },
                { 
                    data: 'evolution_pct',
                    className: 'text-end',
                    render: function(data, type, row) {
                        const evolutionClass = getEvolutionClass(data);
                        const evolutionText = data !== null ? 
                            (data > 0 ? '+' : '') + parseFloat(data).toFixed(2) + '%' : 'N/A';
                        return '<span class="' + evolutionClass + '">' + evolutionText + '</span>';
                    }
                }
            ],
            order: [[1, 'desc'], [0, 'desc']] // Tri par année puis mois
        });

        // Ajout DataTable pour la comparaison consommation
        function initComparaisonTable() {
            tableComparaisonConsommation = $('#tableComparaisonConsommation').DataTable({
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn'
                    },
                    {
                        extend: 'csv',
                        className: 'btn'
                    },
                    {
                        extend: 'excel',
                        className: 'btn'
                    },
                    {
                        extend: 'pdf',
                        className: 'btn'
                    },
                    {
                        extend: 'print',
                        className: 'btn'
                    }
                ],
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                },
                responsive: true,
                order: [],
                columns: [
                    { data: 'composant' },
                    { data: 'unite', defaultContent: '' },
                    { 
                        data: 'quantite_theorique',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'quantite_reelle',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'difference',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'pourcentage_ecart',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) + ' %' : 'N/A';
                        }
                    }
                ]
            });
        }

        function updateDepensesComposantChart(labels, data) {
            const ctx = document.getElementById('depensesComposantChart').getContext('2d');
            
            if (depensesComposantChart) {
                depensesComposantChart.destroy();
            }
            
            depensesComposantChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Dépenses par Composant (Ar)',
                        data: data,
                        backgroundColor: '#f8c828',
                        borderColor: '#f8c829',
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
                                text: 'Composants'
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

        function updateEvolutionDepensesChart(labels, data) {
            const ctx = document.getElementById('evolutionDepensesChart').getContext('2d');
            
            if (evolutionDepensesChart) {
                evolutionDepensesChart.destroy();
            }
            
            evolutionDepensesChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Dépenses Mensuelles (Ar)',
                        data: data.map(item => item.depenses),
                        borderColor: '#f8c828',
                        backgroundColor: '#f8c828',
                        borderWidth: 2,
                        tension: 0.1,
                        fill: true
                    }, {
                        label: 'Mois Précédent (Ar)',
                        data: data.map(item => item.precedent || null),
                        borderColor: '#007e5d',
                        backgroundColor: '#007e5d',
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
                                text: 'Période'
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

        function updateComparaisonConsommationChart(labels, theorique, reelle) {
            const ctx = document.getElementById('comparaisonConsommationChart').getContext('2d');
            if (comparaisonConsommationChart) {
                comparaisonConsommationChart.destroy();
            }
            comparaisonConsommationChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Quantité Théorique',
                            data: theorique,
                            backgroundColor: '#f8c828'
                        },
                        {
                            label: 'Quantité Réelle',
                            data: reelle,
                            backgroundColor: '#007e5d'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: 'Quantité' }
                        },
                        x: {
                            title: { display: true, text: 'Composants' }
                        }
                    }
                }
            });
        }

        function loadDepensesComposant(startDate, endDate, categorieId, composantId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/depenses-par-composant',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate,
                    categorieId: categorieId || '',
                    composantId: composantId || ''
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableDepensesComposant.clear().draw();
                        tableDepensesComposant.row.add(['Aucune donnée trouvée', '', '', '', '']).draw();
                        updateDepensesComposantChart([], []);
                    } else {
                        // Trier par montant décroissant
                        data.sort((a, b) => (b.montant_total || 0) - (a.montant_total || 0));
                        
                        // Préparer les données pour le graphique (top 10)
                        const topData = data.slice(0, 10);
                        const labels = topData.map(item => item.composant || 'Inconnu');
                        const chartData = topData.map(item => item.montant_total || 0);
                        
                        updateDepensesComposantChart(labels, chartData);
                        tableDepensesComposant.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableDepensesComposant.clear().draw();
                    tableDepensesComposant.row.add(['Erreur lors du chargement des données', '', '', '', '']).draw();
                }
            });
        }

        function loadEvolutionDepenses(startDate, endDate) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/evolution-depenses-mensuelles',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableEvolutionDepenses.clear().draw();
                        tableEvolutionDepenses.row.add(['Aucune donnée trouvée', '', '', '', '']).draw();
                        updateEvolutionDepensesChart([], []);
                    } else {
                        // Trier par année puis mois
                        data.sort((a, b) => {
                            if (a.annee !== b.annee) return b.annee - a.annee;
                            return b.mois - a.mois;
                        });
                        
                        // Préparer les labels et données pour le graphique
                        const labels = data.map(item => `${item.mois}/${item.annee}`).reverse();
                        const chartData = data.map(item => ({
                            depenses: item.depenses_mensuelles || 0,
                            precedent: item.depenses_mois_precedent || null
                        })).reverse();
                        
                        updateEvolutionDepensesChart(labels, chartData);
                        tableEvolutionDepenses.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableEvolutionDepenses.clear().draw();
                    tableEvolutionDepenses.row.add(['Erreur lors du chargement des données', '', '', '', '']).draw();
                }
            });
        }

        function loadComparaisonConsommation(startDate, endDate) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/comparaison-consommation',
                method: 'GET',
                data: { startDate: startDate, endDate: endDate },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableComparaisonConsommation.clear().draw();
                        tableComparaisonConsommation.row.add(['Aucune donnée trouvée', '', '', '', '', '']).draw();
                        updateComparaisonConsommationChart([], [], []);
                    } else {
                        // Trier par plus grand écart absolu
                        data.sort((a, b) => Math.abs((b.pourcentage_ecart || 0)) - Math.abs((a.pourcentage_ecart || 0)));
                        // Top 10 pour le graphe
                        const topData = data.slice(0, 10);
                        const labels = topData.map(item => item.composant || 'Inconnu');
                        const theorique = topData.map(item => item.quantite_theorique || 0);
                        const reelle = topData.map(item => item.quantite_reelle || 0);
                        updateComparaisonConsommationChart(labels, theorique, reelle);
                        tableComparaisonConsommation.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableComparaisonConsommation.clear().draw();
                    tableComparaisonConsommation.row.add(['Erreur lors du chargement des données', '', '', '', '', '']).draw();
                }
            });
        }

        // Chargement initial
        initComparaisonTable();
        loadDepensesComposant($('#startDateComposant').val(), $('#endDateComposant').val(), $('#categorieId').val(), $('#composantId').val());
        loadEvolutionDepenses($('#startDateEvolution').val(), $('#endDateEvolution').val());
        loadComparaisonConsommation($('#startDateComparaison').val(), $('#endDateComparaison').val());

        // Gestion des formulaires
        $('#composantForm').submit(function(e) {
            e.preventDefault();
            loadDepensesComposant($('#startDateComposant').val(), $('#endDateComposant').val(), $('#categorieId').val(), $('#composantId').val());
        });

        $('#evolutionForm').submit(function(e) {
            e.preventDefault();
            loadEvolutionDepenses($('#startDateEvolution').val(), $('#endDateEvolution').val());
        });

        $('#comparaisonForm').submit(function(e) {
            e.preventDefault();
            loadComparaisonConsommation($('#startDateComparaison').val(), $('#endDateComparaison').val());
        });
    });
    </script>
</body>
</html>