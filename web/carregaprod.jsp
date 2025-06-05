<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de produtos</title>
    </head>
    <body>
        <%
            //Recebe o código do produto alterar    
            int c;
            c = Integer.parseInt(request.getParameter("codigo"));
            //Conectar ao banco de dados    

            //Fazer a conexão com o banco de dados
            Connection conecta; // Guarda a conexão com o banco de dados

            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver"); // Serve para chamar a classe da livraria 
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "root");
            //Buscar o produto pelo código que foi recebido
            st = conecta.prepareStatement("SELECT * FROM produto WHERE codigo = ?");

            st.setInt(1, c);
            ResultSet resultado = st.executeQuery();
            //Verifica se o produto de código informado foi encontrado
            if (!resultado.next()) { // Se não encontrar o produto
                out.print("Este produto não foi encontrado");
            } else { //Se encontrou o produto
        %>
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="codigo">Códido do produto</label> <!-- O campo for serve para vincular a label com o input utilizando o ID no input -->
                <input type="text" name="codigo" id="codigo" value="<%= resultado.getString("codigo") %>" readonly> <!-- O name guarda o que for digitado no campo -->
            </p>

            <p>
                <label for="nome">Nome do produto:</label> 
                <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%= resultado.getString("nome") %>"> 
            </p>

            <p>
                <label for="marca">Marca:</label> 
                <input type="text" name="marca" id="marca" size="50" maxlength="50" value="<%= resultado.getString("marca") %>"> 
                       </p>

                       <p>
                       <label for="preco">Preço:</label> 
                <input type="text" name="preco" id="preco" value="<%= resultado.getString("preco") %>"> 
                       </p>

                       <p>
                       <input type="submit" value="Salvar alterações">
            </p>
        </form>
        <%
            }
        %>
    </body>
</html>
