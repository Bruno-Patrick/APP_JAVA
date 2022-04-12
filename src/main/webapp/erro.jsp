<%@ page pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <%@ include file="include/head.jsp" %>
    <body>
        <%@ include file="include/header.jsp" %>
        <%@ include file="include/nav.jsp" %>
        <main>
            <h1>Algo de errado não está certo!</h1>
            <pre><%=exception%></pre>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>