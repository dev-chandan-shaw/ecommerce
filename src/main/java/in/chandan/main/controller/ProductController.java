package in.chandan.main.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import in.chandan.main.entity.Product;
import in.chandan.main.entity.Review;
import in.chandan.main.entity.User;
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
	public String openIndexPage() {
		return "index";
	}

	@GetMapping("/add-product-page")
	public String openAddProductPage() {
		return "addProduct";
	}
	
	@PostMapping("/add_product")
	public String addProduct(@ModelAttribute Product product, @RequestParam("image_add") String imgAdd)
	{
		product.setImageAdd(imgAdd);
		productService.addProduct(product);
		return "redirect:/home";
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
	
	
	@PostMapping("/updateQuantity")
	@ResponseBody
	public Map<String, Object> updateQuantity(@RequestBody Map<String, String> data, HttpSession session) {

		int cartItemId = Integer.parseInt( data.get("cartItemId"));
		int quantity = Integer.parseInt(data.get("quantity"));
		String quantityStatus = data.get("status");
		User user = (User) session.getAttribute("currentUser");

		System.out.println("Update the quantity");

		return userService.updateQuantity(quantity, cartItemId, quantityStatus, user);
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
	public Map<String, String> submitReview(@RequestBody Map<String, String> data, HttpSession session) {
		int productId = Integer.parseInt(data.get("productId"));
		int rating = Integer.parseInt(data.get("rating"));
		String reviewMsg = data.get("review");
		User user = (User) session.getAttribute("currentUser");
		productService.setRating(productId,rating,reviewMsg,user);
		return data;
	}
	
	@GetMapping("/product/search/{search}")
	@ResponseBody
	public List<Product> searchResult(@PathVariable String search){
		return productRepo.findByNameContaining(search);
	}
}
