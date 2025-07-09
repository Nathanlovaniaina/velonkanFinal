<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Page Header -->
<div class="page-header">
    <h1 class="page-title">Menu - Gestion des plats</h1>
    <p class="page-subtitle">Créez et gérez vos plats avec leurs compositions</p>
</div>

<!-- Alerts -->
<c:if test="${not empty succes}">
    <div class="alert alert-success">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        ${succes}
    </div>
</c:if>
<c:if test="${not empty erreur}">
    <div class="alert alert-error">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        ${erreur}
    </div>
</c:if>

<!-- Main Content Grid -->
<div class="grid grid-2">
    <!-- Form Section -->
    
    
    <!-- Filter Section -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
                </svg>
                Filtrer les plats
            </h3>
        </div>
        
        <form action="${pageContext.request.contextPath}/plat/since-date" method="get" class="filter-form">
            <div class="form-group">
                <label class="form-label">Date de création</label>
                <input type="date" name="date" value="${selectedDate}" class="form-input">
            </div>
            <button type="submit" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
                Filtrer
            </button>
        </form>
        
        <div class="stats-summary">
            <div class="stat-item">
                <div class="stat-value">${totalPlats}</div>
                <div class="stat-label">Plats au total</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">
                    <c:set var="avgPrice" value="0" />
                    <c:forEach var="p" items="${plats}">
                        <c:set var="avgPrice" value="${avgPrice + p.prix}" />
                    </c:forEach>
                    <c:if test="${totalPlats > 0}">
                        <fmt:formatNumber value="${avgPrice / totalPlats}" pattern="#.##" />
                    </c:if>
                </div>
                <div class="stat-label">Prix moyen (€)</div>
            </div>
        </div>
    </div>
</div>

<!-- Plats List -->
<div class="card mt-4">
    <div class="card-header">
        <h3 class="card-title">Liste des plats</h3>
        <span class="badge badge-success">${totalPlats} plats</span>
    </div>
    
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Plat</th>
                    <th>Prix</th>
                    <th>Date de création</th>
                    <th>Compositions</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="plat" items="${plats}">
                    <tr>
                        <td>
                            <div class="plat-id">#${plat.id}</div>
                        </td>
                        <td>
                            <div class="plat-info">
                                <div class="plat-name">${plat.intitule}</div>
                                <!-- Suppression de l'affichage de l'image du plat -->
                            </div>
                        </td>
                        <td>
                            <div class="price-display">
                                <span class="font-semibold">€${plat.prix}</span>
                            </div>
                        </td>
                        <td>
                            <div class="date-display">
                                <div class="text-sm">${plat.dateCreation}</div>
                            </div>
                        </td>
                        <td>
                            <div class="compositions-display">
                                <c:choose>
                                    <c:when test="${not empty plat.compositions}">
                                        <c:forEach var="composition" items="${plat.compositions}" varStatus="status">
                                            <span class="composition-tag">
                                                ${composition.composant.nom}: ${composition.quantite} ${composition.composant.unite.symbol}
                                            </span>
                                            <c:if test="${!status.last}"><br></c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Aucun ingrédient</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/plat/edit?id=${plat.id}" class="btn btn-outline btn-sm">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                                        <path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/>
                                        <path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/>
                                    </svg>
                                    Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/plat/delete?id=${plat.id}" 
                                   class="btn btn-outline btn-sm btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce plat ?')">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                                        <path d="M3 6h18M8 6V4a2 2 0 012-2h4a2 2 0 012 2v2m3 0v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6h14z"/>
                                    </svg>
                                    Supprimer
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- JavaScript -->
<script>
function addCompositionRow() {
    const container = document.getElementById('compositions-container');
    const row = document.createElement('div');
    row.className = 'composition-row';
    row.innerHTML = `
        <div class="composition-grid">
            <div class="form-group">
                <select name="composantIds" class="form-select" required>
                    <option value="">Sélectionner un ingrédient</option>
                    <c:forEach var="composant" items="${composants}">
                        <option value="${composant.id}">${composant.nom} (${composant.unite.symbol})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <input type="number" step="0.01" name="quantites" class="form-input" required min="0.01" placeholder="Quantité">
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-outline btn-danger" onclick="removeCompositionRow(this)">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
        </div>
    `;
    container.appendChild(row);
}

