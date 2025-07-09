<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard Suivi Bénéfices | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/benefice.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css" rel="stylesheet">
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
                        <h1 class="h3 d-inline align-middle"><strong>Suivi</strong> des Bénéfices</h1>
                    </div>

                    <!-- Section Bénéfice Net -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Bénéfice Net</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="beneficeForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateBenefice" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateBenefice" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-filter me-1"></i> Afficher
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <div class="alert alert-success" id="revenuTotal">Revenu total : -- Ar</div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="alert alert-danger" id="coutTotal">Coût total : -- Ar</div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="alert alert-info" id="beneficeNet">Bénéfice net : -- Ar</div>
                                        </div>
                                    </div>
                                    <div class="chart-container">
                                        <canvas id="beneficeNetChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Revenus par Entreprise -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Revenus par Entreprise</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableRevenusEntreprise">
                                            <thead>
                                                <tr>
                                                    <th>Entreprise</th>
                                                    <th class="text-end">Revenu (Ar)</th>
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

                    <!-- Section Bénéfices par Plat -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Bénéfices par Plat</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableBeneficesPlat">
                                            <thead>
                                                <tr>
                                                    <th>Plat</th>
                                                    <th class="text-end">Total vendus</th>
                                                    <th class="text-end">Revenu total (Ar)</th>
                                                    <th class="text-end">Coût total (Ar)</th>
                                                    <th class="text-end">Bénéfice (Ar)</th>
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

                    <!-- Section Salaires Versés -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Salaires Versés</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableSalairesVerses">
                                            <thead>
                                                <tr>
                                                    <th class="text-end">Total Salaires Versés (Ar)</th>
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

                    <!-- Section Bilan Journalier -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Bilan Journalier</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableBilanJournalier">
                                            <thead>
                                                <tr>
                                                    <th>Jour</th>
                                                    <th class="text-end">Revenu (Ar)</th>
                                                    <th class="text-end">Coût (Ar)</th>
                                                    <th class="text-end">Bénéfice (Ar)</th>
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
                                <strong>Suivi Bénéfices</strong> &copy;
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
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <!-- Bootstrap Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.js"></script>
    
    <script>
    let beneficeNetChart, tableRevenusEntreprise, tableBeneficesPlat, tableSalairesVerses, tableBilanJournalier;

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
                    className: 'btn '
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

    function updateBeneficeNetChart(revenu, cout, benefice) {
        const ctx = document.getElementById('beneficeNetChart').getContext('2d');
        if (beneficeNetChart) beneficeNetChart.destroy();
        
        beneficeNetChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Revenu', 'Coût', 'Bénéfice Net'],
                datasets: [{
                    label: 'Montant (Ar)',
                    data: [revenu, cout, benefice],
                    backgroundColor: [
                        'rgba(0, 126, 93, 0.5)',
                        'rgba(231, 76, 60, 0.5)',
                        'rgba(52, 152, 219, 0.5)'
                    ],
                    borderColor: [
                        'rgba(0, 126, 93, 1)',
                        'rgba(231, 76, 60, 1)',
                        'rgba(52, 152, 219, 1)'
                    ],
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

    function loadBeneficeNet(startDate, endDate) {
        $.get('${pageContext.request.contextPath}/api/suiviBenefices/benefice-net', { startDate, endDate }, function(data) {
            if (data && data.length > 0) {
                const d = data[0];
                $('#revenuTotal').text('Revenu total : ' + d.total_revenu.toFixed(2) + ' Ar');
                $('#coutTotal').text('Coût total : ' + d.total_cout.toFixed(2) + ' Ar');
                $('#beneficeNet').text('Bénéfice net : ' + d.benefice_net.toFixed(2) + ' Ar');
                updateBeneficeNetChart(d.total_revenu, d.total_cout, d.benefice_net);
            } else {
                $('#revenuTotal').text('Revenu total : -- Ar');
                $('#coutTotal').text('Coût total : -- Ar');
                $('#beneficeNet').text('Bénéfice net : -- Ar');
                updateBeneficeNetChart(0, 0, 0);
            }
        }).fail(function() {
            console.error("Erreur lors du chargement des bénéfices nets");
        });
    }

    function loadRevenusEntreprise(startDate, endDate) {
        $.get('${pageContext.request.contextPath}/api/suiviBenefices/revenus-par-entreprise', { startDate, endDate }, function(data) {
            tableRevenusEntreprise.clear().rows.add(data).draw();
        }).fail(function() {
            console.error("Erreur lors du chargement des revenus par entreprise");
        });
    }

    function loadBeneficesPlat(startDate, endDate) {
        $.get('${pageContext.request.contextPath}/api/suiviBenefices/benefices-par-plat', { startDate, endDate }, function(data) {
            tableBeneficesPlat.clear().rows.add(data).draw();
        }).fail(function() {
            console.error("Erreur lors du chargement des bénéfices par plat");
        });
    }

    function loadSalairesVerses(startDate, endDate) {
        $.get('${pageContext.request.contextPath}/api/suiviBenefices/salaires-verses', { startDate, endDate }, function(data) {
            tableSalairesVerses.clear().rows.add(data).draw();
        }).fail(function() {
            console.error("Erreur lors du chargement des salaires versés");
        });
    }

    function loadBilanJournalier(startDate, endDate) {
        $.get('${pageContext.request.contextPath}/api/suiviBenefices/bilan-journalier', { startDate, endDate }, function(data) {
            tableBilanJournalier.clear().rows.add(data).draw();
        }).fail(function() {
            console.error("Erreur lors du chargement du bilan journalier");
        });
    }

    $(document).ready(function() {
        // Initialisation des DataTables
        tableRevenusEntreprise = initDataTable('#tableRevenusEntreprise', {
            columns: [
                { data: 'entreprise' },
                { 
                    data: 'revenu', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                }
            ]
        });

        tableBeneficesPlat = initDataTable('#tableBeneficesPlat', {
            columns: [
                { data: 'plat' },
                { 
                    data: 'total_vendus', 
                    className: 'text-end',
                    render: data => data != null ? data : '0'
                },
                { 
                    data: 'revenu_total', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                },
                { 
                    data: 'cout_total', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                },
                { 
                    data: 'benefice', 
                    className: 'text-end', 
                    render: (data, type, row) => {
                        const benefice = data != null ? parseFloat(data) : 0;
                        const classe = benefice >= 0 ? 'positive' : 'negative';
                        return '<span class="' + classe + '">' + benefice.toFixed(2) + ' Ar</span>';
                    }
                }
            ]
        });

        tableSalairesVerses = initDataTable('#tableSalairesVerses', {
            columns: [
                { 
                    data: 'total_salaire', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                }
            ]
        });

        tableBilanJournalier = initDataTable('#tableBilanJournalier', {
            columns: [
                { 
                    data: 'jour',
                    render: data => {
                        const date = new Date(data);
                        return date.toLocaleDateString('fr-FR');
                    }
                },
                { 
                    data: 'revenu_journalier', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                },
                { 
                    data: 'cout_journalier', 
                    className: 'text-end', 
                    render: data => data != null ? data.toFixed(2) + ' Ar' : '0.00 Ar' 
                },
                { 
                    data: 'benefice_journalier', 
                    className: 'text-end', 
                    render: (data, type, row) => {
                        const benefice = data != null ? parseFloat(data) : 0;
                        const classe = benefice >= 0 ? 'positive' : 'negative';
                        return '<span class="' + classe + '">' + benefice.toFixed(2) + ' Ar</span>';
                    }
                }
            ],
            order: [[0, 'desc']]
        });

        // Chargement initial
        const startDate = $('#startDateBenefice').val();
        const endDate = $('#endDateBenefice').val();
        loadBeneficeNet(startDate, endDate);
        loadRevenusEntreprise(startDate, endDate);
        loadBeneficesPlat(startDate, endDate);
        loadSalairesVerses(startDate, endDate);
        loadBilanJournalier(startDate, endDate);

        // Gestion du formulaire
        $('#beneficeForm').submit(function(e) {
            e.preventDefault();
            const startDate = $('#startDateBenefice').val();
            const endDate = $('#endDateBenefice').val();
            loadBeneficeNet(startDate, endDate);
            loadRevenusEntreprise(startDate, endDate);
            loadBeneficesPlat(startDate, endDate);
            loadSalairesVerses(startDate, endDate);
            loadBilanJournalier(startDate, endDate);
        });
    });
    </script>
</body>
</html>