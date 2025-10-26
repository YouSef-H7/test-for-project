package com.burgerbuilder.controller;

import com.burgerbuilder.dto.IngredientDto;
import com.burgerbuilder.service.IngredientService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
@Slf4j
public class ProductController {
    
    private final IngredientService ingredientService;
    
    /**
     * Get all products (alias for ingredients)
     * This endpoint provides compatibility for any frontend/client expecting /api/products
     */
    @GetMapping
    public ResponseEntity<List<IngredientDto>> getAllProducts() {
        log.debug("GET /api/products - Fetching all products (ingredients)");
        List<IngredientDto> products = ingredientService.getAllIngredients();
        log.info("Retrieved {} products", products.size());
        return ResponseEntity.ok(products);
    }
    
    /**
     * Get products by category (alias for ingredients by category)
     */
    @GetMapping("/{category}")
    public ResponseEntity<List<IngredientDto>> getProductsByCategory(
            @PathVariable String category) {
        log.debug("GET /api/products/{} - Fetching products by category", category);
        List<IngredientDto> products = ingredientService.getIngredientsByCategory(category);
        log.info("Retrieved {} products for category: {}", products.size(), category);
        return ResponseEntity.ok(products);
    }
    
    /**
     * Get all product categories (alias for ingredient categories)
     */
    @GetMapping("/categories")
    public ResponseEntity<List<String>> getAllProductCategories() {
        log.debug("GET /api/products/categories - Fetching all product categories");
        List<String> categories = ingredientService.getAllCategories();
        log.info("Retrieved {} product categories", categories.size());
        return ResponseEntity.ok(categories);
    }
    
    /**
     * Get product by ID (alias for ingredient by ID)
     */
    @GetMapping("/id/{id}")
    public ResponseEntity<IngredientDto> getProductById(@PathVariable Long id) {
        log.debug("GET /api/products/id/{} - Fetching product by id", id);
        IngredientDto product = ingredientService.getIngredientById(id);
        log.info("Retrieved product with id: {}", id);
        return ResponseEntity.ok(product);
    }
    
    /**
     * Get product by name (alias for ingredient by name)
     */
    @GetMapping("/name/{name}")
    public ResponseEntity<IngredientDto> getProductByName(@PathVariable String name) {
        log.debug("GET /api/products/name/{} - Fetching product by name", name);
        IngredientDto product = ingredientService.getIngredientByName(name);
        log.info("Retrieved product with name: {}", name);
        return ResponseEntity.ok(product);
    }
}