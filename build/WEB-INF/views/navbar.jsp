<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle"><span style="color: #006a4d;">VELON</span><span style="color: #f8c828;">KAN</span></span>
        </a>

        <!-- Tableau de bord -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Tableau de bord
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/recette">
                    <span class="align-middle">Suivi de recette</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/depense">
                    <span class="align-middle">Suivi de dépense</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/benefice">
                    <span class="align-middle">Suivi de bénéfice</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commandes/count">
                    <span class="align-middle">Évolution de Commandes</span>
                </a>
            </li>
        </ul>

        <!-- Commandes -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Commandes
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commande/form">
                    <span class="align-middle">Nouvelle Commande</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commande/">
                    <span class="align-middle">Liste Commande</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/plats/">
                    <span class="align-middle">Plats</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/stock/Stock/form">
                    <span class="align-middle">Monvement de stocks</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des ressources -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Ressources Humaines
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/employe/">
                    <span class="align-middle">Employés</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/employe/paiement_salaire">
                    <span class="align-middle">Paiement salaire</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/poste/">
                    <span class="align-middle">Postes</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/mvtcontrat/create">
                    <span class="align-middle">Contrats</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/penalite/">
                    <span class="align-middle">Pénalités</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/taches_plat/">
                    <span class="align-middle">Taches</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des stocks -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Gestion des stocks
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/stock/Stock/listeStoc">
                    <span class="align-middle">Stocks</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/composant/">
                    <span class="align-middle">Composants</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/type_composant/">
                    <span class="align-middle">Types de composants</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/unite/">
                    <span class="align-middle">Unités</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/categories/">
                    <span class="align-middle">Catégories</span>
                </a>
            </li>
        </ul>

        <!-- Administration -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Administration
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/entreprise/create">
                    <span class="align-middle">Créer entreprise</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/depense/">
                    <span class="align-middle">Dépenses</span>
                </a>
            </li>
        </ul>
    </div>
</nav>
