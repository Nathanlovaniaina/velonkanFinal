<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Suivi Commandes | VELONKAN</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007e5d;
            --secondary-color: #f8c828;
            --primary-light: #e6f2ef;
            --secondary-light: #fef8e6;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
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
        
        .sidebar-toggle {
            color: var(--primary-color);
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        
        label {
            font-weight: 500;
            color: var(--dark-color);
        }
        
        input[type="datetime-local"] {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }
        
        button[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        button[type="submit"]:hover {
            background-color: #006a4d;
        }
        
        .commande-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        
        h3 {
            color: var(--primary-color);
            margin-top: 0;
            display: flex;
            justify-content: space-between;
        }
        
        ul {
            list-style-type: none;
            padding: 0;
        }
        
        li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        
        .statut-livre {
            color: var(--success-color);
            font-weight: 500;
        }
        
        .statut-encours {
            color: var(--secondary-color);
            font-weight: 500;
        }
        
        hr {
            border-color: #eee;
            margin: 20px 0;
        }
        
        .btn-livrer {
            background-color: var(--success-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-livrer:hover {
            background-color: #25a25a;
        }
        
        .btn-terminer {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-terminer:hover {
            background-color: #006a4d;
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

            <h2>Commandes du 
                <c:choose>
                    <c:when test="${not empty dateHeure}">
                        ${dateHeure.toLocalDate()}
                    </c:when>
                    <c:otherwise>
                        Aujourd'hui
                    </c:otherwise>
                </c:choose>
            </h2>

            <form method="get" action="">
                <label>Date et heure : </label>
                <input type="datetime-local" name="dateHeure"
                       value="<c:out value='${dateHeure != null ? dateHeure.toString().replace(" ", "T") : ""}'/>" />
                <button type="submit">Afficher</button>
            </form>

            <c:forEach var="commande" items="${commandes}">
                <div class="commande-container">
                    <h3>
                        <span>Entreprise : ${commande.entreprise}</span>
                        <span>Livré sur place à ${commande.heure}</span>
                    </h3>
                    
                    <c:if test="${commande.lastStatut==0}">
                        <p class="statut-encours">En cours de Livraison</p>
                    </c:if>
                    <c:if test="${commande.lastStatut==1}">
                        <p class="statut-livre">Livré</p>
                    </c:if>
                    
                    <ul>
                        <c:forEach var="plat" items="${commande.plats}">
                            <li>${plat.nom} : ${plat.quantite} (Statut : ${plat.statut})</li>
                        </c:forEach>
                    </ul>

                    <div style="display: flex; gap: 10px;">
                        <c:if test="${commande.livrable}">
                            <form method="post" action="/livrer" style="margin: 0;">
                                <input type="hidden" name="idCommande" value="${commande.id}" />
                                <input type="hidden" name="statut" value="0" />
                                <input type="hidden" name="dateHeure" value="${dateHeure}" />
                                <button type="submit" class="btn-livrer">✅ Livrer</button>
                            </form>
                        </c:if>
                        <c:if test="${commande.lastStatut==1}">
                            <form method="post" action="/livrer" style="margin: 0;">
                                <input type="hidden" name="idCommande" value="${commande.id}" />
                                <input type="hidden" name="statut" value="1" />
                                <input type="hidden" name="dateHeure" value="${dateHeure}" />
                                <button type="submit" class="btn-terminer">✅ Terminer la Livraison</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>