<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Suivi des plats publiés | VELONKAN</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007e5d;
            --secondary-color: #f8c828;
            --primary-light: #e6f2ef;
            --secondary-light: #fef8e6;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --muted-color: #6c757d;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--primary-light);
            color: var(--dark-color);
            margin: 0;
            padding: 0;
        }
        
        .wrapper {
            display: flex;
            min-height: 100vh;
        }
        
        .main {
            flex: 1;
            padding: 20px;
        }
        
        .navbar-bg {
            background-color: white !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 25px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--secondary-color);
        }
        
        .search-form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        
        .search-form label {
            font-weight: 500;
            margin-right: 10px;
        }
        
        .search-form input[type="date"] {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }
        
        .search-form button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .search-form button:hover {
            background-color: #006a4d;
        }
        
        .plat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }
        
        .plat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .plat-title {
            color: var(--primary-color);
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
        }
        
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .status-non-commence {
            background-color: #f8f9fa;
            color: var(--muted-color);
            border: 1px solid #dee2e6;
        }
        
        .status-en-cours {
            background-color: var(--secondary-light);
            color: #856404;
        }
        
        .status-termine {
            background-color: #d4edda;
            color: #155724;
        }
        
        .tache-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .tache-item {
            padding: 12px 15px;
            margin-bottom: 10px;
            background-color: #f8f9fa;
            border-left: 4px solid var(--secondary-color);
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .tache-info {
            flex-grow: 1;
        }
        
        .tache-actions {
            margin-left: 15px;
        }
        
        .btn-action {
            padding: 5px 12px;
            font-size: 0.9rem;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-commencer {
            background-color: var(--warning-color);
            color: white;
        }
        
        .btn-commencer:hover {
            background-color: #e67e22;
        }
        
        .btn-terminer {
            background-color: var(--success-color);
            color: white;
        }
        
        .btn-terminer:hover {
            background-color: #27ae60;
        }
        
        .no-plats {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
            color: var(--muted-color);
            font-style: italic;
        }
        
        .divider {
            border: none;
            height: 1px;
            background-color: #eee;
            margin: 30px 0;
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

            <h2>Suivi des plats publiés</h2>

            <form class="search-form" action="${pageContext.request.contextPath}/suivi/taches" method="get">
                <label for="date">Date de publication :</label>
                <input type="date" name="date" id="date" value="${date}" />
                <button type="submit">Rechercher</button>
            </form>

            <c:if test="${not empty platsAvecTaches}">
                <c:forEach var="platMap" items="${platsAvecTaches}">
                    <div class="plat-card">
                        <div class="plat-header">
                            <h3 class="plat-title">${platMap.plat.intitule}</h3>
                            <span class="status-badge 
                                <c:choose>
                                    <c:when test="${platMap.statutGlobal == 0}">status-non-commence</c:when>
                                    <c:when test="${platMap.statutGlobal == 1}">status-en-cours</c:when>
                                    <c:when test="${platMap.statutGlobal == 2}">status-termine</c:when>
                                    <c:otherwise>status-non-commence</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${platMap.statutGlobal == 0}">Non commencé</c:when>
                                    <c:when test="${platMap.statutGlobal == 1}">En cours</c:when>
                                    <c:when test="${platMap.statutGlobal == 2}">Terminé</c:when>
                                    <c:otherwise>Non commencé</c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <ul class="tache-list">
                            <c:forEach var="tacheMap" items="${platMap.taches}">
                                <li class="tache-item">
                                    <div class="tache-info">
                                        <strong>${tacheMap.tache.nom}</strong> - 
                                        <span class="status-badge 
                                            <c:choose>
                                                <c:when test="${tacheMap.statut == 0}">status-non-commence</c:when>
                                                <c:when test="${tacheMap.statut == 1}">status-en-cours</c:when>
                                                <c:when test="${tacheMap.statut == 2}">status-termine</c:when>
                                                <c:otherwise>status-non-commence</c:otherwise>
                                            </c:choose>">
                                            <c:choose>
                                                <c:when test="${tacheMap.statut == 0}">Non commencé</c:when>
                                                <c:when test="${tacheMap.statut == 1}">En cours</c:when>
                                                <c:when test="${tacheMap.statut == 2}">Terminé</c:when>
                                                <c:otherwise>Non commencé</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="tache-actions">
                                        <c:if test="${tacheMap.statut == 0}">
                                            <form method="post" action="taches/modifier-tache" style="display:inline;">
                                                <input type="hidden" name="idTachePlat" value="${tacheMap.tache.id}" />
                                                <input type="hidden" name="newStatut" value="1" />
                                                <input type="hidden" name="date" value="${date}" />
                                                <button type="submit" class="btn-action btn-commencer">Commencer</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${tacheMap.statut == 1}">
                                            <form method="post" action="taches/modifier-tache" style="display:inline;">
                                                <input type="hidden" name="idTachePlat" value="${tacheMap.tache.id}" />
                                                <input type="hidden" name="newStatut" value="2" />
                                                <input type="hidden" name="date" value="${date}" />
                                                <button type="submit" class="btn-action btn-terminer">Terminer</button>
                                            </form>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty platsAvecTaches}">
                <div class="no-plats">
                    <p>Aucun plat publié à cette date.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>