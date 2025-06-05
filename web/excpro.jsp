<%-- 
    Document   : excpro
    Created on : 14 de mai. de 2025, 08:26:11
    Author     : João Gabriel
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir produtos</title>
    </head>
    <body>
        <%
            //Recebe o código digitado no formulário
            int cod;
            cod = Integer.parseInt(request.getParameter("codigo")); //Pega o parâmetro da página excpro.html e o converte para int
            //Faz a conexão entre o mysql e o banco de dados

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "root");
                //Excluem o produto de código informado
                PreparedStatement st = conecta.prepareStatement("DELETE FROM produto WHERE codigo=?");
                st.setInt(1, cod);
                int resultado = st.executeUpdate();
                // Verifica se o produto foi ou não excluído
                if (resultado == 0) {
                    out.print("Este produto não está cadastrado");
                } else {
                    out.print("O produto de código " + cod + " foi excluído com sucesso");
                }

            } catch (Exception erro) {
                String mensagemErro = erro.getMessage();
                out.print("Entre em contato com o suporte e informe o erro: " + mensagemErro);
            }
        %>
    </body>
</html>
