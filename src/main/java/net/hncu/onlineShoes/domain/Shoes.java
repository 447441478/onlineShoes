package net.hncu.onlineShoes.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Shoes {
	public static class StockOut{
		public static final String UP = "0";    //上架
		public static final String DOWN = "1";  //下架
	}
	
	public static class Flag{
		public static final Integer INIT = 0;  		 //默认
		public static final Integer DELETE = 0x1;    //删除
	}
	
    private Integer shoesId;

    private Integer userId;

    private Integer brandId;

    private String imgUuid;

    private String imgSuffix;

    private String onlineTime ;

    private BigDecimal inPrice;

    private BigDecimal outPrice;

    private BigDecimal ratio;

    private String stockOut;

    private String name;
    
    private Integer flag;
    
    //一对多
    private List<ShoesSize> shoesSizes = new ArrayList<ShoesSize>();
    //多对一
    private Brand brand;
    
    public Integer getShoesId() {
        return shoesId;
    }

    public void setShoesId(Integer shoesId) {
        this.shoesId = shoesId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getImgUuid() {
        return imgUuid;
    }

    public void setImgUuid(String imgUuid) {
        this.imgUuid = imgUuid == null ? null : imgUuid.trim();
    }

    public String getImgSuffix() {
        return imgSuffix;
    }

    public void setImgSuffix(String imgSuffix) {
        this.imgSuffix = imgSuffix == null ? null : imgSuffix.trim();
    }

    public String getOnlineTime() {
        return onlineTime;
    }

    public void setOnlineTime(String onlineTime) {
        this.onlineTime = onlineTime == null ? null : onlineTime.trim();
    }

    public BigDecimal getInPrice() {
        return inPrice;
    }

    public void setInPrice(BigDecimal inPrice) {
        this.inPrice = inPrice;
    }

    public BigDecimal getOutPrice() {
        return outPrice;
    }

    public void setOutPrice(BigDecimal outPrice) {
        this.outPrice = outPrice;
    }

    public BigDecimal getRatio() {
        return ratio;
    }

    public void setRatio(BigDecimal ratio) {
        this.ratio = ratio;
    }

    public String getStockOut() {
        return stockOut;
    }

    public void setStockOut(String stockOut) {
        this.stockOut = stockOut == null ? null : stockOut.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

	public List<ShoesSize> getShoesSizes() {
		return shoesSizes;
	}

	public void setShoesSizes(List<ShoesSize> shoesSizes) {
		this.shoesSizes = shoesSizes;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}
}