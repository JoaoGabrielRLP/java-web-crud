<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileReader" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro via excel</title>
    </head>
    <body>
        <%
            String sql="";
            PreparedStatement st;
            try {
                //Conectar ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "root");

                //Ler o arquivo Excel
                FileReader arquivo = new FileReader("C:\\site\\produtos.csv");
                BufferedReader br = new BufferedReader(arquivo);
                String linha;

                //Se a linha lida do arquivo produtos.csv não estiver nula
                while ((linha = br.readLine()) != null) {
                    //Pegam os valores das linas do arquivo excel e joga em variáveis 
                    String[] dados = linha.split(",");
                    //Limpa o valor contido em dados[0] de caracteres ocultos
                    String cod = dados[0].replaceAll("[^0-9]", "");
                    int c = Integer.parseInt(cod);
                    String n = dados[1];
                    String m = dados[2];
                    double p = Double.parseDouble(dados[3]);
                    //Buscam pelo produto antes de inserir na tabela
                    sql = "SELECT * FROM produto WHERE codigo = ?";
                    st = conecta.prepareStatement(sql);
                    st.setInt(1, c);
                    ResultSet resultado = st.executeQuery(); //Executa o select
                    
                    if(!resultado.next()){//Se não encontrar o produto na tabela
                    
                   
                    
                    sql = "INSERT INTO produto values(?,?,?,?)"; // Prepara o comando insert
                    st = conecta.prepareStatement(sql);
                    st.setInt(1, c);
                    st.setString(2, n);
                    st.setString(3, m);
                    st.setDouble(4, p);

                    st.executeUpdate(); //Executa o comando insert
                    out.print(" O produto <b> " + c + " </b>foi cadastrado com sucesso <br>");
                } else {
                    out.print(" O produto <b> " + c + " </b> jáfoi cadastrado <br>");
                }
            } 
                br.close();
            } catch (Exception erro) {
                out.print("Entre em contato com o suporte e informe o erro: " + erro.getMessage());
            }
        %>
    </body>
</html>
