package in.chandan.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.chandan.main.entity.MyOrder;
import java.util.List;
import in.chandan.main.entity.User;



public interface MyOrderRepo extends JpaRepository<MyOrder, Integer> {
	MyOrder findByOrderId(String orderId);
	List<MyOrder> findByUser(User user);
}
