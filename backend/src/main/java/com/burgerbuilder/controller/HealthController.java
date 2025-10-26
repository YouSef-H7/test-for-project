package com.burgerbuilder.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
@Slf4j
public class HealthController {
    
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() {
        log.debug("GET /api/health - Health check requested");
        
        Map<String, Object> healthStatus = new HashMap<>();
        healthStatus.put("status", "UP");
        healthStatus.put("timestamp", LocalDateTime.now());
        healthStatus.put("service", "burger-builder-backend");
        healthStatus.put("version", "1.0.0");
        
        return ResponseEntity.ok(healthStatus);
    }
    
    @GetMapping("/endpoints")
    public ResponseEntity<Map<String, Object>> availableEndpoints() {
        log.debug("GET /api/endpoints - Available endpoints requested");
        
        Map<String, Object> endpoints = new HashMap<>();
        endpoints.put("health", "/api/health");
        endpoints.put("products", "/api/products");
        endpoints.put("ingredients", "/api/ingredients");
        endpoints.put("cart", "/api/cart");
        endpoints.put("orders", "/api/orders");
        endpoints.put("actuator_health", "/actuator/health");
        endpoints.put("actuator_mappings", "/actuator/mappings");
        endpoints.put("timestamp", LocalDateTime.now());
        
        return ResponseEntity.ok(endpoints);
    }
}
