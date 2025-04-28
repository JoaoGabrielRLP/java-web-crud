<%-- 
    Document   : salvar_produtos
    Created on : 23 de abr. de 2025, 11:36:30
    Author     : João Gabriel
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         //Receber os dados digitados no formulário cadpro.html
         int c;
         String n, m;
         double p;
         
         c = Integer.parseInt(request.getParameter("codigo"));
         n = request.getParameter("nome");
         m = request.getParameter("marca"); 
         p = Double.parseDouble(request.getParameter("preco"));
         
         //Fazer a conexão com o banco de dados
         
         Connection conecta; // Guarda a conexão com o banco de dados
         
         PreparedStatement st;
         Class.forName("com.mysql.cj.jdbc.Driver"); // Serve para chamar a classe da livraria 
         conecta = DriverManager.getConnection(url)
        %>
    </body>
</html>
