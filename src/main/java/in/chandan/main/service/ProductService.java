package in.chandan.main.service;

import in.chandan.main.entity.Review;
import in.chandan.main.entity.User;
import in.chandan.main.repository.ReviewRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.chandan.main.entity.Product;
import in.chandan.main.repository.ProductRepo;

@Service
public class ProductService {
	
	@Autowired
	ProductRepo productRepo;

	@Autowired
	ReviewRepo reviewRepo;
	
	public void addProduct(Product product) {
		try {
			productRepo.save(product);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Product could not added");
		}
	}

	public void setRating(int productId, int rating, String reviewMsg, User user) {

		Product product = productRepo.findById(productId).get();

		Review previousReview = reviewRepo.findByUserAndProduct(user, product);

		if (previousReview != null) {
			if (rating == 0) rating = previousReview.getRating();
			float overallRating = product.getOverallRating();
			overallRating = (overallRating * product.getReviews().size() - previousReview.getRating() + rating)/ product.getReviews().size();
			float roundedOverallRating = (float) (Math.round(overallRating * 10.0) / 10.0);
			product.setOverallRating(roundedOverallRating);
			previousReview.setRating(rating);
			previousReview.setReview(reviewMsg);
			reviewRepo.save(previousReview);
		} else {
			Review review = new Review();
			review.setProduct(product);
			review.setRating(rating);
			review.setReview(reviewMsg);
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

	}

}
