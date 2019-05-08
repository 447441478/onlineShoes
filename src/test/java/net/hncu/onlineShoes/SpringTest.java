package net.hncu.onlineShoes;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.Brand;
import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemMapper;
import net.hncu.onlineShoes.domain.ShoesMapper;
import net.hncu.onlineShoes.domain.ShoesSize;
import net.hncu.onlineShoes.domain.ShoesSizeExample;
import net.hncu.onlineShoes.domain.ShoesSizeMapper;
import net.hncu.onlineShoes.domain.UserMapper;
import net.hncu.onlineShoes.shoes.service.ShoesService;
import net.hncu.onlineShoes.util.DateUtil;
import net.hncu.onlineShoes.util.Msg;

/* 使用SpringTest组件 - 可以采用@Autowired进行注入：
 * 1. @ContextConfiguration指定Spring 容器位置
 * 2. @RunWith指定使用的单元测试类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class SpringTest {
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired 
	ShoesService shoesService;
	
	@Autowired 
	ShoesMapper shoesMapper;
	@Autowired 
	ShoesSizeMapper shoesSizeMapper;
	@Autowired
	ShoesItemMapper shoesItemMapper;
	
	@Test
	public void testMapper() {
		System.out.println( userMapper );
	}
	
	@Test
	public void testCRUD() {
		//userMapper.insertSelective( new User(null, "sjy2", MD5Util.mkMD5Pwd("123456"), "1@1.com", UUIDUtil.getACode()));
		/*System.out.println( userMapper.selectByPrimaryKey(4) );
		ShoesMapper shoesMapper = sqlSession.getMapper( ShoesMapper.class );
		for( int i = 0;i<100;i++) {
			//shoesMapper.insertSelective( new Shoes(null, 1, UUIDUtil.getImgName(), ".jpg", DateUtil.dateConversionString(new Date()), BigDecimal.ONE, BigDecimal.ONE, null, "0"));
		}
		System.out.println("批量完成");*/
	}
	/*@Test
	public void batchInsert() {
		List<ShoesSize> shoesSizes = new ArrayList<ShoesSize>();
		ShoesSize shoesSize = new ShoesSize();
		shoesSize.setValue(new BigDecimal(40));
		shoesSize.setAmount(10);
		shoesSizes.add(shoesSize);
		shoesSize = new ShoesSize();
		shoesSize.setValue(new BigDecimal(40));
		shoesSize.setAmount(10);
		shoesSizes.add(shoesSize);
		String str = "鞋子有着悠久的发展史。大约在5000多年前的仰韶文化时期，就出现了兽皮缝制的最原始的鞋。鞋子是人们保护脚不受伤的一种工具。最早人们为了克服特殊情况，不让脚难受或者受伤，就发明了毛皮鞋子。鞋子发展到现在，就形成了现在这个样子。各种样式功能的鞋子随处可见";
		for(int i = 0; i<100;i++) {
			Shoes shoes = new Shoes();
			shoes.setBrandId(1);
			shoes.setImgSuffix(".jpeg");
			shoes.setImgUuid("2ee005c0572a4eed9f84e76bda099afc");
			shoes.setInPrice(new BigDecimal(Math.random()*100));
			shoes.setOutPrice(new BigDecimal(Math.random()*200));
			String name = "";
			for(int j = 0; j< 10;j++) {
				name += str.charAt((int)(Math.random()*str.length()));
			}
			shoes.setName(name);
			shoes.setOnlineTime(DateUtil.getCurrentDateString());
			shoes.setRatio(new BigDecimal(Math.random()));
			shoes.setShoesSizes(shoesSizes);
			shoes.setUserId(1);
			shoesService.addShoes(shoes);
		}
		
	}*/
	@Test
	public void test11() {
		/*List<Shoes> selectByExampleWithBrandAndShoesSize = shoesMapper.selectByExampleWithBrandAndShoesSize(null);
		for (Shoes shoes : selectByExampleWithBrandAndShoesSize) {
			System.out.println(shoes);
			Brand brand = shoes.getBrand();
			System.out.println( brand.getName() + "--" + brand.getBrandid());
			List<ShoesSize> shoesSizes = shoes.getShoesSizes();
			for (ShoesSize shoesSize : shoesSizes) {
				System.out.println(shoesSize.getShoesSizeId());
				System.out.println(shoesSize.getShoesId());
				System.out.println(shoesSize.getValue());
			}
		}*/
		/*Shoes shoes = shoesMapper.selectByPrimaryKeyWithBrandAndShoesSize(53);
		System.out.println(shoes.getName());*/
		//System.out.println(shoesMapper.getTotal());
		/*System.out.println(SearchField.Shoes.getOrderByField("stock", true));*/
		/*List<Integer> shoesSizeIds = new ArrayList<>();
		shoesSizeIds.add(19);
		shoesSizeIds.add(29);
		shoesSizeIds.add(39);
		ShoesSizeExample example = new ShoesSizeExample();
		example.createCriteria().andShoesSizeIdIn(shoesSizeIds);
		List<ShoesSize> withShoes = shoesSizeMapper.selectWithShoesByExample(example);
		for (ShoesSize shoesSize : withShoes) {
			System.out.println(shoesSize.getShoes().getName());
		}*/
		Integer[] ids = {22};
		List<Map<String,Object>> select4ShoppingCar = shoesItemMapper.select4Order(1, ShoesItem.Flag.ADD,Arrays.asList(ids));
		System.out.println(Arrays.toString(select4ShoppingCar.toArray()));
	}
	
}
