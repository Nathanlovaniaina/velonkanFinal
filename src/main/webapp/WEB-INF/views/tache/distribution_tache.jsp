<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Distribution des Tâches | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .wrapper {
            background: var(--primary-light) !important;
        }
        
        /* Card styling */
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
        
        .btn-success {
            background-color: var(--success-color) !important;
            border-color: var(--success-color) !important;
        }
        
        /* Form styling */
        .form-section {
            background-color: white !important;
            padding: 1.5rem !important;
            border-radius: 10px !important;
            margin-bottom: 1.5rem !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05) !important;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 126, 93, 0.25) !important;
        }
        
        /* Checkbox styling */
        .form-check-input:checked {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        /* Alert styling */
        .alert {
            border-radius: 8px !important;
        }
        
        /* Employee checkbox grid */
        .employee-grid {
            max-height: 300px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            background-color: white;
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
                        <h1 class="h3 d-inline align-middle">Distribution des Tâches</h1>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty erreur}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${erreur}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <!-- Sélecteur de date -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Sélection de la date et du plat</h5>
                        </div>
                        <div class="card-body">
                            <div class="row align-items-end">
                                <div class="col-md-4">
                                    <label for="dateSelect" class="form-label">Date :</label>
                                    <input type="date" class="form-control" id="dateSelect" name="date"
                                           value="${date != null ? date : ''}">
                                </div>
                                <div class="col-md-2">
                                    <button class="btn btn-primary" onclick="goToDate()">
                                        <i class="bi bi-arrow-repeat me-1"></i> Recharger
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <label for="platSelect" class="form-label">Plat :</label>
                                    <select class="form-select" id="platSelect" onchange="chargerTachesPlat(this.value)">
                                        <option value="">-- Choisir un plat --</option>
                                        <c:forEach items="${plats}" var="p">
                                            <option value="${p.id}">${p.intitule}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Formulaire de distribution -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Distribuer une tâche</h5>
                        </div>
                        <div class="card-body">
                            <form action="submit" method="post">
                                <div class="row">
                                    <div class="col-md-6">
                                        <!-- Tâche libre -->
                                        <div class="mb-3">
                                            <label for="tacheSelect" class="form-label">Tâche libre :</label>
                                            <select name="tache.id" id="tacheSelect" class="form-select">
                                                <option value="">-- Aucune --</option>
                                                <c:forEach items="${taches}" var="t">
                                                    <option value="${t.id}">${t.nom}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Tâche liée au plat -->
                                        <div class="mb-3">
                                            <label for="tachePlatSelect" class="form-label">Tâche du plat :</label>
                                            <select name="tachePlat.id" id="tachePlatSelect" class="form-select">
                                                <option value="">Sélectionnez un plat d'abord</option>
                                            </select>
                                        </div>

                                        <!-- Date de la tâche -->
                                        <div class="mb-3">
                                            <label for="dateTache" class="form-label">Date de la tâche :</label>
                                            <input type="date" name="date_tache" class="form-control" required
                                                   value="${date != null ? date : ''}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <!-- Employés (checkbox multiple) -->
                                        <div class="mb-3">
                                            <label class="form-label">Employés :</label>
                                            <div class="employee-grid">
                                                <button type="button" class="btn btn-sm btn-outline-secondary mb-2" onclick="toggleCheckboxes()">
                                                    <i class="bi bi-check-all me-1"></i> Tout cocher/décocher
                                                </button>
                                                <div class="row">
                                                    <c:forEach items="${employes}" var="e">
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                       name="employeIds" value="${e.id}" id="emp_${e.id}">
                                                                <label class="form-check-label" for="emp_${e.id}">
                                                                    ${e.nom} ${e.prenom}
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end mt-3">
                                    <button type="submit" class="btn btn-success">
                                        <i class="bi bi-send-check me-1"></i> Distribuer
                                    </button>
                                </div>
                            </form>
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
        function goToDate() {
            const date = document.getElementById("dateSelect").value;
            window.location.href = date ? "form?date=" + date : "form";
        }

        function chargerTachesPlat(platId) {
            const select = document.getElementById("tachePlatSelect");
            select.innerHTML = "<option>Chargement...</option>";

            if (!platId) {
                select.innerHTML = "<option value=''>Sélectionnez un plat d'abord</option>";
                return;
            }

            fetch("${pageContext.request.contextPath}/taches/taches-par-plat?platId=" + platId)
                .then(res => {
                    if (!res.ok) {
                        throw new Error("Erreur HTTP " + res.status + " " + res.statusText);
                    }
                    return res.json();
                })
                .then(data => {
                    select.innerHTML = "";
                    if (data.length === 0) {
                        select.innerHTML = "<option value=''>Aucune tâche liée</option>";
                        return;
                    }
                    data.forEach(t => {
                        const opt = document.createElement("option");
                        opt.value = t.id;
                        opt.textContent = t.nom;
                        select.appendChild(opt);
                    });
                })
                .catch(err => {
                    console.error("Erreur:", err);
                    select.innerHTML = `<option value=''>Erreur : ${err.message}</option>`;
                });
        }

        document.addEventListener("DOMContentLoaded", () => {
            const tacheSelect = document.getElementById("tacheSelect");
            const tachePlatSelect = document.getElementById("tachePlatSelect");

            tacheSelect.addEventListener("change", () => {
                tachePlatSelect.disabled = !!tacheSelect.value;
            });

            tachePlatSelect.addEventListener("change", () => {
                tacheSelect.disabled = !!tachePlatSelect.value;
            });
        });

        function toggleCheckboxes() {
            const checkboxes = document.querySelectorAll("input[name='employeIds']");
            const allChecked = Array.from(checkboxes).every(cb => cb.checked);
            checkboxes.forEach(cb => cb.checked = !allChecked);
        }
    </script>
</body>
</html>