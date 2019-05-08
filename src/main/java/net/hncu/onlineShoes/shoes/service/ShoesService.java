package net.hncu.onlineShoes.shoes.service;

import java.util.List;

import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.util.Msg;

public interface ShoesService {
	
	
	String addShoes(Shoes shoes);
	List<Shoes> getShoesListByBrandId(Integer brandId);
	PageInfo<Shoes> getShoesListByBrandIdPaging(Integer brandId,Integer currentPage ,Integer pageSize);
	PageInfo<Shoes> getAllPaging(Integer currentPage ,Integer pageSize);
	Msg getAllByCondition(Integer currentPage, Integer pageSize, String keyWord, String orderFiled, Boolean isDesc, Boolean openTime, Long startTime, Long endTime);
	Msg getAllByCondition(Integer userId,Integer currentPage, Integer pageSize, String keyWord, String orderFiled, Boolean isDesc, Boolean openTime, Long startTime, Long endTime);
	
	Shoes getShoesById(Integer id);
	String updateShoes(Shoes shoes);
	String deleteShoes(Integer[] shoesIds);
	PageInfo<Shoes> getShoesListByKeyWordPaging(String keyWord, int currentPage, int pageSize);
	
}
