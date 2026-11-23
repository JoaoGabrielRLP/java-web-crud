# CRUD de Produtos

Aplicação web Java com JSP para demonstrar um CRUD completo de produtos com persistência em PostgreSQL. O banco pode ser executado localmente com Docker Compose ou hospedado no Supabase.

## Tecnologias

- Java 17, JSP e Apache Tomcat 11
- PostgreSQL (Supabase ou local)
- Maven
- JUnit 5 e H2 para testes

## Pré-requisitos

- JDK 17 e Maven 3.9 ou superior
- PostgreSQL local ou um projeto Supabase
- Docker Desktop, para usar Docker Compose

## Configurar PostgreSQL/Supabase

No Supabase, crie um projeto e abra **Connect**. Para o DBeaver, crie uma conexão **PostgreSQL** usando os dados fornecidos. Se a conexão direta não estiver disponível na sua rede, selecione **Session pooler** no painel. Habilite SSL/TLS (**Require**) e teste a conexão.

O banco `postgres` e o schema `public` já existem no Supabase. Conectado ao banco, execute `scripts/BancoETabelaProduto.sql` para criar `public.produto`. Opcionalmente, execute `scripts/DadosDemonstracao.sql` para adicionar cinco produtos fictícios.

Configure a aplicação com `DB_URL`, `DB_USER` e `DB_PASSWORD`. Exemplo local:

```text
DB_URL=jdbc:postgresql://localhost:5432/banco
DB_USER=crud_app
DB_PASSWORD=sua-senha-local
```

No PowerShell, configure essas variáveis na mesma janela em que iniciará o Tomcat:

```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/banco"
$env:DB_USER="crud_app"
$env:DB_PASSWORD="sua-senha-local"
```

Para Supabase, use os dados da seção **Connect**. Com o **Session pooler**, o formato é:

```text
DB_URL=jdbc:postgresql://<HOST_DO_POOLER>:5432/postgres?sslmode=require
DB_USER=postgres.<PROJECT_REF>
DB_PASSWORD=<SENHA_DO_BANCO>
```

O nome de usuário e o host podem variar conforme a opção de conexão escolhida; copie os dados do painel. Não use `localhost` para conectar ao Supabase. Nunca versione credenciais nem compartilhe sua senha do banco. `.env.example` serve como referência do Compose; o Tomcat iniciado fora do Docker não carrega esse arquivo automaticamente.

## Build e execução local

1. Configure as variáveis de ambiente para o PostgreSQL.
2. Gere o WAR:

```powershell
mvn clean package
```

3. Copie `target/Site.war` para `webapps` do Tomcat e inicie o servidor.
4. Acesse `http://localhost:8080/Site/`.

## Dados de demonstração

O script `scripts/DadosDemonstracao.sql` pode ser executado novamente: ele atualiza apenas os códigos fictícios `1001` a `1005`, sem apagar outros registros. Para remover esses produtos:

```sql
DELETE FROM public.produto
WHERE codigo BETWEEN 1001 AND 1005;
```

## Testes

```powershell
mvn test
```

Os testes CRUD usam H2 em memória e não precisam de uma instância PostgreSQL.

## Execução com Docker Compose

O Compose inicia a aplicação e um PostgreSQL local. O volume `postgres_data` mantém os dados entre reinicializações.

1. Copie `.env.example` para `.env` e altere `POSTGRES_PASSWORD`.
2. Gere o WAR:

```powershell
mvn clean package
```

3. Inicie os serviços e acesse `http://localhost:8080/Site/`:

```powershell
docker compose up --build -d
```

4. Confira os serviços e logs:

```powershell
docker compose ps
docker compose logs app
```

Para carregar os produtos fictícios:

```powershell
Get-Content scripts/DadosDemonstracao.sql -Raw | docker compose exec -T postgres psql -U crud_app -d banco
```

Para encerrar sem remover os dados:

```powershell
docker compose down
```

Para remover também os dados persistidos, use `docker compose down -v`.

## Fluxo de demonstração

1. Abra a página inicial.
2. Cadastre um produto ou use os dados de demonstração.
3. Confira a listagem e pesquise pelo nome.
4. Edite o produto e confirme a alteração.
5. Exclua o produto de teste.

## Estrutura principal

- `web/` - páginas HTML/JSP e estilos
- `src/main/java/com/portfolio/crud/` - conexão JDBC e operações de dados
- `src/test/java/com/portfolio/crud/` - testes automatizados
- `scripts/` - criação da tabela e dados fictícios
