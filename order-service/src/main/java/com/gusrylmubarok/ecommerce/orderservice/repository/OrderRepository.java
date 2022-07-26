package com.gusrylmubarok.ecommerce.orderservice.repository;

import com.gusrylmubarok.ecommerce.orderservice.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
