# CRUD de Produtos

Aplicacao web Java com JSP para cadastro de produtos em MySQL.

## Requisitos

- JDK 25 ou superior (LTS)
- Apache Tomcat 11
- MySQL 8
- Maven 3.9 ou superior

## Banco de dados

Execute `scripts/BancoETabelaProduto.sql` no MySQL. O script cria o schema e a tabela sem apagar dados existentes.

Crie um usuario da aplicacao que nao seja `root`, por exemplo:

```sql
CREATE USER IF NOT EXISTS 'crud_app'@'localhost' IDENTIFIED BY 'change-this-password';
GRANT SELECT, INSERT, UPDATE, DELETE ON banco.* TO 'crud_app'@'localhost';
```

## Configuracao

Informe as variaveis de ambiente antes de iniciar o Tomcat:

```text
DB_URL=jdbc:mysql://localhost:3306/banco?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
DB_USER=crud_app
DB_PASSWORD=change-this-password
```

No Windows PowerShell:

```powershell
$env:DB_URL="jdbc:mysql://localhost:3306/banco?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
$env:DB_USER="crud_app"
$env:DB_PASSWORD="change-this-password"
```

Nunca coloque estas credenciais no repositorio.

## Build

```powershell
mvn clean package
```

O WAR sera criado em `target/Site.war` e pode ser implantado no diretório `webapps` do Tomcat.

## Testes

Os testes cobrem validacoes e as operacoes CRUD com um banco H2 em memoria:

```powershell
mvn test
```
