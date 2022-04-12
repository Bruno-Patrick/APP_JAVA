<%@ page pageEncoding="UTF-8" %>

<%@ page import="br.ufac.sgcm.model.Especialidade" %>
<%@ page import="br.ufac.sgcm.model.Unidade" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.ProfissionalController" scope="page" />
<jsp:useBean id="item" class="br.ufac.sgcm.model.Profissional" scope="page" />

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
        item.setRegistroConselho(request.getParameter("registroConselho"));
        item.setEspecialidade(
            controller.getEspecialidade(
                Long.parseLong(request.getParameter("especialidade"))
            )
        );
        item.setUnidade(
            controller.getUnidade(
                Long.parseLong(request.getParameter("unidade"))
            )
        );
        item.setTelefone(request.getParameter("telefone"));
        item.setEmail(request.getParameter("email"));
        int status = controller.save(item);
        try {
            if (status > 0) {
                alertaMensagem = "Profissional salvo com sucesso!";
                alertaTipo = "sucesso";
                String url = "profissionais.jsp?" +
                    "alertaMensagem=" + alertaMensagem +
                    "&alertaTipo=" + alertaTipo;
                pageContext.forward(url);
            } else {
                alertaMensagem = "Erro ao salvar profissional!";
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
                    <label for="registroConselho">Registro</label>
                    <input type="text" name="registroConselho" id="registroConselho" required
                        value="<%= item.getRegistroConselho() != null ? item.getRegistroConselho() : "" %>">
                    <label for="especialidade">Especialidade</label>
                    <select name="especialidade" id="especialidade" required>
                        <option value="">Selecione</option>
                        <%
                            String selecionado = "";
                            for (Especialidade e: controller.getEspecialidades()) {
                                if (item.getId() != null) {
                                    selecionado = e.getId() == item.getEspecialidade().getId() ? " selected" : "";
                                }
                        %>
                        <option value="<%=e.getId()%>"<%=selecionado%>><%=e.getNome()%></option>
                        <% } %>
                    </select>
                    <label for="unidade">Unidade</label>
                    <select name="unidade" id="unidade" required>
                        <option value="">Selecione</option>
                        <%
                            for (Unidade u: controller.getUnidades()) {
                                if (item.getId() != null) {
                                    selecionado = u.getId() == item.getUnidade().getId() ? " selected" : "";
                                }
                        %>
                        <option value="<%=u.getId()%>"<%=selecionado%>><%=u.getNome()%></option>
                        <% } %>
                    </select>
                    <label for="telefone">Telefone</label>
                    <input type="text" name="telefone" id="telefone"
                        value="<%= item.getTelefone() != null ? item.getTelefone() : "" %>">
                    <label for="email">E-mail</label>
                    <input type="email" name="email" id="email"
                        value="<%= item.getEmail() != null ? item.getEmail() : "" %>">
                </div>
                <input type="button" value="Cancelar" data-redirect="profissionais.jsp">
                <input type="submit" value="Salvar" name="submit">
            </form>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>