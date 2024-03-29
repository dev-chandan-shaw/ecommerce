package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.chandan.main.entity.Product;
import in.chandan.main.entity.Review;
import in.chandan.main.entity.User;


public interface ReviewRepo extends JpaRepository<Review, Integer>{
	public Review findByUserAndProduct(User user, Product product);
}
