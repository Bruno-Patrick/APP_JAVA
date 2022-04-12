<%@ page pageEncoding="UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.AtendimentoController" scope="page" />
<jsp:useBean id="item" class="br.ufac.sgcm.model.Atendimento1" scope="page" />

<%
    String alertaMensagem = null;
    String alertaTipo = null; 

    String paramId = request.getParameter("id");
    if (paramId != null && !paramId.isEmpty()) {
        Long id = Long.parseLong(paramId);
        item = controller.getById(id);
    }

    String submit = request.getParameter("submit");
    if (submit != null) {
        if (!request.getParameter("id").isEmpty()) {
            item.setId(Long.parseLong(request.getParameter("id")));
        }
        item.set(request.getParameter("nome"));
        item.setRazaoSocial(request.getParameter("razaoSocial"));
        item.setCnpj(request.getParameter("cnpj"));
        item.setRepresentante(request.getParameter("representante"));
        item.setEmail(request.getParameter("email"));
        item.setTelefone(request.getParameter("telefone"));
        item.setAtivo(request.getParameter("ativo"));        
        int status = controller.save(item);
        try {
            if (status > 0) {
                alertaMensagem = "Atendimento salvo com sucesso!";
                alertaTipo = "sucesso";
                String url = "atendimento.jsp?" +
                    "alertaMensagem=" + alertaMensagem +
                    "&alertaTipo=" + alertaTipo;
                pageContext.forward(url);
            } else {
                alertaMensagem = "Erro ao salvar o Atendimento!";
                alertaTipo = "erro";
            }
        } catch (Exception e) {
            alertaMensagem = "Erro ao salvar o Atendimento!";
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
                <jsp:param name="alertaMensagem" value="<%=alertaMensagem%>"/>
                <jsp:param name="alertaTipo" value="<%=alertaTipo%>"/>
            </jsp:include>
            <% } %>
            <form method="post">
                <div class="grid">
                    <input type="hidden" name="id"
                           value="<%= item.getId() != null ? item.getId() : "" %>">
                    <label for="nome">Nome</label>
                    <input type="text" name="nome" id="nome"
                        value="<%= item.getNome() != null ? item.getNome() : "" %>">
                    <label for="razaoSocial">Razão Social</label>
                    <input type="text" name="razaoSocial" id="razaoSocial" required
                        value="<%= item.getRazaoSocial() != null ? item.getRazaoSocial() : "" %>">
                    <label for="cnpj">CNPJ</label>
                    <input type="text" name="cnpj" id="cnpj" required
                        value="<%= item.getCnpj() != null ? item.getCnpj() : "" %>">
                    <label for="representante">Representante</label>
                    <input type="text" name="representante" id="representante" required
                        value="<%= item.getRepresentante() != null ? item.getRepresentante() : "" %>">
                    <label for="email">E-mail</label>
                    <input type="text" name="email" id="email" required
                        value="<%= item.getEmail() != null ? item.getEmail() : "" %>">
                    <label for="telefone">Telefone</label>
                    <input type="text" name="telefone" id="telefone" required
                        value="<%= item.getTelefone() != null ? item.getTelefone() : "" %>">
                    <label for="ativo">Ativo</label>
                    <input type="checkbox" name="ativo" id="ativo"
                        value="true"<%=item.isAtivo() ? " checked" : ""%>>
                </div>
                <input type="button" value="Cancelar" data-redirect="convenios.jsp">
                <input type="submit" value="Salvar" name="submit">
            </form>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>
