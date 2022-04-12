<%@ page pageEncoding="UTF-8" %>


<jsp:useBean id="controller" class="br.ufac.sgcm.controller.EspecialidadeController" scope="page" />
<jsp:useBean id="item" class="br.ufac.sgcm.model.Especialidade" scope="page" />

<% 
    String alertaMensagem = null;
    String alertaTipo = null;

        String paramId = request.getParameter("id");
    if (paramId != null && !paramId.isEmpty()) {
        Long id = Long.parseLong(paramId);
        item = controller.getById(id);
    }

    String paramSubmit = request.getParameter("submit");
    if (paramSubmit != null) {
        if (!request.getParameter("id").isEmpty()) {
            item.setId(Long.parseLong(request.getParameter("id")));
        }
        item.setNome(request.getParameter("nome"));
        int status = controller.save(item);
        try {
            if (status > 0) {
                alertaMensagem = "Especialidade salva com sucesso!";
                alertaTipo = "sucesso";
                String url = "especialidades.jsp?" +
                    "alertaMensagem=" + alertaMensagem +
                    "&alertaTipo=" + alertaTipo;
                pageContext.forward(url);
            } else {
                alertaMensagem = "Erro ao salvar a especialidade!";
                alertaTipo = "erro";
            }
        } catch (Exception e) {
            alertaMensagem = e.getMessage();
            alertaTipo = "erro";
        }
    }
%>
<!DOCTYPE html>
<html>
    <%@ include file="include/head.jsp" %>
    <body>
        <%@ include file="include/header.jsp" %>
        <%@ include file="include/nav.jsp" %>
        <main>
            <% if (alertaMensagem != null) { %>
            <jsp:include page="include/alerta.jsp">
                <jsp:param name="alertaMensagem" value="<%=alertaMensagem%>" />
                <jsp:param name="alertaTipo" value="<%=alertaTipo%>" />
            </jsp:include>
            <% } %>
            <form method="post">
                <div class="grid">
                    <input type="hidden" name="id"
                        value="<%= item.getId() != null ? item.getId() : "" %>">
                    <label for="nome">Nome</label>
                    <input type="text" name="nome" id="nome" required
                        value="<%= item.getNome() != null ? item.getNome() : "" %>">
                </div>
                <input type="button" value="Cancelar" data-redirect="especialidades.jsp">
                <input type="submit" value="Salvar" name="submit">
            </form>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>