package in.chandan.main.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import in.chandan.main.entity.Cart;
import in.chandan.main.entity.CartItem;
import in.chandan.main.entity.Product;
import in.chandan.main.entity.User;
import in.chandan.main.repository.CartItemRepo;
import in.chandan.main.repository.CartRepo;
import in.chandan.main.repository.ProductRepo;
import in.chandan.main.repository.UserRepo;
import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	
	@Autowired
	UserRepo userRepo;
	@Autowired
	CartItemRepo cartItemRepo;
	@Autowired
	CartRepo cartRepo;
	@Autowired
	ProductRepo productRepo;
	
	@GetMapping("/cart")
	public String openCart(HttpSession session) {
		System.out.println("I am in the start of cart");
		User user = (User) session.getAttribute("currentUser");
		Cart cart = cartRepo.findById(user.getCart().getId()).get();
		session.setAttribute("cartItemList", cart.getCartItems());
		session.setAttribute("items", cart.getCartItems().size());
		if (cart.getCartItems().size() == 0) {
			return "emptyCart";
		}
		System.out.println("I am in the end of cart");
		return "cart";
	}
	
	@PostMapping("/add_to_cart")
	@ResponseBody
	public User addTocart(@RequestBody Map<String, Integer> data, HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		
		CartItem cartItem = new CartItem();
		Product product = productRepo.findById(data.get("productId")).get();
		
		cartItem.setProduct(product);
		cartItem.setQuantity(1);
		cartItem.setPrice(product.getPrice());
		cartItemRepo.save(cartItem);

		Cart cart = cartRepo.findById(user.getCart().getId()).get();
		
		List<CartItem> cartItems = cart.getCartItems();
		cartItems.add(cartItem);
		cart.setCartItems(cartItems);
		cartRepo.save(cart);
		return user;
	}
	
	@DeleteMapping("/deleteFromCart")
	public String deleteFromCart(
			@RequestParam("userId") String userId,
			@RequestParam("cartItemId") String cartItemId,
			HttpSession session)
	{
		System.out.println("Code is not working..........");
		User user = (User) session.getAttribute("currentUser");
		Cart cart = user.getCart();
		List<CartItem> cartItems = cart.getCartItems();
		for (int i=0 ; i<cartItems.size(); i++) {
			if (cartItems.get(i).getId() == Integer.parseInt(cartItemId)) {
				cartItems.remove(i);
				CartItem item = cartItemRepo.findById(Integer.parseInt(cartItemId)).get();
				item.setProduct(null);
				cartItemRepo.delete(item);
				System.out.println("Hello world");
			}
		}
	
		    
		cart.setCartItems(cartItems);
		cart.setUser(user);
		userRepo.save(user);
		cartRepo.save(cart);
		
		session.setAttribute("items", cartItems.size());
		
		return "redirect:/cart";
	}
	
	@DeleteMapping("/delete-cart-item")
	@ResponseBody
	public String deleteCartItem(@RequestBody Map<String, Integer> req) {
		CartItem cartItem = cartItemRepo.findById(req.get("cartItemId")).get();
		cartItemRepo.delete(cartItem);
		return "done";
	}
}
