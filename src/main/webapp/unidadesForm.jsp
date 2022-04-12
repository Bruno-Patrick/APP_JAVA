<%@ page pageEncoding="UTF-8" %>

<%@ page import="br.ufac.sgcm.model.Unidade" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.UnidadeController" scope="page" />
<jsp:useBean id="unidadeAtual" class="br.ufac.sgcm.model.Unidade" scope="page" />

<%

    String alertaMensagem = null;
    String alertaTipo = null;

    String idParam = request.getParameter("id");
    String param = request.getParameter("enviar");

    if (idParam != null && !idParam.isEmpty()) {
        Long id = Long.parseLong(idParam);
        unidadeAtual = controller.getById(id);
    }


    if ((param != null && !param.isEmpty()) && (idParam != null && !idParam.isEmpty())) {
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");

        Long id = Long.parseLong(idParam);
        int registrosAfetados = 0;

        Unidade unidade = new Unidade();

        try {
            unidade.setId(id);
            unidade.setNome(nome);
            unidade.setEndereco(endereco);
            registrosAfetados = controller.save(unidade);

            if (registrosAfetados > 0) {
                alertaMensagem = "Unidade foi Editada com sucesso!";
                alertaTipo = "sucesso";
            } else {
                alertaMensagem = "Erro ao editar a Unidade!";
                alertaTipo = "erro";
            }
       } catch (Exception e) {
            alertaMensagem = e.getMessage();
            alertaTipo = "erro";
        }
    } else if ((param != null && !param.isEmpty()) && idParam.isEmpty()) {
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");

        int registrosAfetados = 0;

        Unidade unidade = new Unidade();

        try {
            unidade.setNome(nome);
            unidade.setEndereco(endereco);

            registrosAfetados = controller.save(unidade);

            if (registrosAfetados > 0) {
                alertaMensagem = "Unidade foi Adicionada com sucesso!";
                alertaTipo = "sucesso";
            } else {
                alertaMensagem = "Erro ao Adicionar a Unidade!";
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
            <form action="unidadesForm.jsp" method="get">
                <input type="hidden" name="id" value="<%=idParam != null && !idParam.isEmpty() ? idParam : ""%>">

                <div class="grid">
                    <label for="nome">Nome</label>
                    <input type="text" name="nome" id="nome" value="<%=unidadeAtual.getNome() != null ? unidadeAtual.getNome() : ""%>" required>
                    <label for="cep">CEP</label>
                    <input type="text" name="cep" id="cep">
                    <label for="endereco">Endereço</label>
                    <input type="text" name="endereco" id="endereco" value="<%=unidadeAtual.getEndereco() != null ? unidadeAtual.getEndereco() : ""%>">
                </div>
                <input type="button" value="Cancelar" data-redirect="unidades.jsp">
                <input type="submit" value="Salvar" name="enviar">
            </form>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>