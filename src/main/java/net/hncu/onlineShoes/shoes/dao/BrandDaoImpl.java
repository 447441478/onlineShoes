package net.hncu.onlineShoes.shoes.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.hncu.onlineShoes.domain.Brand;
import net.hncu.onlineShoes.domain.BrandMapper;

@Repository("brandDao")
public class BrandDaoImpl implements BrandDAO {
	
	@Autowired
	private BrandMapper brandMapper;
	
	@Override
	public List<Brand> getBrands() {
		return brandMapper.selectByExample(null);
	}
	
	

}
