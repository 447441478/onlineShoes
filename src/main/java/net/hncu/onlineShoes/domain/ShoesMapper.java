package net.hncu.onlineShoes.domain;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import net.hncu.onlineShoes.comm.SearchField.ShoesDef;

public interface ShoesMapper {
    long countByExample(ShoesExample example);

    int deleteByExample(ShoesExample example);

    int deleteByPrimaryKey(Integer shoesId);

    int insert(Shoes record);

    int insertSelective(Shoes record);

    List<Shoes> selectByExample(ShoesExample example);

    Shoes selectByPrimaryKey(Integer shoesId);
    
    List<Shoes> selectByExampleWithBrandAndShoesSize(ShoesExample example);

    Shoes selectByPrimaryKeyWithBrandAndShoesSize(Integer shoesId);

    int updateByExampleSelective(@Param("record") Shoes record, @Param("example") ShoesExample example);

    int updateByExample(@Param("record") Shoes record, @Param("example") ShoesExample example);

    int updateByPrimaryKeySelective(Shoes record);

    int updateByPrimaryKey(Shoes record);
    
    @Select("SELECT TABLE_ROWS FROM information_schema.TABLES WHERE table_name = 'shoes';")
    long getTotal();
    
    @Select("<script>"	
    		+	"select s.shoes_id as id,s.name as "+ShoesDef.NAME+",s.brand_id as "+ShoesDef.BRAND_ID+","
    		+	"s.online_time as "+ShoesDef.ONLINE_TIME+",s.out_price*s.ratio/100 as "+ShoesDef.SALE_PRICE+","
    		+	"(select sum(amount) from shoessize ss where ss.shoes_id = s.shoes_id) as "+ShoesDef.STOCK+","
    		+	"s.stock_out as "+ShoesDef.STOCK_OUT+",b.name as "+ShoesDef.BRAND_NAME+" "
    		+	" from shoes s left join brand b on s.brand_id = b.brandId "
    		+	" where 1=1 "
    		+	"<if test='lkName != null and lkName != \"\"' >"
    		+	" and s.name like CONCAT('%',#{lkName,jdbcType=VARCHAR},'%') "
    		+	"</if>"
    		+	"<if test='st != null and st != \"\" and et != null and et != \"\" '>"
    		+	" and s.online_time between #{st} and #{et} "
    		+	"</if>"
    		+	"<if test='userId != null and userId != 0'>"
    		+	" and s.user_id = #{userId} "
    		+	"</if>"
    		+	" order by ${orderByClause} "
    		+"</script>")
    List<Map<String, Object>> select4Manage(@Param("orderByClause") String orderByClause, 
    		@Param("lkName")String keyWord, 
    		@Param("st")String startTime, @Param("et")String endTime,
    		@Param("userId")Integer userId);
    
   
}