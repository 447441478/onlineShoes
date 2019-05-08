package net.hncu.onlineShoes.user.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.ShoesItem;

@Service("shoesItemService")
public interface ShoesItemService {
	
	boolean updateShoesItems(List<ShoesItem> shoesItems);
}
