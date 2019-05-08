package net.hncu.onlineShoes.shoes.dao;

import java.util.List;

import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesExample;

public interface ShoesDAO {
	
	String addProduct(Shoes shoes);
	List<Shoes> getShoesListByBrandId(Integer brandId);
	List<Shoes> getAll();
	List<Shoes> getShoesListByExample(ShoesExample shoesExample);
}
