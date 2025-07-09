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
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commandes/count">
                    <span class="align-middle">Statistiques</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/recette">
                    <span class="align-middle">Recettes</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/depense">
                    <span class="align-middle">Dépenses</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/benefice">
                    <span class="align-middle">Bénéfices</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des commandes -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Commandes
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commande/form">
                    <span class="align-middle">Nouvelle commande</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commande/">
                    <span class="align-middle">Liste des commandes</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi">
                    <span class="align-middle">Suivi en temps réel</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/calendrier">
                    <span class="align-middle">Planification</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des plats -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Production
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/plats/">
                    <span class="align-middle">Catalogue des plats</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/taches">
                    <span class="align-middle">Tâches de production</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/taches_plat/">
                    <span class="align-middle">Modèles de tâches</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/composant/most-used">
                    <span class="align-middle">Analyse des ingrédients</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des stocks -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Stocks et Approvisionnement
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/stock/Stock/listeStoc">
                    <span class="align-middle">État des stocks</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/stock/Stock/form">
                    <span class="align-middle">Mouvements</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/composant/">
                    <span class="align-middle">Ingrédients</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/type_composant/">
                    <span class="align-middle">Types d'ingrédients</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/unite/">
                    <span class="align-middle">Unités de mesure</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/categories/">
                    <span class="align-middle">Catégories</span>
                </a>
            </li>
        </ul>

        <!-- Ressources Humaines -->
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
                <a class="sidebar-link" href="${pageContext.request.contextPath}/employe/paiement_salaire">
                    <span class="align-middle">Paie</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/penalite/">
                    <span class="align-middle">Gestion des pénalités</span>
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
                    <span class="align-middle">Clients (entreprises)</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/depense/">
                    <span class="align-middle">Dépenses générales</span>
                </a>
            </li>
        </ul>
    </div>
</nav>