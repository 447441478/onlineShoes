package net.hncu.onlineShoes.domain;

import java.util.List;
import java.util.Map;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemExample;
import net.hncu.onlineShoes.domain.ShoesItemKey;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface ShoesItemMapper {
    long countByExample(ShoesItemExample example);

    int deleteByExample(ShoesItemExample example);

    int deleteByPrimaryKey(ShoesItemKey key);

    int insert(ShoesItem record);

    int insertSelective(ShoesItem record);

    List<ShoesItem> selectByExample(ShoesItemExample example);

    ShoesItem selectByPrimaryKey(ShoesItemKey key);

    int updateByExampleSelective(@Param("record") ShoesItem record, @Param("example") ShoesItemExample example);

    int updateByExample(@Param("record") ShoesItem record, @Param("example") ShoesItemExample example);

    int updateByPrimaryKeySelective(ShoesItem record);

    int updateByPrimaryKey(ShoesItem record);
    
    @Select("<script>" +
	    	   	" SELECT " +
	    	   	SearchField.CarDef.COLS +
	    	   	" FROM " + 
	    	   	SearchField.CarDef.TABLE +
				" WHERE si.user_id = ${userId} " +
				" AND si.flag &amp; ${flag} = ${flag} " +
				" AND s.stock_out = '0'" +
    		"</script>")
    List<Map<String, Object>> select4ShoppingCar(@Param("userId")Integer userId,@Param("flag")int flag);
    @Select("<script>" +
    	   	" SELECT " +
    	   	SearchField.OrderDef.COLS +
    	   	" FROM " + 
    	   	SearchField.CarDef.TABLE +
			" WHERE si.user_id = ${userId} " +
			" AND si.shoes_size_id IN " +
			" <foreach close=')' collection='shoesSizeIds' item = 'shoesSizeId' open='(' separator=','>"+
			" #{shoesSizeId} " +
			" </foreach> " +
			" AND si.flag &amp; ${flag} = ${flag} " +
			" AND s.stock_out = '0'" +
		"</script>")
    List<Map<String, Object>> select4Order(@Param("userId")Integer userId,@Param("flag")int flag,@Param("shoesSizeIds")List<Integer> shoesSizeIds);
}