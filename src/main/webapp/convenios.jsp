<%@ page pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="br.ufac.sgcm.model.Convenio" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.ConvenioController" scope="page" />

<%
    String alertaMensagem = null;
    String alertaTipo = null;    

    String paramAlerta = request.getParameter("alertaMensagem");
    if (paramAlerta != null && !paramAlerta.isEmpty()) {
        alertaMensagem = request.getParameter("alertaMensagem");
        alertaTipo = request.getParameter("alertaTipo");
    }

    String paramExcluir = request.getParameter("excluir");
    if (paramExcluir != null && !paramExcluir.isEmpty()) {
        Long id = Long.parseLong(paramExcluir);
        try {            
            int status = controller.delete(id);
            if (status > 0) {
                alertaMensagem = "Convênio excluído com sucesso!";
                alertaTipo = "sucesso";
            } else {
                alertaMensagem = "Erro ao excluir o convênio!";
                alertaTipo = "erro";
            }
        } catch (Exception e) {
            alertaMensagem = e.getMessage();
            alertaTipo = "erro";
        }
    }

    List<Convenio> registros;
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
                <jsp:param name="alertaMensagem" value="<%=alertaMensagem%>"/>
                <jsp:param name="alertaTipo" value="<%=alertaTipo%>"/>
            </jsp:include>
            <% } %>
            <jsp:include page="include/comandos.jsp">
                <jsp:param name="link" value="conveniosForm.jsp"/>
            </jsp:include>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Razão Social</th>
                        <th>CNPJ</th>
                        <th>Representante</th>
                        <th>E-mail</th>
                        <th>Telefone</th>
                        <th>Ativo</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Convenio item : registros) { %>
                    <tr>
                        <td class="fit"><%=item.getId()%></td>
                        <td><%=item.getNome()%></td>
                        <td><%=item.getRazaoSocial()%></td>
                        <td><%=item.getCnpj()%></td>
                        <td><%=item.getRepresentante()%></td>
                        <td><%=item.getEmail()%></td>
                        <td><%=item.getTelefone()%></td>
                        <td><%=item.isAtivo() ? "Sim" : "Não"%></td>
                        <td>
                            <a href="conveniosForm.jsp?id=<%=item.getId()%>" class="botao">Editar</a>
                            <a href="convenios.jsp?excluir=<%=item.getId()%>" class="botao excluir">Excluir</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="9">Total de registros: <%=registros.size()%></td>
                    </tr>
                </tfoot>
            </table>
        </main>
        <%@ include file="include/footer.jsp" %>
    </body>
</html>
