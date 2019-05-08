package net.hncu.onlineShoes.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemMapper;

@Service("shoesItemService")
public class ShoesItemServiceImpl implements ShoesItemService{
	@Autowired
	ShoesItemMapper shoesItemMapper;

	@Override
	public boolean updateShoesItems(List<ShoesItem> shoesItems) {
		if(shoesItems == null) 
			return false;
		try {
			for (ShoesItem shoesItem : shoesItems) {
				shoesItemMapper.updateByPrimaryKeySelective(shoesItem);
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}

}
