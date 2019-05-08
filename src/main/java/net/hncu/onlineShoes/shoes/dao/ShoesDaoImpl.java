package net.hncu.onlineShoes.shoes.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesExample;
import net.hncu.onlineShoes.domain.ShoesMapper;

@Repository("shoesDao")
public class ShoesDaoImpl implements ShoesDAO{
	
	@Autowired
	private ShoesMapper shoesMapper;
	
	@Override
	public String addProduct(Shoes shoes) {
		int insert = shoesMapper.insertSelective(shoes);
		return insert+"";
	}
	
	@Override
	public List<Shoes> getShoesListByBrandId(Integer brandId) {
		ShoesExample shoesExample = new ShoesExample();
		ShoesExample.Criteria criteria = shoesExample.createCriteria();
		criteria.andBrandIdEqualTo(brandId);
		criteria.andStockOutEqualTo(Shoes.StockOut.UP);
		return shoesMapper.selectByExample(shoesExample);
	}

	@Override
	public List<Shoes> getAll() {
		return shoesMapper.selectByExample(null);
	}

	@Override
	public List<Shoes> getShoesListByExample(ShoesExample shoesExample) {
		return shoesMapper.selectByExample(shoesExample);
	}

}
