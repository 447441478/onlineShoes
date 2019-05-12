package net.hncu.onlineShoes.shoes.service;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesExample;
import net.hncu.onlineShoes.domain.ShoesMapper;
import net.hncu.onlineShoes.domain.ShoesSize;
import net.hncu.onlineShoes.domain.ShoesSizeExample;
import net.hncu.onlineShoes.domain.ShoesSizeMapper;
import net.hncu.onlineShoes.shoes.dao.ShoesDAO;
import net.hncu.onlineShoes.shoes.dao.ShoesSizeDAO;
import net.hncu.onlineShoes.util.DateUtil;
import net.hncu.onlineShoes.util.Msg;

@Service("shoesService")
public class ShoesServiceImpl implements ShoesService{

	@Autowired
	private ShoesDAO shoesDao;
	
	@Autowired 
	private ShoesSizeDAO shoesSizeDao;
	
	@Autowired
	ShoesMapper shoesMapper;
	
	@Autowired
	ShoesSizeMapper shoesSizeMapper;
	
	@Override
	public String addShoes(Shoes shoes) {
		String addProduct = shoesDao.addProduct(shoes);
		List<ShoesSize> shoesSizes = shoes.getShoesSizes();
		Iterator<ShoesSize> iterator = shoesSizes.iterator();
		while(iterator.hasNext()) {
			ShoesSize shoesSize = iterator.next();
			shoesSize.setShoesId(shoes.getShoesId());
		}
		if(shoesSizes.size() > 0)
			addProduct += shoesSizeDao.addShoesSizes(shoesSizes);
		return addProduct;
	}
	
	@Override
	public List<Shoes> getShoesListByBrandId(Integer brandId) {
		List<Shoes> shoesListByBrandId = shoesDao.getShoesListByBrandId(brandId);
		return shoesListByBrandId;
	}

	@Override
	public PageInfo<Shoes> getShoesListByBrandIdPaging(Integer brandId, Integer currentPage,Integer pageSize) {
		PageHelper.startPage(currentPage, pageSize);
		List<Shoes> shoesListByBrandId = shoesDao.getShoesListByBrandId(brandId);
		return new PageInfo<Shoes>(shoesListByBrandId);
	}

	@Override
	public PageInfo<Shoes> getAllPaging(Integer currentPage, Integer pageSize) {
		PageHelper.startPage(currentPage, pageSize);
		return new PageInfo<Shoes>(shoesDao.getAll());
	}

	

	@Override
	public Shoes getShoesById(Integer id) {
		return shoesMapper.selectByPrimaryKeyWithBrandAndShoesSize(id);
	}

	@Override
	public String updateShoes(Shoes shoes) {
		if(shoes.getShoesId() == null) {
			return "shoesId不能为空";
		}
		shoesMapper.updateByPrimaryKeySelective(shoes);
		List<ShoesSize> shoesSizes = shoes.getShoesSizes();
		if(shoesSizes.size() > 0) {
			//先查询该鞋子的所有鞋码id
			List<Integer> shoesSizeIds= shoesSizeMapper.getShoesSizeIds(shoes.getShoesId());
			Iterator<ShoesSize> iterator = shoesSizes.iterator();
			while(iterator.hasNext()) {
				ShoesSize shoesSize = iterator.next();
				shoesSize.setShoesId(shoes.getShoesId());
				if(shoesSize.getShoesSizeId() != null) {
					if(shoesSizeIds.contains(shoesSize.getShoesSizeId())) {
						//如果是要修改的就剔除
						shoesSizeIds.remove(shoesSize.getShoesSizeId());
					}
					shoesSizeMapper.updateByPrimaryKeySelective(shoesSize);
					iterator.remove();
				}
			}
			if(shoesSizes.size() > 0) 
				shoesSizeMapper.insertList(shoesSizes);
			if(shoesSizeIds.size()>0) {
				ShoesSizeExample example = new ShoesSizeExample();
				example.createCriteria().andShoesIdEqualTo(shoes.getShoesId()).andShoesSizeIdIn(shoesSizeIds);
				//删除
				shoesSizeMapper.deleteByExample(example);
			}
		}
		return "修改成功";
	}

	@Override
	public String deleteShoes(Integer[] shoesIds) {
		if(shoesIds == null) 
			return "shoesId不能为空";
		//先删除所有鞋码
		ShoesSizeExample example = new ShoesSizeExample();
		example.createCriteria().andShoesIdIn(Arrays.asList(shoesIds));
		shoesSizeMapper.deleteByExample(example);
		//再删除鞋子相关信息
		ShoesExample shoesExample = new ShoesExample();
		shoesExample.createCriteria().andShoesIdIn(Arrays.asList(shoesIds));
		shoesMapper.deleteByExample(shoesExample);
		
		return "删除成功";
	}

	@Override
	public Msg getAllByCondition(Integer currentPage, Integer pageSize, String keyWord, String orderFiled,
			Boolean isDesc, Boolean openTime, Long startTime, Long endTime) {
		return getAllByCondition(null,currentPage,pageSize,
				keyWord,orderFiled,isDesc,openTime,startTime,endTime);
	}

	@Override
	public Msg getAllByCondition(Integer userId, Integer currentPage, Integer pageSize, String keyWord,
			String orderFiled, Boolean isDesc, Boolean openTime, Long startTime, Long endTime) {
		String orderByClause = SearchField.ShoesDef.getOrderByField(orderFiled,isDesc); 
		PageHelper.startPage(currentPage,pageSize);
		if(openTime && DateUtil.isBefore(startTime, endTime)) {
			String st = DateUtil.getDayFirstSeconds(startTime);
			String et = DateUtil.getDayLastSeconds(endTime);
			List<Map<String, Object>> shoesList = shoesMapper.select4Manage(orderByClause,keyWord,st,et,userId);
			PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(shoesList);
			return Msg.success().add("total", pageInfo.getTotal()).add("shoesList", pageInfo.getList());
		}else {
			List<Map<String, Object>> shoesList = shoesMapper.select4Manage(orderByClause,keyWord,null,null,userId);
			PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(shoesList);
			return Msg.success().add("total", pageInfo.getTotal()).add("shoesList", pageInfo.getList());
		}
	}

	@Override
	public PageInfo<Shoes> getShoesListByKeyWordPaging(String keyWord, int currentPage, int pageSize) {
		if(keyWord == null) {
			return null;
		}
		PageHelper.startPage(currentPage, pageSize);
		ShoesExample shoesExample = new ShoesExample();
		shoesExample.createCriteria().andNameLike(keyWord);
		List<Shoes> shoesListByBrandId = shoesMapper.selectByExample(shoesExample);
		return new PageInfo<Shoes>(shoesListByBrandId);
	}
	
}
