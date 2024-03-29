package in.chandan.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.chandan.main.entity.Product;
import in.chandan.main.repository.ProductRepo;

@Service
public class ProductService {
	
	@Autowired
	ProductRepo productRepo;
	
	public boolean addProduct(Product product) {
		try {
			productRepo.save(product);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Product could not added");
			return false;
		}
	}

}
