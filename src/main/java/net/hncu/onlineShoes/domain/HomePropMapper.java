package net.hncu.onlineShoes.domain;

import java.util.List;
import net.hncu.onlineShoes.domain.HomeProp;
import net.hncu.onlineShoes.domain.HomePropExample;
import org.apache.ibatis.annotations.Param;

public interface HomePropMapper {
    long countByExample(HomePropExample example);

    int deleteByExample(HomePropExample example);

    int deleteByPrimaryKey(Integer homePropId);

    int insert(HomeProp record);

    int insertSelective(HomeProp record);

    List<HomeProp> selectByExample(HomePropExample example);

    HomeProp selectByPrimaryKey(Integer homePropId);

    int updateByExampleSelective(@Param("record") HomeProp record, @Param("example") HomePropExample example);

    int updateByExample(@Param("record") HomeProp record, @Param("example") HomePropExample example);

    int updateByPrimaryKeySelective(HomeProp record);

    int updateByPrimaryKey(HomeProp record);
}