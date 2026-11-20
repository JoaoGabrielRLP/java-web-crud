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
        <title>Resultado do cadastro</title>
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
                <strong>O produto nao foi cadastrado.</strong>
                <ul>
                    <% for (String erro : erros) { %>
                        <li><%= com.portfolio.crud.HtmlUtil.escape(erro) %></li>
                    <% } %>
                </ul>
            </div>
        <%
            } else {
                try {
                    int codigo = Integer.parseInt(codigoTexto.trim());
                    Produto produto = new Produto(
                            codigo,
                            nome.trim(),
                            marca.trim(),
                            new BigDecimal(precoTexto.trim().replace(',', '.')));
                    new ProdutoDAO().criar(produto);
        %>
            <div class="mensagem sucesso">Produto cadastrado com sucesso.</div>
        <%
                } catch (java.sql.SQLIntegrityConstraintViolationException exception) {
        %>
            <div class="mensagem erro">Ja existe um produto com esse codigo.</div>
        <%
                } catch (IllegalStateException exception) {
        %>
            <div class="mensagem erro">O banco nao esta configurado. Consulte o README para definir as variaveis de ambiente.</div>
        <%
                } catch (SQLException exception) {
        %>
            <div class="mensagem erro">Nao foi possivel salvar o produto no banco de dados.</div>
        <%
                }
            }
        %>
        <p><a class="botao" href="cadpro.html">Cadastrar outro produto</a></p>
        <p><a href="listapro.jsp">Ver listagem</a></p>
    </body>
</html>
