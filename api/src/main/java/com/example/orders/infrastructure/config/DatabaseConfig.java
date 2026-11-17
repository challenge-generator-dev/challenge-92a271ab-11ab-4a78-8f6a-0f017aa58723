// TODO(reto): archivo stubbeado; implementa los cuerpos.
package com.example.orders.infrastructure.config;

import jakarta.validation.constraints.NotBlank;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

@Validated
@ConfigurationProperties(prefix = "database")
public class DatabaseConfig {

    @NotBlank(message = "El endpoint de la base de datos no puede estar vacío")
    private String endpoint;

    @NotBlank(message = "El password de la base de datos no puede estar vacío")
    private String password;

    public DatabaseConfig() {
    }

    public DatabaseConfig(String endpoint, String password) {
        this.endpoint = endpoint;
        this.password = password;
    }

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void validate() {
      throw new UnsupportedOperationException("TODO(reto): validate");
    }
}