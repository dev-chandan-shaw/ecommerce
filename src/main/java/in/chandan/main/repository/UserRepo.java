package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.chandan.main.entity.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer>{
	User findByEmailAndPassword(String email, String password);
}
