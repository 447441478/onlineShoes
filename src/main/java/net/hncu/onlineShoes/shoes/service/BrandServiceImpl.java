package net.hncu.onlineShoes.shoes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.Brand;
import net.hncu.onlineShoes.shoes.dao.BrandDAO;

@Service("brandService")
public class BrandServiceImpl implements BrandService{
	
	@Autowired
	private BrandDAO brandDao;
	
	@Override
	public List<Brand> getBrands() {
		return brandDao.getBrands();
	}


}
