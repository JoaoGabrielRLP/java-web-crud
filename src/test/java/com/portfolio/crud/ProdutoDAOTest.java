package com.portfolio.crud;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ProdutoDAOTest {
    private static final String URL = "jdbc:h2:mem:crud;DB_CLOSE_DELAY=-1";
    private ProdutoDAO dao;

    @BeforeEach
    void configurarBanco() throws SQLException {
        dao = new ProdutoDAO(() -> DriverManager.getConnection(URL, "sa", ""));
        try (Connection connection = DriverManager.getConnection(URL, "sa", "");
             Statement statement = connection.createStatement()) {
            statement.execute("DROP TABLE IF EXISTS produto");
            statement.execute("CREATE TABLE produto ("
                    + "codigo INT PRIMARY KEY,"
                    + "nome VARCHAR(50) NOT NULL,"
                    + "marca VARCHAR(50) NOT NULL,"
                    + "preco DECIMAL(12,2) NOT NULL)");
        }
    }

    @Test
    void deveCriarBuscarAtualizarEExcluirProduto() throws SQLException {
        Produto produto = new Produto(
                1, "Notebook", "Acme", new BigDecimal("2499.90"));

        dao.criar(produto);

        Produto encontrado = dao.buscarPorCodigo(1);
        assertNotNull(encontrado);
        assertEquals("Notebook", encontrado.getNome());
        assertEquals(new BigDecimal("2499.90"), encontrado.getPreco());

        encontrado.setNome("Notebook Pro");
        encontrado.setMarca("Nova Marca");
        encontrado.setPreco(new BigDecimal("2799.90"));
        assertTrue(dao.atualizar(encontrado));

        Produto atualizado = dao.buscarPorCodigo(1);
        assertEquals("Notebook Pro", atualizado.getNome());
        assertEquals("Nova Marca", atualizado.getMarca());

        assertTrue(dao.excluir(1));
        assertNull(dao.buscarPorCodigo(1));
        assertFalse(dao.excluir(1));
    }

    @Test
    void deveListarEBuscarPorNome() throws SQLException {
        dao.criar(new Produto(10, "Mouse Gamer", "Acme", new BigDecimal("150.00")));
        dao.criar(new Produto(11, "Teclado", "Acme", new BigDecimal("220.00")));

        assertEquals(2, dao.listar().size());
        assertEquals(1, dao.buscarPorNome("mouse").size());
        assertTrue(dao.buscarPorNome("inexistente").isEmpty());
    }

    @Test
    void naoDeveCriarCodigoDuplicado() throws SQLException {
        dao.criar(new Produto(5, "Monitor", "Acme", new BigDecimal("900.00")));

        boolean duplicado = false;
        try {
            dao.criar(new Produto(5, "Outro", "Acme", new BigDecimal("100.00")));
        } catch (SQLException exception) {
            duplicado = true;
        }

        assertTrue(duplicado);
    }
}
