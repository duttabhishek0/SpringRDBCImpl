package org.example;

import io.r2dbc.postgresql.PostgresqlConnectionFactory;
import io.r2dbc.spi.ConnectionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.r2dbc.config.EnableR2dbcRepositories;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcAuditing;

@Configuration
@EnableR2dbcAuditing
@EnableR2dbcRepositories(basePackages = "com.example.repository")
public class PostgresqlConfiguration {

    @Bean
    public ConnectionFactory connectionFactory() {
        return new PostgresqlConnectionFactory(PostgresqlConnectionConfiguration.builder()
                .host("localhost")
                .database("linux_dutt_db")
                .username("my_username")
                .password("my_password")
                .build());
    }
}
