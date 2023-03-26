## Introduction
This README file explains how to use the [Postgres R2DBC](https://r2dbc.io/) driver in a Spring Boot project. The Postgres R2DBC driver is a wrapper that allows you to use the Postgres database with Reactive Streams in Spring Boot.

### Requirements
Before you begin, make sure you have the following:

<ul>
  <li>A Postgres database installed on your system</li>
  <li>JDK 11 or higher</li>
  <li>Spring Boot 2.4.0 or higher</li>
</ul>

### Step 1: Add the Postgres R2DBC Dependency
To use the Postgres R2DBC driver in your Spring Boot project, you need to add the following dependency to your `build.gradle` or `pom.xml` file:

Maven:

```xml
<dependency>
    <groupId>io.r2dbc</groupId>
    <artifactId>r2dbc-postgresql</artifactId>
    <version>0.9.0.RELEASE</version>
</dependency>
```

Gradle:

```groovy
implementation 'io.r2dbc:r2dbc-postgresql:0.9.0.RELEASE'
```

### Step 2: Configure the Database Connection
To configure the database connection, you need to create a new configuration class in your Spring Boot project.

```java
@Configuration
public class DatabaseConfiguration {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Value("${spring.datasource.driver-class-name}")
    private String driverClassName;

    @Bean
    public ConnectionFactory connectionFactory() {
        return new PostgresqlConnectionFactory(
        // Replace the credentials, host, port and database name specific to your system.
                PostgresqlConnectionConfiguration.builder()
                        .host("localhost")
                        .port(5432)
                        .database("linux_dutt_db") 
                        .username(username)
                        .password(password)
                        .build()
        );
    }

    @Bean
    public DatabaseClient databaseClient(ConnectionFactory connectionFactory) {
        return DatabaseClient.builder()
                .connectionFactory(connectionFactory)
                .build();
    }
}
```

The `connectionFactory()` method creates a new `PostgresqlConnectionFactory` object and passes in the connection details for your database. The `databaseClient()` method creates a new `DatabaseClient` object and passes in the `ConnectionFactory` object.

### Step 3: Use the DatabaseClient
Now that you have configured the database connection, you can use the `DatabaseClient` object to execute queries and interact with the database. Here is an example:
```java
@Service
public class EntityService {

    private final DatabaseClient databaseClient;

    public EntityService(DatabaseClient databaseClient) {
        this.databaseClient = databaseClient;
    }

    public Flux<Entity> findAll() {
        return databaseClient.select()
                .from("entity")
                .as(Entity.class)
                .fetch()
                .all();
    }

    public Mono<Entity> findById(Long id) {
        return databaseClient.select()
                .from("entity")
                .as(Entity.class)
                .matching(Criteria.where("id").is(id))
                .fetch()
                .one();
    }

    public Mono<Entity> save(MyEntity myEntity) {
        return databaseClient.insert()
                .into(Entity.class)
                .using(entity)
                .fetch()
                .one();
    }

    public Mono<Void> deleteById(Long id) {
        return databaseClient.delete()
                .from(Entity.class)
                .matching(Criteria.where("id").is(id))
                .fetch()
                .rowsUpdated()
                .then();
    }
}
```







