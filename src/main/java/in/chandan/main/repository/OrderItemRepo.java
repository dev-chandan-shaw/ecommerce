package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.chandan.main.entity.OrderItem;

public interface OrderItemRepo extends JpaRepository<OrderItem, Integer> {

}
