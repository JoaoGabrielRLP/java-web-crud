<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de produto</title>
    </head>
    <body>
        <%
         String codigoTexto = request.getParameter("codigo");
         String nome = request.getParameter("nome");
         String marca = request.getParameter("marca");
         String precoTexto = request.getParameter("preco");

         if (codigoTexto == null || nome == null || marca == null || precoTexto == null
                 || codigoTexto.trim().isEmpty() || nome.trim().isEmpty()
                 || marca.trim().isEmpty() || precoTexto.trim().isEmpty()) {
             out.print("Preencha todos os campos.");
         } else {
             try {
                 int codigo = Integer.parseInt(codigoTexto.trim());
                 nome = nome.trim();
                 marca = marca.trim();
                 BigDecimal preco = new BigDecimal(precoTexto.trim().replace(",", "."));

                 if (nome.length() > 50 || marca.length() > 50
                         || preco.compareTo(BigDecimal.ZERO) < 0
                         || preco.scale() > 2) {
                     out.print("Dados invalidos. Confira os limites e o preco.");
                 } else {
                     String url = System.getenv("DB_URL");
                     String usuario = System.getenv("DB_USER");
                     String senha = System.getenv("DB_PASSWORD");

                     if (url == null || url.trim().isEmpty()
                             || usuario == null || usuario.trim().isEmpty()
                             || senha == null) {
                         out.print("Banco nao configurado. Defina DB_URL, DB_USER e DB_PASSWORD.");
                     } else {
                         Class.forName("com.mysql.cj.jdbc.Driver");
                         try (Connection conecta = DriverManager.getConnection(url, usuario, senha);
                              PreparedStatement st = conecta.prepareStatement(
                                  "INSERT INTO produto (codigo, nome, marca, preco) VALUES (?, ?, ?, ?)")) {
                             st.setInt(1, codigo);
                             st.setString(2, nome);
                             st.setString(3, marca);
                             st.setBigDecimal(4, preco);
                             st.executeUpdate();
                             out.print("Produto cadastrado com sucesso.");
                         }
                     }
                 }
             } catch (NumberFormatException e) {
                 out.print("Codigo ou preco invalido.");
             } catch (ClassNotFoundException e) {
                 out.print("Conector MySQL nao encontrado no aplicativo.");
             } catch (Exception e) {
                 out.print("Nao foi possivel salvar o produto.");
             }
         }
        %>
    </body>
</html>
