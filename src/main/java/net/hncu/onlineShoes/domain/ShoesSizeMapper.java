package net.hncu.onlineShoes.domain;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface ShoesSizeMapper {
	String TABLE_NAME = "shoessize";
	
    long countByExample(ShoesSizeExample example);

    int deleteByExample(ShoesSizeExample example);

    int deleteByPrimaryKey(Integer shoesSizeId);

    int insert(ShoesSize record);
    
    int insertList(List<ShoesSize> records);
    
    int insertSelective(ShoesSize record);

    List<ShoesSize> selectByExample(ShoesSizeExample example);
    //带Shoes信息的查询
    List<ShoesSize> selectWithShoesByExample(ShoesSizeExample example);

    ShoesSize selectByPrimaryKey(Integer shoesSizeId);

    int updateByExampleSelective(@Param("record") ShoesSize record, @Param("example") ShoesSizeExample example);

    int updateByExample(@Param("record") ShoesSize record, @Param("example") ShoesSizeExample example);

    int updateByPrimaryKeySelective(ShoesSize record);

    int updateByPrimaryKey(ShoesSize record);
    
    @Select("select shoes_id FROM "+ TABLE_NAME +" GROUP BY shoes_id order by ${orderByClause};")
	List<Integer> selectShoesIdsByStock(@Param("orderByClause") String orderByClause);
    
    @Select("select shoes_size_id from "+ TABLE_NAME +" where shoes_id = ${shoesId};")
	List<Integer> getShoesSizeIds(@Param("shoesId") Integer shoesId);
    
    @Select("select count(1) from "+ TABLE_NAME +
    		" where shoes_id = ${shoesId} " + 
    		" and shoes_size_id = ${shoesSizeId} and amount >= ${amount} for update;")
    Integer select4update(@Param("shoesId") Integer shoesId, @Param("shoesSizeId") Integer shoesSizeId, @Param("amount") Integer amount);
    
    @Update("update "+ TABLE_NAME +" set amount = amount - ${amount} " +
    		" where shoes_id = ${shoesId} " + 
    		" and shoes_size_id = ${shoesSizeId};")
    Integer update(@Param("shoesId") Integer shoesId, @Param("shoesSizeId") Integer shoesSizeId, @Param("amount") Integer amount);
    
}