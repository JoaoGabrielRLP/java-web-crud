<%@page import="java.sql.SQLException"%>
<%@page import="com.portfolio.crud.HtmlUtil"%>
<%@page import="com.portfolio.crud.Produto"%>
<%@page import="com.portfolio.crud.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar produto</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="pagina-conteudo">
        <h1>Editar produto</h1>
        <%
            String codigoTexto = request.getParameter("codigo");
            try {
                int codigo = Integer.parseInt(codigoTexto == null ? "" : codigoTexto);
                Produto produto = new ProdutoDAO().buscarPorCodigo(codigo);
                if (produto == null) {
        %>
            <div class="mensagem erro">Produto nao encontrado.</div>
        <%
                } else {
        %>
            <form class="formulario" method="post" action="alterar_produtos.jsp">
                <label for="codigo">Codigo</label>
                <input type="number" name="codigo" id="codigo" value="<%= produto.getCodigo() %>" readonly>

                <label for="nome">Nome</label>
                <input type="text" name="nome" id="nome" maxlength="50" value="<%= HtmlUtil.escape(produto.getNome()) %>" required>

                <label for="marca">Marca</label>
                <input type="text" name="marca" id="marca" maxlength="50" value="<%= HtmlUtil.escape(produto.getMarca()) %>" required>

                <label for="preco">Preco</label>
                <input type="number" name="preco" id="preco" min="0" step="0.01"
                       value="<%= produto.getPreco().setScale(2, java.math.RoundingMode.HALF_UP) %>" required>

                <button type="submit">Salvar alteracoes</button>
            </form>
        <%
                }
            } catch (NumberFormatException exception) {
        %>
            <div class="mensagem erro">Codigo invalido.</div>
        <%
            } catch (IllegalStateException exception) {
        %>
            <div class="mensagem erro">O banco nao esta configurado. Consulte o README.</div>
        <%
            } catch (SQLException exception) {
        %>
            <div class="mensagem erro">Nao foi possivel carregar o produto.</div>
        <%
            }
        %>
        <p><a href="listapro.jsp">Voltar para a listagem</a></p>
    </body>
</html>
