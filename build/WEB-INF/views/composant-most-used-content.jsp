<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Page Header -->
<div class="page-header">
    <h1 class="page-title">Analytics - Ingrédients les plus utilisés</h1>
    <p class="page-subtitle">Analysez l'utilisation de vos ingrédients sur une période donnée</p>
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

<!-- Filter Form -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Filtres</h3>
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
        </svg>
    </div>
    
    <form action="${pageContext.request.contextPath}/composant/most-used" method="get" class="filter-form">
        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">Date de début</label>
                <input type="date" name="dateDebut" class="form-input" 
                       value="${not empty selectedDateDebut and fn:length(selectedDateDebut) >= 10 ? selectedDateDebut.substring(0,10) : ''}">
            </div>
            
            <div class="form-group">
                <label class="form-label">Date de fin</label>
                <input type="date" name="dateFin" class="form-input" 
                       value="${not empty selectedDateFin and fn:length(selectedDateFin) >= 10 ? selectedDateFin.substring(0,10) : ''}">
            </div>
            
            <div class="form-group">
                <label class="form-label">Type de composant</label>
                <select name="typeId" class="form-select">
                    <option value="">Tous les types</option>
                    <c:forEach var="type" items="${types}">
                        <option value="${type.id}" ${selectedTypeId == type.id ? 'selected' : ''}>${type.nom}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label class="form-label">&nbsp;</label>
                <button type="submit" class="btn btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    Filtrer
                </button>
            </div>
        </div>
    </form>
</div>

<!-- Results Section -->
<div class="grid grid-2">
    <!-- Ranking Table -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Classement des ingrédients</h3>
            <c:if test="${not empty composantUsages}">
                <span class="badge badge-success">${fn:length(composantUsages)} résultats</span>
            </c:if>
        </div>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Rang</th>
                        <th>Nom de l'ingrédient</th>
                        <th class="text-right">Quantité utilisée</th>
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
                                        <div class="ingredient-info">
                                            <div class="font-medium">${usage.nom}</div>
                                        </div>
                                    </td>
                                    <td class="text-right">
                                        <div class="font-semibold number">${usage.totalUtilise}</div>
                                        <div class="text-secondary text-sm">
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
                                        <svg width="48" height="48" viewBox="0 0 24 24" fill="currentColor">
                                            <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
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
                        <span class="total-value font-bold">${total}</span>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <!-- Chart -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Graphique d'utilisation</h3>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
            </svg>
        </div>
        
        <div class="chart-container">
            <canvas id="usageChart"></canvas>
        </div>
    </div>
</div>

<!-- Chart Script -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    borderColor: 'var(--border)',
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
                            color: 'var(--border)'
                        },
                        ticks: {
                            color: 'var(--text-secondary)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: 'var(--text-secondary)',
                            maxRotation: 45
                        }
                    }
                }
            }
        });
    }
});
</script>

<style>
/* Filter Form */
.filter-form {
    margin-top: var(--spacing-md);
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--spacing-md);
}

/* Table Styles */
.top-row {
    background-color: rgba(255, 215, 0, 0.05) !important;
}

.top-1 {
    background-color: rgba(255, 215, 0, 0.1) !important;
    border-left: 4px solid var(--primary);
}

.top-2 {
    background-color: rgba(76, 175, 80, 0.1) !important;
    border-left: 4px solid var(--secondary);
}

.top-3 {
    background-color: rgba(255, 152, 0, 0.1) !important;
    border-left: 4px solid #FF9800;
}

.rank-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background-color: var(--surface);
    color: var(--text-secondary);
    font-weight: 600;
    font-size: 0.875rem;
}

.top-rank {
    background-color: var(--primary);
    color: var(--text-primary);
}

.ingredient-info {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-xs);
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: var(--spacing-xl) !important;
}

.empty-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: var(--spacing-md);
    color: var(--text-muted);
}

.empty-content svg {
    color: var(--text-muted);
}

.empty-content h4 {
    font-weight: 600;
    color: var(--text-secondary);
    margin: 0;
}

.empty-content p {
    margin: 0;
    font-size: 0.875rem;
}

/* Card Footer */
.card-footer {
    margin-top: var(--spacing-md);
    padding-top: var(--spacing-md);
    border-top: 1px solid var(--border);
}

.total-summary {
    display: flex;
    justify-content: flex-end;
}

.total-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.total-label {
    color: var(--text-secondary);
    font-size: 0.875rem;
}

.total-value {
    color: var(--primary);
    font-size: 1.125rem;
}

/* Chart Container */
.chart-container {
    height: 400px;
    position: relative;
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
    .form-grid {
        grid-template-columns: 1fr;
    }
    
    .chart-container {
        height: 300px;
    }
}
</style> 