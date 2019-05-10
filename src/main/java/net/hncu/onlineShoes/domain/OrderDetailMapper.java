package net.hncu.onlineShoes.domain;

import java.util.List;
import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailExample;
import org.apache.ibatis.annotations.Param;

public interface OrderDetailMapper {
    long countByExample(OrderDetailExample example);

    int deleteByExample(OrderDetailExample example);

    int deleteByPrimaryKey(Integer orderDetailId);

    int insert(OrderDetail record);

    int insertSelective(OrderDetail record);

    List<OrderDetail> selectByExample(OrderDetailExample example);

    List<OrderDetail> selectByExampleWithShoes(OrderDetailExample example);
    
    OrderDetail selectByPrimaryKey(Integer orderDetailId);
    
    OrderDetail selectByPrimaryKeyWithShoes(Integer orderDetailId);

    int updateByExampleSelective(@Param("record") OrderDetail record, @Param("example") OrderDetailExample example);

    int updateByExample(@Param("record") OrderDetail record, @Param("example") OrderDetailExample example);

    int updateByPrimaryKeySelective(OrderDetail record);

    int updateByPrimaryKey(OrderDetail record);
    
    
}