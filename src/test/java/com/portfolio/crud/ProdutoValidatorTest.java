package com.portfolio.crud;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.Test;

class ProdutoValidatorTest {
    @Test
    void deveAceitarDadosValidos() {
        List<String> erros = ProdutoValidator.validar(
                "12", "Mouse", "Acme", "99,90");

        assertTrue(erros.isEmpty());
    }

    @Test
    void deveRejeitarCamposVazios() {
        List<String> erros = ProdutoValidator.validar("", "", "", "");

        assertFalse(erros.isEmpty());
        assertTrue(erros.size() >= 4);
    }

    @Test
    void deveRejeitarCodigoPrecoETextoInvalidos() {
        String nomeMuitoGrande = "x".repeat(51);
        List<String> erros = ProdutoValidator.validar(
                "-1", nomeMuitoGrande, "Acme", "-10");

        assertTrue(erros.stream().anyMatch(erro -> erro.contains("codigo")));
        assertTrue(erros.stream().anyMatch(erro -> erro.contains("nome")));
        assertTrue(erros.stream().anyMatch(erro -> erro.contains("preco")));
    }
}
