<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Distribution des Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Distribution des Tâches</h2>

    <!-- Sélecteur de date -->
    <div class="form-section">
        <div class="row align-items-end">
            <div class="col-md-4">
                <label for="dateSelect" class="form-label">Choisir une date :</label>
                <input type="date" class="form-control" id="dateSelect" name="date"
                       value="${date != null ? date : ''}">
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary" onclick="goToDate()">Recharger</button>
            </div>
        </div>
        <div class="mb-3 mt-3">
            <label for="platSelect">Plat :</label>
            <select class="form-select" id="platSelect" onchange="chargerTachesPlat(this.value)">
                <option value="">-- Choisir un plat --</option>
                <c:forEach items="${plats}" var="p">
                    <option value="${p.id}">${p.intitule}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <!-- Formulaire de distribution -->
    <div class="form-section">
        <h4>Distribuer une tâche à plusieurs employés</h4>
        <form action="submit" method="post">
            <!-- Tâche libre -->
            <div class="mb-3">
                <label for="tacheSelect">Tâche libre :</label>
                <select name="tache.id" id="tacheSelect" class="form-select">
                    <option value="">-- Aucune --</option>
                    <c:forEach items="${taches}" var="t">
                        <option value="${t.id}">${t.nom}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Tâche liée au plat -->
            <div class="mb-3">
                <label for="tachePlatSelect">Tâche du plat :</label>
                <select name="tachePlat.id" id="tachePlatSelect" class="form-select">
                    <option value="">Sélectionnez un plat d'abord</option>
                </select>
            </div>

            <!-- Employés (checkbox multiple) -->
            <div class="mb-3">
                <label>Employés :</label>
                <div class="row">
                    <div class="col-md-12 mb-2">
                        <button type="button" class="btn btn-sm btn-secondary" onclick="toggleCheckboxes()">Tout cocher / décocher</button>
                    </div>
                    <c:forEach items="${employes}" var="e">
                        <div class="col-md-4">
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

            <!-- Date de la tâche -->
            <div class="mb-3">
                <label for="dateTache">Date de la tâche :</label>
                <input type="date" name="date_tache" class="form-control" required
                       value="${date != null ? date : ''}">
            </div>

            <button type="submit" class="btn btn-success">Distribuer aux employés sélectionnés</button>
        </form>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty erreur}">
        <div class="alert alert-danger">${erreur}</div>
    </c:if>
</div>

<!-- JS -->
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
            if (tacheSelect.value) {
                tachePlatSelect.disabled = true;
            } else {
                tachePlatSelect.disabled = false;
            }
        });

        tachePlatSelect.addEventListener("change", () => {
            if (tachePlatSelect.value) {
                tacheSelect.disabled = true;
            } else {
                tacheSelect.disabled = false;
            }
        });
    });

    function toggleCheckboxes() {
        const checkboxes = document.querySelectorAll("input[name='employeIds']");
        const allChecked = Array.from(checkboxes).every(cb => cb.checked);
        checkboxes.forEach(cb => cb.checked = !allChecked);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
