package in.chandan.main.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import in.chandan.main.entity.Cart;
import in.chandan.main.repository.CartRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import in.chandan.main.entity.CartItem;
import in.chandan.main.entity.Product;
import in.chandan.main.entity.User;
import in.chandan.main.repository.CartItemRepo;
import in.chandan.main.repository.UserRepo;

import javax.servlet.http.HttpSession;

@Service
public class UserService {
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	CartItemRepo cartItemRepo;

	@Autowired
	CartRepo cartRepo;
	
	public void signUpUser(User user) {
		try {
			userRepo.save(user);
			Cart cart = new Cart();
			cart.setUser(user);
			cartRepo.save(cart);
			System.out.println("User registered successfully...");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Failed to register user!!!");
		}
	}
	
	public User signInUser(String email, String password) {
		User user = null;
		try {
			user = userRepo.findByEmailAndPassword(email, password);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Bad credential");
		}
		return user;
	}
	
	public Map<String, Object> updateQuantity(int quantity, int cartItemId, String updateStatus, User user) {
		// TODO Auto-generated method stub
		Map<String, Object> response = new HashMap<>();
		CartItem cartItem = cartItemRepo.findById(cartItemId).get();
		Product product = cartItem.getProduct();
		
		// run when user want to decrement quantity
		if (updateStatus.equals("decrement")) {
			if (quantity > 1) {
				quantity -= 1;
				response.put("msg", "You have changed '" + product.getName() + "' QUANTITY to '" + Integer.toString(quantity) +"'");
			} else {
				response.put("msg", "Minimum QUANTITY of each item is '1'");
			}
		} else {
			int maxQuantity = 200000/product.getPrice();
			System.out.println(maxQuantity);
			if (quantity <= 4 && maxQuantity > quantity) {
				quantity += 1;
				response.put("msg", "You have changed '" + product.getName() + "' QUANTITY to '" + Integer.toString(quantity) +"'");
			} else if (quantity >=5) {
				response.put("msg", "You can buy only up to '5' units of each item");
			} else {
				response.put("msg", "You can buy only up to '" +quantity+ "' units of '" + product.getName() + "'");
			}
		}

		// below code will run for increment quantity

		response.put("quantity", quantity);
		response.put("amount", (quantity)*product.getPrice());


		// Setting values in the database

		cartItem.setQuantity(quantity);
		cartItem.setPrice((quantity)*product.getPrice());
		cartItemRepo.save(cartItem);

		System.out.println(response);
		return response;
	}
}
