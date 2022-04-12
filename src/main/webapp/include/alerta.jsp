<%@ page pageEncoding="UTF-8" %>
            <div class="alerta <%=request.getParameter("alertaTipo")%>">
                <span>&times;</span>
                <%=request.getParameter("alertaMensagem")%>
            </div>
