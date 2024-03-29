package in.chandan.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.chandan.main.entity.Product;

public interface ProductRepo extends JpaRepository<Product, Integer>{
	List<Product> findByCatagory(String catagory);
	Product findByName(String name);
	List<Product> findByNameContaining(String name);
}
