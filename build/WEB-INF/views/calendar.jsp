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
    <title>Calendrier des Tâches</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
        }

        .month-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .month-header h1 {
            color: #007e5d;
        }

        .nav-button {
            padding: 8px 16px;
            background-color: #007e5d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 10px;
        }

        .nav-button:hover {
            background-color: #005c45;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        th {
            background-color: #007e5d;
            color: white;
            padding: 10px;
        }

        td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
            height: 80px;
        }

        td a {
            text-decoration: none;
            color: black;
            display: block;
            padding: 10px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        td a:hover {
            background-color: #f8c828;
            color: #007e5d;
            font-weight: bold;
        }

        tr:nth-child(even) td {
            background-color: #fdfdfd;
        }
    </style>
</head>
<body>
<div class="month-header">
    <form method="get" action="calendrier" style="display:inline;">
        <input type="hidden" name="month" value="<%= month - 1 %>"/>
        <input type="hidden" name="year" value="<%= year %>"/>
        <button type="submit" class="nav-button">← Mois précédent</button>
    </form>

    <h1><%= String.format("%tB %tY", cal, cal) %></h1>

    <form method="get" action="calendrier" style="display:inline;">
        <input type="hidden" name="month" value="<%= month + 1 %>"/>
        <input type="hidden" name="year" value="<%= year %>"/>
        <button type="submit" class="nav-button">Mois suivant →</button>
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
    %>
                    <td>
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

</body>
</html>
