<%-- 
    Document   : alterar_produtos
    Created on : 5 de jun. de 2025, 17:11:40
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
        <title>Alteração de produtos</title>
    </head>
    <body>
        <%
            //Receber os dados alterados no formulário carregaprod.jsp
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
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "root");
            
            //Alterar os dados na tabela produtos do BD
            
            st = conecta.prepareStatement("UPDATE produto SET nome = ?, marca = ?, preco = ? WHERE codigo = ?");
            st.setString(1, n);
            st.setString(2, m);
            st.setDouble(3, p);
            st.setInt(4, c);
            
            st.executeUpdate(); //Executa o UPDATE
            out.print("Os dados do produto " + c + " foi alterado com sucesso");
        %>
    </body>
</html>
