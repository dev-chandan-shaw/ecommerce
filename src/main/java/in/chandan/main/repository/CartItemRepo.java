package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.chandan.main.entity.CartItem;
import in.chandan.main.entity.Product;


@Repository
public interface CartItemRepo extends JpaRepository<CartItem, Integer>{
	
}
