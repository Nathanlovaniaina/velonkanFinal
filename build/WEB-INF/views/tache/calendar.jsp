<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.time.LocalDate" %>

<%
    Integer month = (Integer) request.getAttribute("month");
    Integer year = (Integer) request.getAttribute("year");
    Calendar cal = (Calendar) request.getAttribute("cal");

    if (cal == null) {
        cal = new GregorianCalendar();
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.YEAR, year);
    }

    int firstDay = cal.get(Calendar.DAY_OF_WEEK);
    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calendrier des Tâches | VELONKAN</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/type_composant.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007e5d !important;
            --secondary-color: #f8c828 !important;
            --primary-light: #e6f2ef !important;
            --secondary-light: #fef8e6 !important;
            --dark-color: #2c3e50 !important;
            --light-color: #f8f9fa !important;
        }
        
        body {
            font-family: 'Inter', sans-serif !important;
            background-color: var(--primary-light) !important;
            color: var(--dark-color) !important;
        }

        .month-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .month-header h1 {
            color: var(--primary-color) !important;
            font-size: 1.8rem;
            margin: 0 20px;
            display: inline-block;
        }

        .nav-button {
            padding: 10px 20px;
            background-color: var(--primary-color) !important;
            color: white !important;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin: 0 5px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background-color: #006a4d !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background-color: var(--primary-color) !important;
            color: white !important;
            padding: 15px;
            font-weight: 600;
            text-align: center;
        }

        td {
            padding: 15px;
            border: 1px solid #e0e0e0;
            text-align: center;
            height: 100px;
            vertical-align: top;
            transition: background-color 0.3s;
        }

        td:hover {
            background-color: var(--secondary-light) !important;
        }

        td a {
            text-decoration: none;
            color: var(--dark-color);
            display: block;
            width: 100%;
            height: 100%;
            padding: 5px;
            border-radius: 4px;
            transition: all 0.3s;
            font-weight: 500;
        }

        td a:hover {
            background-color: var(--secondary-color) !important;
            color: var(--primary-color) !important;
            font-weight: bold;
            transform: scale(1.05);
        }

        /* Style pour les jours du week-end */
        td:first-child a, td:last-child a {
            color: #e74c3c;
        }

        /* Style pour le jour courant */
        .current-day {
            background-color: var(--primary-light) !important;
            position: relative;
        }

        .current-day:after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 50%;
            transform: translateX(-50%);
            width: 8px;
            height: 8px;
            background-color: var(--primary-color);
            border-radius: 50%;
        }
        
        /* Adaptation pour la page calendrier */
        .calendar-container {
            padding: 20px;
            background-color: var(--primary-light);
            min-height: 100vh;
        }
        
        .calendar-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
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

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="calendar-container">
                        <div class="calendar-card">
                            <div class="month-header">
                                <form method="get" action="calendrier" style="display:inline;">
                                    <input type="hidden" name="month" value="<%= month - 1 %>"/>
                                    <input type="hidden" name="year" value="<%= year %>"/>
                                    <button type="submit" class="nav-button">
                                        <i class="bi bi-chevron-left"></i> Mois précédent
                                    </button>
                                </form>

                                <h1><%= String.format("%tB %tY", cal, cal) %></h1>

                                <form method="get" action="calendrier" style="display:inline;">
                                    <input type="hidden" name="month" value="<%= month + 1 %>"/>
                                    <input type="hidden" name="year" value="<%= year %>"/>
                                    <button type="submit" class="nav-button">
                                        Mois suivant <i class="bi bi-chevron-right"></i>
                                    </button>
                                </form>
                            </div>

                            <table>
                                <thead>
                                <tr>
                                    <th>Dim</th>
                                    <th>Lun</th>
                                    <th>Mar</th>
                                    <th>Mer</th>
                                    <th>Jeu</th>
                                    <th>Ven</th>
                                    <th>Sam</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    int dayCounter = 1;
                                    cal.set(Calendar.DAY_OF_MONTH, 1);
                                    int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

                                    for (int week = 0; week < 6; week++) {
                                        out.println("<tr>");
                                        for (int dow = 1; dow <= 7; dow++) {
                                            if ((week == 0 && dow < startDayOfWeek) || dayCounter > daysInMonth) {
                                                out.println("<td></td>");
                                            } else {
                                                String jour = String.format("%02d", dayCounter);
                                                String mois = String.format("%02d", month);
                                                String dateStr = year + "-" + mois + "-" + jour;
                                                LocalDate currentDate = LocalDate.now();
                                                LocalDate cellDate = LocalDate.of(year, month, dayCounter);
                                                String currentClass = currentDate.equals(cellDate) ? "current-day" : "";
                                %>
                                                <td class="<%= currentClass %>">
                                                    <a href="form?date=<%= dateStr %>"><%= dayCounter %></a>
                                                </td>
                                <%
                                                dayCounter++;
                                            }
                                        }
                                        out.println("</tr>");
                                        if (dayCounter > daysInMonth) break;
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>