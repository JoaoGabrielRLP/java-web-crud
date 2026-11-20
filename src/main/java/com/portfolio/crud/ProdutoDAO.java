package com.portfolio.crud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
    private final ConnectionFactory connectionFactory;

    public ProdutoDAO() {
        this(Database::getConnection);
    }

    public ProdutoDAO(ConnectionFactory connectionFactory) {
        this.connectionFactory = connectionFactory;
    }

    public void criar(Produto produto) throws SQLException {
        String sql = "INSERT INTO produto (codigo, nome, marca, preco) VALUES (?, ?, ?, ?)";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            preencher(statement, produto);
            statement.executeUpdate();
        }
    }

    public boolean atualizar(Produto produto) throws SQLException {
        String sql = "UPDATE produto SET nome = ?, marca = ?, preco = ? WHERE codigo = ?";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, produto.getNome());
            statement.setString(2, produto.getMarca());
            statement.setBigDecimal(3, produto.getPreco());
            statement.setInt(4, produto.getCodigo());
            return statement.executeUpdate() == 1;
        }
    }

    public boolean excluir(int codigo) throws SQLException {
        String sql = "DELETE FROM produto WHERE codigo = ?";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, codigo);
            return statement.executeUpdate() == 1;
        }
    }

    public Produto buscarPorCodigo(int codigo) throws SQLException {
        String sql = "SELECT codigo, nome, marca, preco FROM produto WHERE codigo = ?";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, codigo);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? lerProduto(result) : null;
            }
        }
    }

    public List<Produto> listar() throws SQLException {
        String sql = "SELECT codigo, nome, marca, preco FROM produto ORDER BY codigo";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            List<Produto> produtos = new ArrayList<>();
            while (result.next()) {
                produtos.add(lerProduto(result));
            }
            return produtos;
        }
    }

    public List<Produto> buscarPorNome(String nome) throws SQLException {
        String sql = "SELECT codigo, nome, marca, preco FROM produto "
                + "WHERE LOWER(nome) LIKE LOWER(?) ORDER BY nome, codigo";
        try (Connection connection = connectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + nome + "%");
            try (ResultSet result = statement.executeQuery()) {
                List<Produto> produtos = new ArrayList<>();
                while (result.next()) {
                    produtos.add(lerProduto(result));
                }
                return produtos;
            }
        }
    }

    private void preencher(PreparedStatement statement, Produto produto) throws SQLException {
        statement.setInt(1, produto.getCodigo());
        statement.setString(2, produto.getNome());
        statement.setString(3, produto.getMarca());
        statement.setBigDecimal(4, produto.getPreco());
    }

    private Produto lerProduto(ResultSet result) throws SQLException {
        return new Produto(
                result.getInt("codigo"),
                result.getString("nome"),
                result.getString("marca"),
                result.getBigDecimal("preco"));
    }
}
