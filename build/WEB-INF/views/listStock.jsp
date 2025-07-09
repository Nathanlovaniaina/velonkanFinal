<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Stock" %>
<%@ page import="org.example.entity.Composant" %>
<%
    List<Stock> stocks = (List<Stock>) request.getAttribute("stock");
    List<Composant> composants = (List<Composant>) request.getAttribute("composants");
%>
<html>
<head>
    <title>Liste des stocks</title>
    
    <script>
        function confirmAction(msg, url) {
            if(confirm(msg)) {
                window.location.href = url;
            }
        }
    </script>
    <style>
        .expired {
            background-color: #ffcccc;
        }
        .expired td {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/stock/Stock/form">Ajouter ou retirer un stock</a><br>
    <a href="${pageContext.request.contextPath}/stock/Stock/list">Voir les historiques stocks</a><br>
    <h2>Liste des stocks</h2>
    <table border="1">
        <tr>
            <th>Id</th>
            <th>Composant</th>
            <th>Quantité</th>
            <th>Actions</th>
            </tr>
        <% for(Stock s : stocks) { %>
        <tr>
            <td><%= s.getId() %></td>
            <td>
            <% for(Composant c : composants) { %>
                   <% if (c.getId() == s.getComposant().getId()){ %>
                    <%= c.getNom() %>
                <% } %>
            <% } %>
            </td>
            <td><%= s.getQtteStock() %></td>
            <td>
                <a href="#" onclick="confirmAction('Confirmer la suppression ?', '${pageContext.request.contextPath}/stock/Stock/delete?id=<%=s.getId()%>')" class="action-link delete-link">Supprimer</a>
                <a href="#" onclick="confirmAction('Confirmer la modification ?', '${pageContext.request.contextPath}/stock/Stock/update?id=<%=s.getId()%>')" class="action-link">Modifier</a>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <a href="${pageContext.request.contextPath}/stock/Stock/create" class="action-link">Ajouter un nouveau stock</a><br>
</body>
</html>
