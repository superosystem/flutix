package com.gusrylmubarok.spring.productservice.repository;

import com.gusrylmubarok.spring.productservice.model.Product;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProductRepository extends MongoRepository<Product, String> {
}
