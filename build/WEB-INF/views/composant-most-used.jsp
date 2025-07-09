<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/layout/base.jsp">
    <jsp:param name="title" value="Analytics - Ingrédients les plus utilisés" />
    <jsp:param name="activePage" value="analytics" />
    <jsp:param name="content" value="/WEB-INF/views/composant-most-used-content.jsp" />
    <jsp:param name="additionalCss" value="/resources/css/chart.css" />
</jsp:include>