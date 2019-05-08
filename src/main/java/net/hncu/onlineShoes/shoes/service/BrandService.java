package net.hncu.onlineShoes.shoes.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.Brand;

@Service("brandService")
public interface BrandService {
	
	List<Brand> getBrands();
}
