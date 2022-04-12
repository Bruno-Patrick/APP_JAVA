<%@ page pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="br.ufac.sgcm.model.Especialidade" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.EspecialidadeController" scope="page" />



<%
    String alertaMensagem = null;
    String alertaTipo = null;

    String paramAlerta = request.getParameter("alertaMensagem");
    if(paramAlerta != null && !paramAlerta.isEmpty()) {
        alertaMensagem = request.getParameter("alertaMensagem");
        alertaTipo = request.getParameter("alertaTipo");
    }

    String paramExcluir = request.getParameter("excluir");
    if (paramExcluir != null && !paramExcluir.isEmpty()) {
        Long id = Long.parseLong(paramExcluir);
        try {
            int status = controller.delete(id);
            if (status > 0) {
                alertaMensagem = "Especialidade excluída com sucesso!";
                alertaTipo = "sucesso";
            } else {
                alertaMensagem = "Erro ao excluir a Especialidade!";
                alertaTipo = "erro";
            }
        } catch (Exception e) {
            alertaMensagem = e.getMessage();
            alertaTipo = "erro";
        }
    }

    List<Especialidade> registros;
    String paramBusca = request.getParameter("busca");
    if (paramBusca != null && !paramBusca.isEmpty()) {
        registros = controller.getByAll(paramBusca);
    } else {
        registros = controller.getAll();
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
            <jsp:include page="include/comandos.jsp">
                <jsp:param name="link" value="especialidadesForm.jsp" />
            </jsp:include>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Especialidade item: registros) { %>
                    <tr>
                        <td class="fit"><%=item.getId()%></td>
                        <td><%=item.getNome()%></td>
                        <td>
                            <a href="especialidadesForm.jsp?id=<%=item.getId()%>" class="botao">Editar</a>
                            <a href="especialidades.jsp?excluir=<%=item.getId()%>" class="botao excluir">Excluir</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="8">Total de registros: <%=registros.size()%></td>
                    </tr>
                </tfoot>
            </table>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>