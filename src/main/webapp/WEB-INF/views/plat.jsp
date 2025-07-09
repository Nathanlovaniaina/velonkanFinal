<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/base.jsp">
    <jsp:param name="title" value="Menu - Gestion des plats" />
    <jsp:param name="activePage" value="menu" />
    <jsp:param name="content" value="/WEB-INF/views/plat-content.jsp" />
</jsp:include>