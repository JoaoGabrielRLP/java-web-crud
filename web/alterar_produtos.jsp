<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="com.portfolio.crud.Produto"%>
<%@page import="com.portfolio.crud.ProdutoDAO"%>
<%@page import="com.portfolio.crud.ProdutoValidator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resultado da alteracao</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="pagina-conteudo">
        <%
            String codigoTexto = request.getParameter("codigo");
            String nome = request.getParameter("nome");
            String marca = request.getParameter("marca");
            String precoTexto = request.getParameter("preco");
            List<String> erros = ProdutoValidator.validar(codigoTexto, nome, marca, precoTexto);

            if (!erros.isEmpty()) {
        %>
            <div class="mensagem erro">
                <strong>A alteracao nao foi salva.</strong>
                <ul>
                    <% for (String erro : erros) { %>
                        <li><%= com.portfolio.crud.HtmlUtil.escape(erro) %></li>
                    <% } %>
                </ul>
            </div>
        <%
            } else {
                try {
                    Produto produto = new Produto(
                            Integer.parseInt(codigoTexto.trim()),
                            nome.trim(),
                            marca.trim(),
                            new BigDecimal(precoTexto.trim().replace(',', '.')));
                    if (new ProdutoDAO().atualizar(produto)) {
                        response.sendRedirect("listapro.jsp?sucesso=atualizado");
                        return;
                    }
        %>
            <div class="mensagem erro">Produto nao encontrado.</div>
        <%
                } catch (IllegalStateException exception) {
        %>
            <div class="mensagem erro">O banco nao esta configurado. Consulte o README.</div>
        <%
                } catch (SQLException exception) {
        %>
            <div class="mensagem erro">Nao foi possivel atualizar o produto.</div>
        <%
                }
            }
        %>
        <p><a href="listapro.jsp">Voltar para a listagem</a></p>
    </body>
</html>
