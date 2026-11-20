package com.portfolio.crud;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Database {
    private Database() {
    }

    public static Connection getConnection() throws SQLException {
        String url = getRequiredEnvironment("DB_URL");
        String user = getRequiredEnvironment("DB_USER");
        String password = getRequiredEnvironment("DB_PASSWORD");
        return DriverManager.getConnection(url, user, password);
    }

    private static String getRequiredEnvironment(String name) {
        String value = System.getenv(name);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalStateException("Variavel de ambiente nao configurada: " + name);
        }
        return value.trim();
    }
}
