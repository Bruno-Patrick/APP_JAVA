package br.ufac.sgcm;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ExibeDados extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String mensagem = req.getParameter("mensagem");
        
        PrintWriter saida = resp.getWriter();
        saida.println("<html>");
        saida.println("<body>");
        saida.println("<p>" + mensagem + "</p>");
        saida.println("</body>");
        saida.println("</html>");
    }
    
}
