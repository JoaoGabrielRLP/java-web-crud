<%-- 
    Document   : listapro
    Created on : 7 de mai. de 2025, 11:35:42
    Author     : João Gabriel
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de produtos</title>
    </head>
    <body>
        <%
            try{
            //Fazer a conexão com o banco de dados
         
            Connection conecta; // Guarda a conexão com o banco de dados
         
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver"); // Serve para chamar a classe da livraria 
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "root");
            //Inserir os dados na tabela produto do banco de dados aberto
            st = conecta.prepareStatement("select * from produto");
            ResultSet rs = st.executeQuery();
            
            %>
              <table border="1">
                <tr>
                    <th>Código</th>
                    <th>Nome</th>
                    <th>Marca</th>
                    <th>Preço</th>
                    <th>Exclusão</th>
                    <th>Alteração</th>
                </tr>
            <%
            
            while(rs.next()){
            %>     
                <tr>
                    <td> <%= rs.getString("codigo") %> </td>
                    <td> <%= rs.getString("nome") %> </td>
                    <td> <%= rs.getString("marca") %> </td>
                    <td> <%= rs.getString("preco") %> </td>
                    <td><a href="excpro.jsp?codigo=<%= rs.getString("codigo")%>">Excluir</a></td>
                    <td><a href="carregaprod.jsp?codigo=<%= rs.getString("codigo")%>">Alterar</a></td>
                </tr>
            <%
                
            }
            %>
            </table>
            <%
            } catch (Exception x){
                out.print("Erro: " + x.getMessage());
            }
        %>
    </body>
</html>
