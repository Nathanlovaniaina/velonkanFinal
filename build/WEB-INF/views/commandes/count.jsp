<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Nombre de Commandes | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/count.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/views/navbar.jsp" />

        <div class="main">
            <!-- Navbar -->
            <nav class="navbar navbar-expand navbar-light navbar-bg">
                <a class="sidebar-toggle js-sidebar-toggle">
                    <i class="bi bi-list"></i>
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
                    <div class="page-header">
                        <h1 class="h3 d-inline align-middle">Statistiques des Commandes</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Recherche de commandes</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/commandes/count" method="get">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date de début (AAAA-MM-JJ)</label>
                                                    <input type="date" id="date" name="date" class="form-control" required pattern="\d{4}-\d{2}-\d{2}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date de fin (AAAA-MM-JJ, optionnel)</label>
                                                    <input type="date" id="endDate" name="endDate" class="form-control" pattern="\d{4}-\d{2}-\d{2}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-search me-1"></i> Vérifier
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${isSingleDay}">
                        <c:if test="${not empty nombreCommandes}">
                            <div class="row">
                                <div class="col-12">
                                    <div class="result-container">
                                        <p>Nombre de commandes pour le <strong>${date}</strong> : <strong>${nombreCommandes}</strong></p>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Visualisation des données</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container">
                                                <canvas id="ordersChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <script>
                                        const ctx = document.getElementById('ordersChart').getContext('2d');
                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: ['${date}'],
                                                datasets: [{
                                                    label: 'Nombre de Commandes',
                                                    data: [${nombreCommandes}],
                                                    backgroundColor: 'rgba(0, 126, 93, 0.2)',
                                                    borderColor: '#007e5d',
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
                                                            text: 'Nombre de Commandes'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'Date'
                                                        }
                                                    }
                                                }
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    
                    <c:if test="${not isSingleDay}">
                        <c:if test="${not empty orderDataList}">
                            <div class="row">
                                <div class="col-12">
                                    <div class="result-container">
                                        <p>Résultats pour la période du <strong>${startDate}</strong> au <strong>${endDate}</strong></p>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Détails par jour</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Nombre de commandes</th>
                                                            <th>Évolution</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="orderData" items="${orderDataList}">
                                                            <tr>
                                                                <td>${orderData.date}</td>
                                                                <td>${orderData.count}</td>
                                                                <td class="${orderData.evolution == 'A évolué' ? 'evolution-positive' : orderData.evolution == 'A diminué' ? 'evolution-negative' : 'evolution-neutral'}">
                                                                    ${orderData.evolution}
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Visualisation des données</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container">
                                                <canvas id="ordersChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <script>
                                        const labels = [
                                            <c:forEach var="orderData" items="${orderDataList}" varStatus="status">
                                                "${orderData.date}"<c:if test="${!status.last}">,</c:if>
                                            </c:forEach>
                                        ];
                                        const data = [
                                            <c:forEach var="orderData" items="${orderDataList}" varStatus="status">
                                                ${orderData.count}<c:if test="${!status.last}">,</c:if>
                                            </c:forEach>
                                        ];
                                        const ctx = document.getElementById('ordersChart').getContext('2d');
                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: labels,
                                                datasets: [{
                                                    label: 'Nombre de Commandes',
                                                    data: data,
                                                    backgroundColor: 'rgba(0, 126, 93, 0.2)',
                                                    borderColor: '#007e5d',
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
                                                            text: 'Nombre de Commandes'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'Date'
                                                        }
                                                    }
                                                }
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="row">
                            <div class="col-12">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="row">
                        <div class="col-12">
                            <a href="${pageContext.request.contextPath}/" class="d-inline-flex align-items-center">
                                <i class="bi bi-arrow-left me-2"></i> Retour à l'accueil
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle functionality
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarToggle = document.querySelector('.js-sidebar-toggle');
            const sidebar = document.querySelector('.js-sidebar');
            
            if (sidebarToggle && sidebar) {
                sidebarToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                });
            }
        });
    </script>
</body>
</html>