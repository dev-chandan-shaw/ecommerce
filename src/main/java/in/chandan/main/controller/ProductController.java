package in.chandan.main.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

import in.chandan.main.entity.Address;
import in.chandan.main.entity.Cart;
import in.chandan.main.entity.CartItem;
import in.chandan.main.entity.MyOrder;
import in.chandan.main.entity.OrderItem;
import in.chandan.main.entity.Product;
import in.chandan.main.entity.Review;
import in.chandan.main.entity.User;
import in.chandan.main.repository.AddressRepo;
import in.chandan.main.repository.CartItemRepo;
import in.chandan.main.repository.CartRepo;
import in.chandan.main.repository.MyOrderRepo;
import in.chandan.main.repository.OrderItemRepo;
import in.chandan.main.repository.ProductRepo;
import in.chandan.main.repository.ReviewRepo;
import in.chandan.main.repository.UserRepo;
import in.chandan.main.service.ProductService;
import in.chandan.main.service.UserService;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {
	@Autowired
	ProductRepo productRepo;
	
	@Autowired
	ReviewRepo reviewRepo;
	
	@Autowired
	CartRepo cartRepo;
	
	@Autowired
	CartItemRepo cartItemRepo;
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	
	
	@GetMapping("/")
	public String indexPage() {
		return "redirect:/home";
	}
	
	@GetMapping("/home")
	public String openIndexPage(HttpSession session) {
		return "index";
	}
	
	@GetMapping("/add-product-page")
	public String openAddProductPage() {
		return "addProduct";
	}
	
	@PostMapping("/add_product")
	public String addProduct(
								@RequestParam("name") String name,
								@RequestParam("image_add") String imageAdd,
								@RequestParam("mrp") int mrp,
								@RequestParam("price") int price,
								@RequestParam("stock") int stock,
								@RequestParam("catagory") String catagory
							 )
	{
		Product product = new Product();
		product.setImageAdd(imageAdd);
		product.setName(name);
		product.setMrp(mrp);
		product.setPrice(price);
		product.setStock(stock);
		product.setCatagory(catagory);
		try {
			productService.addProduct(product);
			return "redirect:/home";
		} catch (Exception e) {
			return "error";
		}
	}
	
	@GetMapping("/catagories/{category}")
	public String openCategoryPage(@PathVariable String category,HttpSession session) {
		List<Product> productList = productRepo.findByCatagory(category);
		session.setAttribute("catagoryProducts", productList);
		if(productList.size() == 0) {
			return "redirect:/home";
		}
		return "catagory-products";
	}
	
	@GetMapping("/product/{name}/")
	public String openProductDetailsPage(@PathVariable String name, HttpSession session) {
		System.out.println("My product name is : " + name);
		Product product = productRepo.findByName(name);
		session.setAttribute("clicked_product", product);
		return "product-details"; 
	}

	
	@PostMapping("/add_review")
	public Review addReview(
							@RequestParam("review_msg") String reviewMsg, 
							@RequestParam("rating") int rating,
							@RequestParam("product_id") int productId,
							@RequestParam("user_id") int userId
			) {
		Product product = productRepo.findById(productId).get();
		User user = userRepo.findById(userId).get();
		Review review = new Review();
		review.setReview(reviewMsg);
		review.setProduct(product);
		review.setRating(rating);
		review.setUser(user);
		reviewRepo.save(review);
		
		int totalReviews = product.getReviews().size();
		float overallRating = ((product.getOverallRating() * (totalReviews - 1) + rating) / totalReviews);
		float roundedOverallRating = (float) (Math.round(overallRating * 10.0) / 10.0);
		product.setOverallRating(roundedOverallRating);
		productRepo.save(product);
		
		return review;
	}
	
	
	@PostMapping("/updateQuantity")
	@ResponseBody
	public Map<String, Object> updateQuantity(@RequestBody Map<String, Object> data, HttpSession session) {
		int cartItemId = Integer.parseInt( data.get("cartItemId").toString());
		int quantity = Integer.parseInt(data.get("quantity").toString());
		String quantityStatus = data.get("status").toString();
		Map<String, Object> response = userService.updateQuantity(quantity, cartItemId, quantityStatus);
		
		User user = (User) session.getAttribute("currentUser");
		Cart cart = user.getCart();
		
		List<CartItem> cartItems = cart.getCartItems();

		for (CartItem cartItem : cartItems) {
			if (cartItem.getId() == cartItemId) {
				cartItem.setQuantity(Integer.parseInt(response.get("quantity").toString()));
				cartItem.setPrice((int) response.get("amount"));
				cartItemRepo.save(cartItem);
			}
		}
		cart.setCartItems(cartItems);
		cartRepo.save(cart);
		
		return response;
	}

	
	@GetMapping("/review_and_rating/{productId}")
	public String openReviewForm(@PathVariable("productId") int productId, HttpSession session) {
	    Product product = productRepo.findById(productId).get();
	    session.setAttribute("reviewProduct", product);
	    return "redirect:/add-review";
	}
	
	@GetMapping("/add-review")
	public String addReview(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		Product product = (Product) session.getAttribute("reviewProduct");
		Review review = reviewRepo.findByUserAndProduct(user,product);
		session.setAttribute("previousReview", review);
		return "add-review";
	}
	
	
	@PostMapping("/submitReview")
	@ResponseBody
	public Map<String, Object> submitReview(@RequestBody Map<String, Object> data, HttpSession session) {
		int productId = Integer.parseInt(data.get("productId").toString());
		int rating = Integer.parseInt(data.get("rating").toString());
		Product product = productRepo.findById(productId).get();

		User user = (User) session.getAttribute("currentUser");
		
		Review previousReview = reviewRepo.findByUserAndProduct(user, product); 
		
		if (previousReview != null) {
			float overallRating = product.getOverallRating();
			overallRating = (overallRating * product.getReviews().size() - previousReview.getRating() + rating)/ product.getReviews().size();
			float roundedOverallRating = (float) (Math.round(overallRating * 10.0) / 10.0);
			product.setOverallRating(roundedOverallRating);
			previousReview.setRating(rating);
			previousReview.setReview(data.get("review").toString());
			reviewRepo.save(previousReview);
		} else {
			Review review = new Review();
			review.setProduct(product);
			review.setRating(rating);
			review.setReview(data.get("review").toString());
			review.setUser(user);
			float overallRating;
			if (product.getOverallRating() == 0) {
				overallRating = rating;
			} else {
				overallRating = (float) (product.getOverallRating() + rating)/2;
			}
			float roundedOverallRating = (float) (Math.round(overallRating * 10.0) / 10.0);
			product.setOverallRating(roundedOverallRating);
			reviewRepo.save(review);
		}
		
		productRepo.save(product);
		return data;
	}
	
	@GetMapping("/product/search/{search}")
	@ResponseBody
	public List<Product> searchResult(@PathVariable String search){
		return productRepo.findByNameContaining(search);
	}
}
