package com.gusrylmubarok.spring.productservice.service;

import com.gusrylmubarok.spring.productservice.dto.ProductRequest;
import com.gusrylmubarok.spring.productservice.model.Product;
import com.gusrylmubarok.spring.productservice.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductRepository productRepository;

    public void createProduct(ProductRequest productRequest) {
        Product product = Product.builder()
                .name(productRequest.getName())
                .description(productRequest.getDescription())
                .price(productRequest.getPrice())
                .build();
        productRepository.save(product);
        log.info("Product {} is saved.", product.getName());
    }
}
