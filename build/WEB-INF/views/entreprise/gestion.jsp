<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Entreprises | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/gestion.css" rel="stylesheet">
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
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
                            <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profil</a>
                                <a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Paramètres</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i> Déconnexion</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle">Gestion des Entreprises</h1>
                        <p class="text-muted mb-0">Antananarivo - Madagascar</p>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert ${message.contains('Erreur') ? 'alert-danger' : 'alert-success'} alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <ul class="nav nav-tabs mb-4" id="entrepriseTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link ${tab != 'list' ? 'active' : ''}" id="create-tab" data-bs-toggle="tab" data-bs-target="#create" type="button" role="tab">Créer Entreprise</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link ${tab == 'list' ? 'active' : ''}" id="list-tab" data-bs-toggle="tab" data-bs-target="#list" type="button" role="tab">Liste des Entreprises</button>
                        </li>
                    </ul>

                    <div class="tab-content" id="entrepriseTabsContent">
                        <!-- Onglet Création -->
                        <div class="tab-pane fade ${tab != 'list' ? 'show active' : ''}" id="create" role="tabpanel">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">${entreprise.id != null ? 'Modifier' : 'Créer'} une entreprise</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${entreprise.id != null}">
                                            <form id="entreprise-form" action="${pageContext.request.contextPath}/entreprise/update" method="post">
                                                <input type="hidden" name="id" value="${entreprise.id}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <form id="entreprise-form" action="${pageContext.request.contextPath}/entreprise/save" method="post">
                                        </c:otherwise>
                                    </c:choose>
                                        <input type="hidden" id="quartier" name="quartier" value="${entreprise.quartier}"/>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="nom" class="form-label">Nom de l'entreprise *</label>
                                                    <input type="text" id="nom" name="nom" class="form-control" required value="${entreprise.nom}" placeholder="Entrez le nom de l'entreprise"/>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Quartier d'Antananarivo</label>
                                                    <div class="quartier-dropdown">
                                                        <button type="button" class="btn btn-outline-primary w-100 text-start" onclick="toggleQuartierList()">
                                                            <span id="selected-quartier">${not empty entreprise.quartier ? entreprise.quartier : 'Choisir un quartier'}</span>
                                                            <i class="bi bi-chevron-down float-end"></i>
                                                        </button>
                                                        <div id="quartier-list" class="quartier-list"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="adresse" class="form-label">Adresse exacte *</label>
                                            <input type="text" id="adresse" name="adresse" class="form-control" required value="${entreprise.adresse}" placeholder="Entrez l'adresse exacte"/>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label">Localisation sur la carte</label>
                                            <div id="map"></div>
                                            <div class="mt-3">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="latitude" class="form-label">Latitude</label>
                                                        <input type="number" step="0.000001" id="latitude" name="latitude" class="form-control" value="${entreprise.latitude != null ? entreprise.latitude : ''}" placeholder="Latitude"/>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="longitude" class="form-label">Longitude</label>
                                                        <input type="number" step="0.000001" id="longitude" name="longitude" class="form-control" value="${entreprise.longitude != null ? entreprise.longitude : ''}" placeholder="Longitude"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="debutDateContrat" class="form-label">Date de début du contrat</label>
                                            <input type="date" id="debutDateContrat" name="debutDateContrat" class="form-control" value="<fmt:formatDate value='${entreprise.debutDateContrat}' pattern='yyyy-MM-dd'/>"/>
                                        </div>
                                        
                                        <div class="d-flex justify-content-end">
                                            <a href="${pageContext.request.contextPath}/entreprise/list" class="btn btn-outline-secondary me-2">
                                                <i class="bi bi-arrow-left me-1"></i> Annuler
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-1"></i> ${entreprise.id != null ? 'Mettre à jour' : 'Enregistrer'}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Onglet Liste -->
                        <div class="tab-pane fade ${tab == 'list' ? 'show active' : ''}" id="list" role="tabpanel">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des entreprises</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty entreprises}">
                                            <div class="text-center py-5">
                                                <i class="bi bi-building text-muted" style="font-size: 3rem;"></i>
                                                <h5 class="mt-3">Aucune entreprise enregistrée</h5>
                                                <a href="${pageContext.request.contextPath}/entreprise/create" class="btn btn-primary mt-3">
                                                    <i class="bi bi-plus-circle me-1"></i> Ajouter une entreprise
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row">
                                                <c:forEach var="entreprise" items="${entreprises}">
                                                    <div class="col-md-6 col-lg-4">
                                                        <div class="entreprise-card">
                                                            <div class="entreprise-name">${entreprise.nom}</div>
                                                            <div class="info-item">
                                                                <strong>Adresse:</strong> <c:out value="${entreprise.adresse != null ? entreprise.adresse : 'Non défini'}"/>
                                                            </div>
                                                            <div class="info-item">
                                                                <strong>Quartier:</strong> <c:out value="${entreprise.quartier != null ? entreprise.quartier : 'Non défini'}"/>
                                                            </div>
                                                            <div class="info-item">
                                                                <strong>Coordonnées:</strong> 
                                                                <c:out value="${entreprise.latitude != null ? entreprise.latitude : 'Non défini'}, ${entreprise.longitude != null ? entreprise.longitude : 'Non défini'}"/>
                                                            </div>
                                                            <div class="info-item">
                                                                <strong>Date de début:</strong> 
                                                                <c:out value="${entreprise.debutDateContrat != null ? '' : 'Non défini'}"/>
                                                                <fmt:formatDate value="${entreprise.debutDateContrat}" pattern="dd/MM/yyyy"/>
                                                            </div>
                                                            <div class="d-flex justify-content-end mt-3">
                                                                <button class="btn btn-sm btn-outline-primary me-2" 
                                                                        onclick="viewOnMap(${entreprise.latitude != null ? entreprise.latitude : -18.8792}, ${entreprise.longitude != null ? entreprise.longitude : 47.5079}, '${entreprise.nom}')">
                                                                    <i class="bi bi-map me-1"></i> Carte
                                                                </button>
                                                                <a href="${pageContext.request.contextPath}/entreprise/edit/${entreprise.id}" class="btn btn-sm btn-secondary me-2">
                                                                    <i class="bi bi-pencil me-1"></i> Modifier
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/entreprise/delete/${entreprise.id}" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette entreprise ?')">
                                                                    <i class="bi bi-trash me-1"></i> Supprimer
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script>
        const quartiers = [
            { nom: "Analakely", lat: -18.9087, lng: 47.5204 },
            { nom: "Antaninarenina", lat: -18.9143, lng: 47.5217 },
            { nom: "Tsaralalana", lat: -18.9089, lng: 47.5198 },
            { nom: "Ambohijatovo", lat: -18.9234, lng: 47.5289 },
            { nom: "Faravohitra", lat: -18.9012, lng: 47.5234 },
            { nom: "Ambohimiandra", lat: -18.8756, lng: 47.5123 },
            { nom: "Andavamamba", lat: -18.9167, lng: 47.5345 },
            { nom: "Ambodivona", lat: -18.8934, lng: 47.5456 },
            { nom: "Ambohipo", lat: -18.8823, lng: 47.5167 },
            { nom: "Ankazobe", lat: -18.9456, lng: 47.5678 },
            { nom: "Antanimena", lat: -18.9234, lng: 47.5123 },
            { nom: "Isotry", lat: -18.9345, lng: 47.5234 },
            { nom: "67Ha", lat: -18.9135, lng: 47.5450 },
            { nom: "Ankorondrano", lat: -18.8765, lng: 47.5267 },
            { nom: "Ivandry", lat: -18.8667, lng: 47.5312 },
            { nom: "Ambatobe", lat: -18.8652, lng: 47.5432 },
            { nom: "Andohalo", lat: -18.9108, lng: 47.5215 },
            { nom: "Ankatso", lat: -18.8990, lng: 47.5280 },
            { nom: "Ampasamadinika", lat: -18.9250, lng: 47.5317 },
            { nom: "Mahamasina", lat: -18.9225, lng: 47.5165 },
            { nom: "Anosy", lat: -18.9201, lng: 47.5164 },
            { nom: "Soarano", lat: -18.9051, lng: 47.5169 },
            { nom: "Ambanidia", lat: -18.9074, lng: 47.5304 },
            { nom: "Anosibe", lat: -18.9267, lng: 47.5220 },
            { nom: "Ampefiloha", lat: -18.9149, lng: 47.5275 },
            { nom: "Ankazomanga", lat: -18.8995, lng: 47.5500 },
            { nom: "Anosivavaka", lat: -18.9333, lng: 47.5333 },
            { nom: "Sabotsy Namehana", lat: -18.8350, lng: 47.5700 },
            { nom: "Ilafy", lat: -18.8567, lng: 47.5623 },
            { nom: "Mahazo", lat: -18.8789, lng: 47.5670 },
            { nom: "Ambohimangakely", lat: -18.8700, lng: 47.6000 },
            { nom: "Andraharo", lat: -18.8892, lng: 47.5255 },
            { nom: "Antohomadinika", lat: -18.9141, lng: 47.5281 },
            { nom: "Anjanahary", lat: -18.8993, lng: 47.5078 },
            { nom: "Ampandrana", lat: -18.9100, lng: 47.5270 },
            { nom: "Ambatoroka", lat: -18.8842, lng: 47.5308 },
            { nom: "Ankadifotsy", lat: -18.9083, lng: 47.5282 },
            { nom: "Ankadikely", lat: -18.8362, lng: 47.5791 },
            { nom: "Anjanamasina", lat: -18.8760, lng: 47.5425 },
            { nom: "Anosizato", lat: -18.9269, lng: 47.5001 },
            { nom: "Antsobolo", lat: -18.9110, lng: 47.5225 },
            { nom: "Ampitatafika", lat: -18.9543, lng: 47.4682 },
            { nom: "Manjakaray", lat: -18.8828, lng: 47.5281 },
            { nom: "Ambohitrimanjaka", lat: -18.8581, lng: 47.4453 },
            { nom: "Tanjombato", lat: -18.9547, lng: 47.5132 },
            { nom: "Ankadindramamy", lat: -18.8642, lng: 47.5365 },
            { nom: "Amboditsiry", lat: -18.8912, lng: 47.5334 },
            { nom: "Ambolokandrina", lat: -18.9184, lng: 47.5290 },
            { nom: "Ankerana", lat: -18.8785, lng: 47.5702 },
            { nom: "Fidasiana", lat: -18.9102, lng: 47.5338 }
        ];

        let map;
        let marker;

        function initMap(lat = -18.8792, lng = 47.5079, zoom = 12) {
            if (map) {
                map.remove();
            }
            map = L.map('map').setView([lat, lng], zoom);
            L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
                attribution: 'Tiles © Esri — Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
                maxZoom: 18
            }).addTo(map);

            map.on('click', function(e) {
                placeMarker(e.latlng);
            });

            const latInput = document.getElementById('latitude').value;
            const lngInput = document.getElementById('longitude').value;
            if (latInput && lngInput && !isNaN(latInput) && !isNaN(lngInput)) {
                placeMarker({ lat: parseFloat(latInput), lng: parseFloat(lngInput) });
                map.setView([parseFloat(latInput), parseFloat(lngInput)], 16);
                highlightQuartier(latInput, lngInput);
            }
        }

        function placeMarker(latlng) {
            if (marker) {
                marker.remove();
            }
            marker = L.marker(latlng).addTo(map)
                .bindPopup(`Coordonnées: (${latlng.lat.toFixed(6)}, ${latlng.lng.toFixed(6)})`);
            document.getElementById('latitude').value = latlng.lat.toFixed(6);
            document.getElementById('longitude').value = latlng.lng.toFixed(6);
            highlightQuartier(latlng.lat, latlng.lng);

            marker.on('mouseover', function() {
                marker.openPopup();
            });
            marker.on('mouseout', function() {
                marker.closePopup();
            });
        }

        function toggleQuartierList() {
            const list = document.getElementById('quartier-list');
            list.classList.toggle('show');
        }

        function generateQuartierList() {
            const list = document.getElementById('quartier-list');
            list.innerHTML = '';
            quartiers.forEach(quartier => {
                const item = document.createElement('div');
                item.className = 'quartier-list-item';
                item.textContent = quartier.nom;
                item.onclick = () => {
                    selectQuartier(quartier, item);
                    toggleQuartierList();
                };
                if (quartier.nom === document.getElementById('quartier').value) {
                    item.classList.add('selected');
                }
                list.appendChild(item);
            });
        }

        function highlightQuartier(lat, lng) {
            const tolerance = 0.01;
            const quartier = quartiers.find(q => 
                Math.abs(q.lat - lat) < tolerance && Math.abs(q.lng - lng) < tolerance
            );
            document.querySelectorAll('.quartier-list-item').forEach(item => item.classList.remove('selected'));
            if (quartier) {
                document.querySelectorAll('.quartier-list-item').forEach(item => {
                    if (item.textContent === quartier.nom) {
                        item.classList.add('selected');
                    }
                });
                document.getElementById('quartier').value = quartier.nom;
                document.getElementById('selected-quartier').textContent = quartier.nom;
            } else {
                document.getElementById('quartier').value = '';
                document.getElementById('selected-quartier').textContent = 'Choisir un quartier';
            }
        }

        function viewOnMap(lat, lng, nom) {
            // Activer l'onglet création
            const tab = new bootstrap.Tab(document.getElementById('create-tab'));
            tab.show();
            
            // Initialiser la carte après un petit délai pour permettre le changement d'onglet
            setTimeout(() => {
                initMap(lat, lng, 16);
                placeMarker({ lat, lng });
                highlightQuartier(lat, lng);
                
                // Afficher un popup avec le nom de l'entreprise
                if (marker) {
                    marker.bindPopup(`<b>${nom}</b><br>Coordonnées: (${lat.toFixed(6)}, ${lng.toFixed(6)})`).openPopup();
                }
            }, 300);
        }

        function selectQuartier(quartier, element) {
            document.querySelectorAll('.quartier-list-item').forEach(item => item.classList.remove('selected'));
            element.classList.add('selected');
            document.getElementById('latitude').value = quartier.lat.toFixed(6);
            document.getElementById('longitude').value = quartier.lng.toFixed(6);
            document.getElementById('quartier').value = quartier.nom;
            document.getElementById('selected-quartier').textContent = quartier.nom;
            if (map) {
                map.setView([quartier.lat, quartier.lng], 16);
                placeMarker({ lat: quartier.lat, lng: quartier.lng });
            }
        }

        function validateForm() {
            const nom = document.getElementById('nom').value;
            const adresse = document.getElementById('adresse').value;
            const latitude = document.getElementById('latitude').value;
            const longitude = document.getElementById('longitude').value;
            const debutDateContrat = document.getElementById('debutDateContrat').value;
            let errorMessage = '';

            if (!nom || nom.trim() === '') {
                errorMessage += 'Le nom de l\'entreprise est requis.\n';
            }
            if (!adresse || adresse.trim() === '') {
                errorMessage += 'L\'adresse est requise.\n';
            }
            if (latitude && (isNaN(latitude) || parseFloat(latitude) < -90 || parseFloat(latitude) > 90)) {
                errorMessage += 'La latitude doit être un nombre valide entre -90 et 90.\n';
            }
            if (longitude && (isNaN(longitude) || parseFloat(longitude) < -180 || parseFloat(longitude) > 180)) {
                errorMessage += 'La longitude doit être un nombre valide entre -180 et 180.\n';
            }
            if (latitude && !longitude || !latitude && longitude) {
                errorMessage += 'Veuillez fournir à la fois la latitude et la longitude, ou aucune des deux.\n';
            }
            if (debutDateContrat && !/^\d{4}-\d{2}-\d{2}$/.test(debutDateContrat)) {
                errorMessage += 'La date de début du contrat doit être au format AAAA-MM-JJ.\n';
            }

            if (errorMessage) {
                alert(errorMessage);
                return false;
            }
            return true;
        }

        document.addEventListener('DOMContentLoaded', () => {
            generateQuartierList();
            initMap();
            
            // Initialiser les tabs Bootstrap
            const tabEls = document.querySelectorAll('button[data-bs-toggle="tab"]');
            tabEls.forEach(tabEl => {
                tabEl.addEventListener('shown.bs.tab', function (event) {
                    if (event.target.id === 'create-tab') {
                        setTimeout(() => {
                            const lat = parseFloat(document.getElementById('latitude').value) || -18.8792;
                            const lng = parseFloat(document.getElementById('longitude').value) || 47.5079;
                            initMap(lat, lng, 16);
                            if (document.getElementById('latitude').value && document.getElementById('longitude').value) {
                                placeMarker({ lat, lng });
                            }
                        }, 100);
                    }
                });
            });
            
            document.getElementById('entreprise-form').addEventListener('submit', (e) => {
                if (!validateForm()) {
                    e.preventDefault();
                }
            });
            
            document.addEventListener('click', (e) => {
                const dropdown = document.querySelector('.quartier-dropdown');
                const list = document.getElementById('quartier-list');
                if (!dropdown.contains(e.target) && list.classList.contains('show')) {
                    list.classList.remove('show');
                }
            });
            
            // Initialiser le toggle de la sidebar
            const sidebarToggle = document.querySelector('.js-sidebar-toggle');
            const sidebar = document.querySelector('.js-sidebar');
            
            if (sidebarToggle && sidebar) {
                sidebarToggle.addEventListener('click', () => {
                    sidebar.classList.toggle('collapsed');
                });
            }
        });
    </script>
</body>
</html>