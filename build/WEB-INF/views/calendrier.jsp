<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Analytics - Ingrédients | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js CSS -->
    <link href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css" rel="stylesheet">
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
        }

        .card-title {
            color: var(--primary-color) !important;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        
        .card-subtitle {
            color: var(--dark-color) !important;
            opacity: 0.7;
            font-size: 0.875rem;
        }
        
        /* Table styling */
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            font-weight: 600;
            color: var(--dark-color);
            background-color: #f8f9fa !important;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        /* Badge styling */
        .badge {
            font-weight: 500;
            padding: 0.35em 0.65em;
        }
        
        .badge-success {
            background-color: var(--success-color) !important;
        }
        
        /* Chart container */
        .chart-container {
            height: 400px;
            position: relative;
            padding: 1rem;
        }
        
        /* Alert styling */
        .alert {
            border-radius: 8px !important;
            padding: 1rem !important;
            margin-bottom: 1.5rem !important;
            display: flex !important;
            align-items: center !important;
            gap: 0.75rem !important;
        }
        
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1) !important;
            border-color: rgba(46, 204, 113, 0.2) !important;
            color: var(--success-color) !important;
        }
        
        .alert-error, .alert-danger {
            background-color: rgba(231, 76, 60, 0.1) !important;
            border-color: rgba(231, 76, 60, 0.2) !important;
            color: var(--danger-color) !important;
        }
        
        /* Form styling */
        .filter-form {
            padding: 1rem 1.5rem;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .chart-container {
                height: 300px;
            }
        }
        
        /* Rank styling */
        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #f8f9fa;
            color: var(--dark-color);
            font-weight: 600;
            font-size: 0.875rem;
        }
        
        .top-1 {
            background-color: rgba(255, 215, 0, 0.1) !important;
            border-left: 4px solid var(--secondary-color) !important;
        }
        
        .top-2 {
            background-color: rgba(76, 175, 80, 0.1) !important;
            border-left: 4px solid var(--success-color) !important;
        }
        
        .top-3 {
            background-color: rgba(255, 152, 0, 0.1) !important;
            border-left: 4px solid #FF9800 !important;
        }
        
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 2rem !important;
        }
        
        .empty-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            color: #6c757d;
        }
        
        .empty-content svg {
            color: #6c757d;
            width: 48px;
            height: 48px;
        }
        
        .empty-content h4 {
            font-weight: 600;
            color: var(--dark-color);
            margin: 0;
        }
        
        .empty-content p {
            margin: 0;
            font-size: 0.875rem;
        }
        
        /* Card footer */
        .card-footer {
            background-color: white !important;
            border-top: 1px solid #eee !important;
            padding: 1rem 1.5rem !important;
        }
        
        .total-summary {
            display: flex;
            justify-content: flex-end;
        }
        
        .total-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .total-label {
            color: var(--dark-color);
            font-size: 0.875rem;
        }
        
        .total-value {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1.125rem;
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
                        <h1 class="h3 d-inline align-middle">Analytics - Ingrédients les plus utilisés</h1>
                        <p class="text-muted mb-0">Analysez l'utilisation de vos ingrédients sur une période donnée</p>
                    </div>

                    <!-- Alerts -->
                    <c:if test="${not empty succes}">
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle-fill"></i>
                            ${succes}
                        </div>
                    </c:if>
                    <c:if test="${not empty erreur}">
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            ${erreur}
                        </div>
                    </c:if>

                    <!-- Filter Form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Filtres</h5>
                            <i class="bi bi-funnel"></i>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/composant/most-used" method="get" class="filter-form">
                            <div class="form-grid">
                                <div class="mb-3">
                                    <label class="form-label">Date de début</label>
                                    <input type="date" name="dateDebut" class="form-control" 
                                           value="${not empty selectedDateDebut and fn:length(selectedDateDebut) >= 10 ? selectedDateDebut.substring(0,10) : ''}">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Date de fin</label>
                                    <input type="date" name="dateFin" class="form-control" 
                                           value="${not empty selectedDateFin and fn:length(selectedDateFin) >= 10 ? selectedDateFin.substring(0,10) : ''}">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Type de composant</label>
                                    <select name="typeId" class="form-select">
                                        <option value="">Tous les types</option>
                                        <c:forEach var="type" items="${types}">
                                            <option value="${type.id}" ${selectedTypeId == type.id ? 'selected' : ''}>${type.nom}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-funnel-fill me-1"></i> Filtrer
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Results Section -->
                    <div class="row">
                        <!-- Ranking Table -->
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Classement des ingrédients</h5>
                                    <c:if test="${not empty composantUsages}">
                                        <span class="badge badge-success">${fn:length(composantUsages)} résultats</span>
                                    </c:if>
                                </div>
                                
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Rang</th>
                                                <th>Nom de l'ingrédient</th>
                                                <th class="text-end">Quantité utilisée</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty composantUsages}">
                                                    <c:set var="total" value="0" />
                                                    <c:forEach var="usage" items="${composantUsages}" varStatus="status">
                                                        <c:set var="total" value="${total + usage.totalUtilise}" />
                                                        <tr class="${status.index < 3 ? 'top-row' : ''} ${status.index == 0 ? 'top-1' : status.index == 1 ? 'top-2' : status.index == 2 ? 'top-3' : ''}">
                                                            <td>
                                                                <div class="rank-badge ${status.index < 3 ? 'top-rank' : ''}">
                                                                    ${status.index + 1}
                                                                    <c:if test="${status.index == 0}">🥇</c:if>
                                                                    <c:if test="${status.index == 1}">🥈</c:if>
                                                                    <c:if test="${status.index == 2}">🥉</c:if>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="fw-medium">${usage.nom}</div>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="fw-semibold">${usage.totalUtilise}</div>
                                                                <div class="text-muted small">
                                                                    <c:if test="${not empty total and total > 0}">
                                                                        ${(usage.totalUtilise * 100 / total)}%
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="3" class="empty-state">
                                                            <div class="empty-content">
                                                                <i class="bi bi-check-circle"></i>
                                                                <h4>Aucun ingrédient utilisé</h4>
                                                                <p>Aucun ingrédient n'a été utilisé sur la période sélectionnée.</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <c:if test="${not empty composantUsages}">
                                    <div class="card-footer">
                                        <div class="total-summary">
                                            <div class="total-item">
                                                <span class="total-label">Total ingrédients utilisés :</span>
                                                <span class="total-value">${total}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- Chart -->
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Graphique d'utilisation</h5>
                                    <i class="bi bi-bar-chart-line"></i>
                                </div>
                                
                                <div class="chart-container">
                                    <canvas id="usageChart"></canvas>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('usageChart');
        if (ctx) {
            const chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [<c:forEach var="usage" items="${composantUsages}">'${usage.nom}',</c:forEach>],
                    datasets: [{
                        label: 'Quantité utilisée',
                        data: [<c:forEach var="usage" items="${composantUsages}">${usage.totalUtilise},</c:forEach>],
                        backgroundColor: [
                            <c:forEach var="usage" items="${composantUsages}" varStatus="status">
                                '${status.index == 0 ? "#FFD700" : status.index == 1 ? "#4CAF50" : status.index == 2 ? "#FF9800" : "#E0E0E0"}',
                            </c:forEach>
                        ],
                        borderColor: '#dee2e6',
                        borderWidth: 1,
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { 
                            display: false 
                        },
                        title: { 
                            display: false 
                        }
                    },
                    scales: {
                        y: { 
                            beginAtZero: true,
                            grid: {
                                color: '#e9ecef'
                            },
                            ticks: {
                                color: '#6c757d'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#6c757d',
                                maxRotation: 45
                            }
                        }
                    }
                }
            });
        }
    });
    </script>
</body>
</html>