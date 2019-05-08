package net.hncu.onlineShoes.user.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemMapper;
import net.hncu.onlineShoes.domain.ShoesSizeMapper;

@Service("orderDetailService")
public class OrderDetailServiceImpl implements OrderDetailService{
	private static Logger logger = Logger.getLogger(OrderDetailServiceImpl.class);
	@Autowired
	OrderDetailMapper orderDetailMapper;
	
	@Autowired
	ShoesSizeMapper shoesSizeMapper;
	
	@Autowired
	ShoesItemMapper shoesItemMapper;
	
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	@Override
	public String addOrder(List<Map<String, Object>> order, OrderDetail srcOrderDetail) {
		if(order == null || srcOrderDetail == null)
			return "";
		try {
			for (Map<String, Object> map : order) {
				Integer buyNum = (Integer) map.get(SearchField.OrderDef.BUY_NUM);
				Integer shoesId = (Integer) map.get(SearchField.OrderDef.SHOES_ID);
				Integer shoesSizeId = (Integer) map.get(SearchField.OrderDef.SHOES_SIZE_ID);
				
				Integer one = shoesSizeMapper.select4update(shoesId, shoesSizeId, buyNum);
				if(one == null || one == 0) {
					throw new RuntimeException("库存不足,交易失败");
				}
				int i = shoesSizeMapper.update(shoesId, shoesSizeId, buyNum);
				logger.info("i="+i);
				
				OrderDetail orderDetail = srcOrderDetail.deepClone();
				orderDetail.setShoesId(shoesId);
				double price = ((BigDecimal) map.get(SearchField.OrderDef.OUT_PRICE)).doubleValue();
				double ratio = ((BigDecimal) map.get(SearchField.OrderDef.RATIO)).doubleValue();
				if(ratio < 100) {
					price *= ratio / 100;
				}
				orderDetail.setPrice(new BigDecimal(price).setScale(2,BigDecimal.ROUND_HALF_UP));
				orderDetail.setAmount(buyNum);
				orderDetail.setShoesSize((BigDecimal)map.get(SearchField.OrderDef.SIZE));
				orderDetail.setFlag(OrderDetail.Flag.INIT);
				orderDetailMapper.insertSelective(orderDetail);
				ShoesItem shoesItem = new ShoesItem();
				shoesItem.setShoesId(shoesId);
				shoesItem.setShoesSizeId(shoesSizeId);
				shoesItem.setUserId(orderDetail.getUserId());
				shoesItem.setAmount(0);
				shoesItem.setFlag(ShoesItem.Flag.DEL);
				shoesItemMapper.updateByPrimaryKeySelective(shoesItem);
			}
			return "订单完成";
		} catch (ClassNotFoundException | CloneNotSupportedException | IOException e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		
	}
	

}
