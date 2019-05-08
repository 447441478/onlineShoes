package net.hncu.onlineShoes.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.OrderDetail;

@Service("orderDetailService")
public interface OrderDetailService {
	
	String addOrder(List<Map<String, Object>> order, OrderDetail srcOrderDetail);
}
