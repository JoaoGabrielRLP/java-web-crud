<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="com.portfolio.crud.HtmlUtil"%>
<%@page import="com.portfolio.crud.Produto"%>
<%@page import="com.portfolio.crud.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Produtos cadastrados</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="pagina-conteudo">
        <h1>Produtos cadastrados</h1>
        <%
            String sucesso = request.getParameter("sucesso");
            String erro = request.getParameter("erro");
            if ("excluido".equals(sucesso)) {
        %>
            <div class="mensagem sucesso">Produto excluido com sucesso.</div>
        <%
            } else if ("atualizado".equals(sucesso)) {
        %>
            <div class="mensagem sucesso">Produto atualizado com sucesso.</div>
        <%
            }
            if ("nao_encontrado".equals(erro)) {
        %>
            <div class="mensagem erro">Produto nao encontrado.</div>
        <%
            }
        %>
        <%
            try {
                List<Produto> produtos = new ProdutoDAO().listar();
                if (produtos.isEmpty()) {
        %>
            <div class="mensagem">Nenhum produto cadastrado.</div>
        <%
                } else {
        %>
            <div class="tabela-container">
                <table>
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Nome</th>
                            <th>Marca</th>
                            <th>Preco</th>
                            <th>Acoes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Produto produto : produtos) { %>
                            <tr>
                                <td><%= produto.getCodigo() %></td>
                                <td><%= HtmlUtil.escape(produto.getNome()) %></td>
                                <td><%= HtmlUtil.escape(produto.getMarca()) %></td>
                                <td>R$ <%= produto.getPreco().setScale(2, java.math.RoundingMode.HALF_UP) %></td>
                                <td class="acoes">
                                    <a href="carregaprod.jsp?codigo=<%= produto.getCodigo() %>">Editar</a>
                                    <a href="excpro.jsp?codigo=<%= produto.getCodigo() %>">Excluir</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <%
                }
            } catch (IllegalStateException exception) {
        %>
            <div class="mensagem erro">O banco nao esta configurado. Consulte o README.</div>
        <%
            } catch (SQLException exception) {
        %>
            <div class="mensagem erro">Nao foi possivel consultar os produtos.</div>
        <%
            }
        %>
    </body>
</html>
