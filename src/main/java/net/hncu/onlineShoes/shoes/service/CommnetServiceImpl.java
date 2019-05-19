package net.hncu.onlineShoes.shoes.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.Comment;
import net.hncu.onlineShoes.domain.CommentMapper;
import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailExample;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.util.SensitiveWordFilterUtil;

@Service("commnetService")
public class CommnetServiceImpl implements CommnetService {
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	

	@Override
	public String commitComment(Comment commnet) {
		if(commnet == null) {
			return "commnet == null";
		}
		Integer userId = commnet.getUserId();
		if(userId == null) {
			return "userId == null";
		}
		Integer orderDetailId = commnet.getOrderDetailId();
		if(orderDetailId == null) {
			return "orderDetailId == null";
		}
		//敏感词替换
		commnet.setContent(SensitiveWordFilterUtil.replaceSensitiveWord(commnet.getContent(), "[和谐]"));
		OrderDetailExample orderDetailExample = new OrderDetailExample();
		orderDetailExample.createCriteria()
			.andOrderDetailIdEqualTo(orderDetailId)
			.andUserIdEqualTo(userId);
		List<OrderDetail> ods = orderDetailMapper.selectByExample(orderDetailExample);
		if(ods.size() == 0) {
			return "没有相应的订单";
		}
		OrderDetail orderDetail = ods.get(0);
		Integer shoesId = orderDetail.getShoesId();
		int flag = orderDetail.getFlag();
		if(flag != OrderDetail.Flag.ACCEPTED && flag != OrderDetail.Flag.COMPLETE_TRANSACTION) {
			return "没有评论权限";
		}
		commnet.setShoesId(shoesId);
		commnet.setCreateTime( new Date() );
		commentMapper.insertSelective(commnet);
		orderDetail = new OrderDetail();
		orderDetail.setOrderDetailId(orderDetailId);
		orderDetail.setFlag(OrderDetail.Flag.EVALUATED);
		orderDetailMapper.updateByPrimaryKeySelective(orderDetail);
		return null;
	}

}