function removeCompositionRow(button) {
    button.closest('.composition-row').remove();
}

function validateForm() {
    const rows = document.getElementsByClassName('composition-row');
    if (rows.length === 0) {
        alert('Veuillez ajouter au moins un ingrédient.');
        return false;
    }
    for (let row of rows) {
        const select = row.querySelector('select[name="composantIds"]');
        const input = row.querySelector('input[name="quantites"]');
        if (!select.value || !input.value || input.value <= 0) {
            alert('Veuillez sélectionner un ingrédient et entrer une quantité valide.');
            return false;
        }
    }
    return true;
}
</script>

<style>
/* Form Styles */
.plat-form {
    margin-top: var(--spacing-md);
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--spacing-md);
}

/* Compositions Section */
.compositions-section {
    margin-top: var(--spacing-lg);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-md);
    padding-bottom: var(--spacing-sm);
    border-bottom: 1px solid var(--border);
}

.section-header h4 {
    margin: 0;
    font-weight: 600;
    color: var(--text-primary);
}

.composition-row {
    margin-bottom: var(--spacing-md);
    padding: var(--spacing-md);
    background-color: var(--surface);
    border-radius: var(--radius);
    border: 1px solid var(--border);
}

.composition-grid {
    display: grid;
    grid-template-columns: 2fr 1fr auto;
    gap: var(--spacing-md);
    align-items: end;
}

/* Form Actions */
.form-actions {
    display: flex;
    gap: var(--spacing-md);
    margin-top: var(--spacing-lg);
    padding-top: var(--spacing-md);
    border-top: 1px solid var(--border);
}

/* Filter Form */
.filter-form {
    margin-top: var(--spacing-md);
}

/* Stats Summary */
.stats-summary {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--spacing-md);
    margin-top: var(--spacing-lg);
    padding-top: var(--spacing-md);
    border-top: 1px solid var(--border);
}

.stat-item {
    text-align: center;
    padding: var(--spacing-md);
    background-color: var(--surface);
    border-radius: var(--radius);
}

.stat-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--primary);
    margin-bottom: var(--spacing-xs);
}

.stat-label {
    font-size: 0.875rem;
    color: var(--text-secondary);
}

/* Table Styles */
.plat-id {
    font-family: 'Courier New', monospace;
    font-weight: 600;
    color: var(--text-secondary);
}

.plat-info {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.plat-name {
    font-weight: 500;
    color: var(--text-primary);
}

.plat-thumbnail {
    width: 40px;
    height: 40px;
    border-radius: var(--radius);
    object-fit: cover;
}

.price-display {
    color: var(--secondary);
}

.compositions-display {
    max-width: 200px;
}

.composition-tag {
    display: inline-block;
    background-color: var(--surface);
    color: var(--text-secondary);
    padding: var(--spacing-xs) var(--spacing-sm);
    border-radius: 12px;
    font-size: 0.75rem;
    margin-bottom: var(--spacing-xs);
}

.action-buttons {
    display: flex;
    gap: var(--spacing-xs);
}

.btn-sm {
    padding: var(--spacing-xs) var(--spacing-sm);
    font-size: 0.75rem;
}

/* Alerts */
.alert {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    padding: var(--spacing-md);
    border-radius: var(--radius);
    margin-bottom: var(--spacing-md);
    font-weight: 500;
}

.alert-success {
    background-color: rgba(76, 175, 80, 0.1);
    color: var(--secondary);
    border: 1px solid rgba(76, 175, 80, 0.2);
}

.alert-error {
    background-color: rgba(244, 67, 54, 0.1);
    color: #f44336;
    border: 1px solid rgba(244, 67, 54, 0.2);
}

/* Responsive */
@media (max-width: 768px) {
    .composition-grid {
        grid-template-columns: 1fr;
        gap: var(--spacing-sm);
    }
    
    .form-actions {
        flex-direction: column;
    }
    
    .stats-summary {
        grid-template-columns: 1fr;
    }
    
    .action-buttons {
        flex-direction: column;
    }
}
</style> 