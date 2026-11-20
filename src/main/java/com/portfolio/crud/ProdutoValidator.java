package com.portfolio.crud;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public final class ProdutoValidator {
    private ProdutoValidator() {
    }

    public static List<String> validar(String codigoTexto, String nome,
                                       String marca, String precoTexto) {
        List<String> erros = new ArrayList<>();

        if (codigoTexto == null || codigoTexto.trim().isEmpty()) {
            erros.add("Informe o codigo do produto.");
        } else {
            try {
                int codigo = Integer.parseInt(codigoTexto.trim());
                if (codigo <= 0) {
                    erros.add("O codigo deve ser maior que zero.");
                }
            } catch (NumberFormatException exception) {
                erros.add("O codigo deve conter apenas numeros inteiros.");
            }
        }

        validarTexto("nome", nome, erros);
        validarTexto("marca", marca, erros);

        if (precoTexto == null || precoTexto.trim().isEmpty()) {
            erros.add("Informe o preco.");
        } else {
            try {
                BigDecimal preco = new BigDecimal(precoTexto.trim().replace(',', '.'));
                if (preco.compareTo(BigDecimal.ZERO) < 0) {
                    erros.add("O preco nao pode ser negativo.");
                } else if (preco.scale() > 2) {
                    erros.add("O preco deve ter no maximo duas casas decimais.");
                } else if (preco.compareTo(new BigDecimal("9999999999.99")) > 0) {
                    erros.add("O preco ultrapassa o limite permitido.");
                }
            } catch (NumberFormatException exception) {
                erros.add("O preco informado e invalido.");
            }
        }

        return erros;
    }

    private static void validarTexto(String campo, String valor, List<String> erros) {
        String nomeCampo = "nome".equals(campo) ? "nome" : "marca";
        if (valor == null || valor.trim().isEmpty()) {
            erros.add("Informe " + (nomeCampo.equals("nome") ? "o nome" : "a marca") + ".");
        } else if (valor.trim().length() > 50) {
            erros.add("O " + nomeCampo + " deve ter no maximo 50 caracteres.");
        }
    }
}
