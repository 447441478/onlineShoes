package net.hncu.onlineShoes.comm;

import com.mchange.util.AssertException;

public class SearchField {
	private SearchField() {
		throw new AssertException();
	}
	
	public static class ShoesDef{
		public static final String NAME = "name";   //产品名称
		public static final String BRAND_ID = "brandId";  //品牌id
		public static final String BRAND_NAME = "brandName";  //品牌名称
		public static final String ONLINE_TIME = "onlineTime";  //录入时间
		public static final String SALE_PRICE = "salePrice";  //销售价格  outPrice*ratio/100
		public static final String STOCK = "stock";  //库存量
		public static final String STOCK_OUT = "stockOut";  //下架
		public static String getOrderByField(String field, boolean isDesc) {
			if(field == null) {
				return " shoes_id ";
			}
			switch(field) {
				case NAME:
				case BRAND_ID:
				case BRAND_NAME:
				case ONLINE_TIME:
				case SALE_PRICE:
				case STOCK:
				case STOCK_OUT:
					return field + (isDesc ? " desc " : "");
			}
			return " shoes_id ";
		}
		public static String getOrderColum() {
			return "['"+NAME+"','"+BRAND_NAME+"','"+ONLINE_TIME+"','"+STOCK+"','"+STOCK_OUT+"']";
		}
	}
	
	public static class OrderDef{
		public static final String SHOES_SIZE_ID = "shoesSizeId";   
		public static final String SHOES_ID = "shoesId";   
		public static final String BUY_NUM = "buyNum";    //购买数量
		public static final String SIZE = "size";   	//尺码
		public static final String AMOUNT = "amount";  //该尺码所对应的库存 
		public static final String NAME = "name";   //产品名称
		public static final String IMG_UUID = "imgUuid";   
		public static final String IMG_SUFFIX = "imgSuffix";   
		public static final String OUT_PRICE = "outPrice";   
		public static final String RATIO = "ratio";   
		public static final String STOCK_OUT = "stockOut";
		
		//Mapper结果
		public static final String COLS = 
				" si.shoes_size_id as "+SHOES_SIZE_ID+", si.shoes_id as "+SHOES_ID+", " +
	    	   	" si.amount as "+BUY_NUM+", ss.value as "+SIZE+", ss.amount as "+AMOUNT+"," +
	    	   	" s.name as "+NAME+", s.img_uuid as "+IMG_UUID+", s.img_suffix as "+IMG_SUFFIX+"," +
	    	   	" s.out_price as "+OUT_PRICE+", s.ratio as "+RATIO+", s.stock_out as "+STOCK_OUT+" ";
		
		public static final String TABLE = 
				" shoesitem si " + 
				" LEFT JOIN shoessize ss ON si.shoes_size_id = ss.shoes_size_id " + 
				" LEFT JOIN shoes s ON si.shoes_id = s.shoes_id " ;
		
	}
	public static class CarDef{
		public static final String SHOES_SIZE_ID = "shoesSizeId";   
		public static final String SHOES_ID = "shoesId";   
		public static final String BUY_NUM = "buyNum";    //购买数量
		public static final String SIZE = "size";   	//尺码
		public static final String AMOUNT = "amount";  //该尺码所对应的库存 
		public static final String NAME = "name";   //产品名称
		public static final String IMG_UUID = "imgUuid";   
		public static final String IMG_SUFFIX = "imgSuffix";   
		public static final String OUT_PRICE = "outPrice";   
		public static final String RATIO = "ratio";   
		public static final String STOCK_OUT = "stockOut";
		
		
		public static final String COLS = 
				" si.shoes_size_id as "+SHOES_SIZE_ID+", si.shoes_id as "+SHOES_ID+", " +
	    	   	" si.amount as "+BUY_NUM+", ss.value as "+SIZE+", ss.amount as "+AMOUNT+"," +
	    	   	" s.name as "+NAME+", s.img_uuid as "+IMG_UUID+", s.img_suffix as "+IMG_SUFFIX+"," +
	    	   	" s.out_price as "+OUT_PRICE+", s.ratio as "+RATIO+", s.stock_out as "+STOCK_OUT+" ";
		
		public static final String TABLE = 
				" shoesitem si " + 
				" LEFT JOIN shoessize ss ON si.shoes_size_id = ss.shoes_size_id " + 
				" LEFT JOIN shoes s ON si.shoes_id = s.shoes_id " ;
		
	}
	
	public static class UserDef{
		public static final String USER_ID = "user_id";
		public static final String USERNAME = "username";
		public static final String EMAIL = "email";
		public static final String CREATE_TIME = "create_time";
		public static final String FLAG = "flag";
		
		public static String getOrderByField(String field, boolean isDesc) {
			if(field == null) {
				return USER_ID;
			}
			switch(field) {
				case USERNAME:
				case EMAIL:
				case CREATE_TIME:
				case FLAG:
					return field + (isDesc ? " desc " : "");
			}
			return USER_ID;
		}
	}
}
