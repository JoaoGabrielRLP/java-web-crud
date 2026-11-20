<%@page import="java.sql.SQLException"%>
<%@page import="com.portfolio.crud.Produto"%>
<%@page import="com.portfolio.crud.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Excluir produto</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="pagina-conteudo">
        <%
            String codigoTexto = request.getParameter("codigo");
            String metodo = request.getMethod();
            try {
                int codigo = Integer.parseInt(codigoTexto == null ? "" : codigoTexto);
                ProdutoDAO dao = new ProdutoDAO();

                if ("POST".equalsIgnoreCase(metodo)) {
                    if (dao.excluir(codigo)) {
                        response.sendRedirect("listapro.jsp?sucesso=excluido");
                        return;
                    }
        %>
            <div class="mensagem erro">Produto nao encontrado.</div>
        <%
                } else {
                    Produto produto = dao.buscarPorCodigo(codigo);
                    if (produto == null) {
                        response.sendRedirect("listapro.jsp?erro=nao_encontrado");
                        return;
                    }
        %>
            <h1>Confirmar exclusao</h1>
            <p>Deseja excluir o produto <strong><%= com.portfolio.crud.HtmlUtil.escape(produto.getNome()) %></strong>
               (codigo <%= produto.getCodigo() %>)?</p>
            <form class="formulario-inline" method="post" action="excpro.jsp">
                <input type="hidden" name="codigo" value="<%= produto.getCodigo() %>">
                <button class="perigo" type="submit">Confirmar exclusao</button>
                <a class="botao secundario" href="listapro.jsp">Cancelar</a>
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
            <div class="mensagem erro">Nao foi possivel concluir a exclusao.</div>
        <%
            }
        %>
    </body>
</html>
