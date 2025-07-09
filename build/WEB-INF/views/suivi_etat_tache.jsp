<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Suivi des plats publiés</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
        }

        h2 {
            color: #007e5d;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
        }

        input[type="date"] {
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 8px 16px;
            background-color: #007e5d;
            color: white;
            border: none;
            border-radius: 4px;
            margin-left: 10px;
            cursor: pointer;
        }

        button:hover {
            background-color: #005c45;
        }

        h3 {
            background-color: #007e5d;
            color: white;
            padding: 10px;
            border-radius: 4px;
        }

        ul {
            list-style-type: none;
            padding-left: 20px;
            margin-top: 10px;
        }

        li {
            background-color: #fff;
            padding: 10px;
            margin-bottom: 8px;
            border-left: 5px solid #f8c828;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        hr {
            border: 1px solid #ddd;
            margin: 30px 0;
        }

        .status {
            font-weight: bold;
        }

        .termine {
            color: green;
        }

        .non-commence {
            color: #888;
        }

        .en-cours {
            color: #f8c828;
        }

        p {
            font-style: italic;
            color: #777;
        }
    </style>
</head>
<body>

    <h2>Suivi des plats publiés</h2>

    <form action="${pageContext.request.contextPath}/suivi/taches" method="get">
        <label for="date">Date de publication :</label>
        <input type="date" name="date" id="date" value="${date}" />
        <button type="submit">Rechercher</button>
    </form>

    <c:if test="${not empty platsAvecTaches}">
        <c:forEach var="platMap" items="${platsAvecTaches}">
            <h3>Plat : ${platMap.plat.intitule} — 
                <c:choose>
                    <c:when test="${platMap.statutGlobal == 0}">
                        <span class="status non-commence">Non commencé</span>
                    </c:when>
                    <c:when test="${platMap.statutGlobal == 1}">
                        <span class="status en-cours">En cours</span>
                    </c:when>
                    <c:when test="${platMap.statutGlobal == 2}">
                        <span class="status termine">Terminé ✅</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status non-commence">Non commencé</span>
                    </c:otherwise>
                </c:choose>
            </h3>

            <ul>
                <c:forEach var="tacheMap" items="${platMap.taches}">
                    <li>
                        Tâche : ${tacheMap.tache.nom} — Statut :
                        <c:choose>
                            <c:when test="${tacheMap.statut == 0}">
                                <span class="status non-commence">Non commencé</span>
                                <form method="post" action="taches/modifier-tache" style="display:inline;">
                                    <input type="hidden" name="idTachePlat" value="${tacheMap.tache.id}" />
                                    <input type="hidden" name="newStatut" value="1" />
                                    <input type="hidden" name="date" value="${date}" />
                                    <button type="submit">Commencer</button>
                                </form>
                            </c:when>
                            <c:when test="${tacheMap.statut == 1}">
                                <span class="status en-cours">En cours</span>
                                <form method="post" action="taches/modifier-tache" style="display:inline;">
                                    <input type="hidden" name="idTachePlat" value="${tacheMap.tache.id}" />
                                    <input type="hidden" name="newStatut" value="2" />
                                    <input type="hidden" name="date" value="${date}" />
                                    <button type="submit">Terminer</button>
                                </form>
                            </c:when>
                            <c:when test="${tacheMap.statut == 2}">
                                <span class="status termine">Terminé ✅</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status">Inconnu</span>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
            </ul>

            <hr/>
        </c:forEach>
    </c:if>

    <c:if test="${empty platsAvecTaches}">
        <p>Aucun plat publié à cette date.</p>
    </c:if>

</body>
</html>
