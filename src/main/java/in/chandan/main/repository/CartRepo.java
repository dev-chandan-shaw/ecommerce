package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.chandan.main.entity.Cart;

@Repository
public interface CartRepo extends JpaRepository<Cart, Integer>{

}
