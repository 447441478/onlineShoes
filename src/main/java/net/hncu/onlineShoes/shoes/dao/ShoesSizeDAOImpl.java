package net.hncu.onlineShoes.shoes.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import net.hncu.onlineShoes.domain.ShoesSize;
import net.hncu.onlineShoes.domain.ShoesSizeMapper;

@Repository("shoesSizeDao")
public class ShoesSizeDAOImpl implements ShoesSizeDAO{
	@Resource
	private ShoesSizeMapper shoesSizeMapper;
	
	@Override
	public String addShoesSizes(List<ShoesSize> shoesSizes) {
		return shoesSizeMapper.insertList(shoesSizes)+"";
	}

}
