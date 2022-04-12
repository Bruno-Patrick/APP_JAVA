<%@ page pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="br.ufac.sgcm.model.Paciente" %>

<jsp:useBean id="controller" class="br.ufac.sgcm.controller.PacienteController" scope="page" />

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
                alertaMensagem = "Paciente excluído com sucesso!";
                alertaTipo = "sucesso";
            } else {
                alertaMensagem = "Erro ao excluir o paciente!";
                alertaTipo = "erro";
            }
        } catch (Exception e) {
            alertaMensagem = e.getMessage();
            alertaTipo = "erro";
        }
    }

    List<Paciente> registros;
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
                <jsp:param name="link" value="pacientesForm.jsp" />
            </jsp:include>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Telefone</th>
                        <th>Data de nascimento</th>
                        <th>Grupo Sanguíneo</th>
                        <th>Sexo</th>
                        <th>CEP</th>
                        <th>Endereço</th>
                        <th>Estado</th>
                        <th>Cidade</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Paciente item: registros) { %>
                    <tr>
                        <td class="fit"><%=item.getId()%></td>
                        <td><%=item.getNome()%></td>
                        <td><%=item.getEmail()%></td>
                        <td><%=item.getTelefone()%></td>
                        <td><%=item.getDataNascimento()%></td>
                        <td><%=item.getTipoSanguineo()%></td>
                        <td><%=item.getSexo()%></td>
                        <td><%=item.getCep()%></td>
                        <td><%=item.getEndereco()%></td>
                        <td><%=item.getEstado()%></td>
                        <td><%=item.getCidade()%></td>
                        <td>
                            <a href="pacientesForm.jsp?id=<%=item.getId()%>" class="botao">Editar</a>
                            <a href="pacientes.jsp?excluir=<%=item.getId()%>" class="botao excluir">Excluir</a>
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