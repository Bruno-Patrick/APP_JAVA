<%@ page pageEncoding="UTF-8" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.PacienteController" scope="page" />
<jsp:useBean id="item" class="br.ufac.sgcm.model.Paciente" scope="page" />

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
        item.setEmail(request.getParameter("email"));
        item.setTelefone(request.getParameter("telefone"));
        item.setDataNascimento(request.getParameter("dataNascimento"));
        item.setTipoSanguineo(request.getParameter("tipoSanguineo"));
        item.setSexo(request.getParameter("sexo"));
        item.setCep(request.getParameter("cep"));
        item.setEndereco(request.getParameter("endereco"));
        item.setEstado(request.getParameter("estado"));
        item.setCidade(request.getParameter("cidade"));
        int status = controller.save(item);
        try {
            if (status > 0) {
                alertaMensagem = "Paciente cadastrado com sucesso!";
                alertaTipo = "sucesso";
                String url = "pacientes.jsp?" +
                    "alertaMensagem=" + alertaMensagem +
                    "&alertaTipo=" + alertaTipo;
                pageContext.forward(url);
            } else {
                alertaMensagem = "Erro ao cadastrar paciente!";
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
                    <label for="email">E-mail</label>
                    <input type="email" name="email" id="email"
                        value="<%= item.getEmail() != null ? item.getEmail() : "" %>">
                    <label for="telefone">Telefone</label>
                    <input type="text" name="telefone" id="telefone"
                        value="<%= item.getTelefone() != null ? item.getTelefone() : "" %>">
                    <label for="datadenascimento">Data de Nascimento</label>
                    <input type="text" name="datadenascimento" id="datadenascimento" required
                        value="<%= item.getDataNascimento() != null ? item.getDataNascimento() : "" %>">
                    <label for="gruposanguineo">Grupo Sanguíneo</label>
                    <input type="text" name="gruposanguineo" id="gruposanguineo" required
                        value="<%= item.getTipoSanguineo() != null ? item.getTipoSanguineo() : "" %>">
                    <label for="sexo">Sexo</label>
                    <input type="text" name="sexo" id="sexo" required
                        value="<%= item.getSexo() != null ? item.getSexo() : "" %>">
                    <label for="CEP">CEP</label>
                    <input type="text" name="CEP" id="CEP" required
                        value="<%= item.getCep() != null ? item.getCep() : "" %>">
                    <label for="endereco">Endereço</label>
                    <input type="text" name="endereco" id="endereco" required
                        value="<%= item.getEndereco() != null ? item.getEndereco() : "" %>">
                    <label for="estado">Estado</label>
                    <input type="text" name="estado" id="estado" required
                        value="<%= item.getEstado() != null ? item.getEstado() : "" %>">
                    <label for="cidade">Cidade</label>
                    <input type="text" name="cidade" id="cidade" required
                        value="<%= item.getCidade() != null ? item.getCidade() : "" %>">
                    <%-- <label for="especialidade">Especialidade</label>
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
                    </select> --%>
                    <%-- <label for="unidade">Unidade</label>
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
                    </select> --%>
                </div>
                <input type="button" value="Cancelar" data-redirect="pacientes.jsp">
                <input type="submit" value="Salvar" name="submit">
            </form>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>