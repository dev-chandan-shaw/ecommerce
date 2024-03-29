package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.chandan.main.entity.Address;
import java.util.List;
import in.chandan.main.entity.User;


public interface AddressRepo extends JpaRepository<Address, Integer>{
    List<Address> findByUser(User user);
}
