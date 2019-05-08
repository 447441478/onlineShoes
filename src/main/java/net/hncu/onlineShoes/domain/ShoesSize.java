package net.hncu.onlineShoes.domain;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ShoesSize {
    private Integer shoesSizeId;
    
    @JsonIgnore
    private Integer shoesId;

    private Integer amount;
    
    @JsonProperty("size")
    private BigDecimal value;

    private String description = "";
    
    //多对一
    private Shoes shoes;
    
    public Integer getShoesSizeId() {
        return shoesSizeId;
    }

    public void setShoesSizeId(Integer shoesSizeId) {
        this.shoesSizeId = shoesSizeId;
    }

    public Integer getShoesId() {
        return shoesId;
    }

    public void setShoesId(Integer shoesId) {
        this.shoesId = shoesId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

	public Shoes getShoes() {
		return shoes;
	}

	public void setShoes(Shoes shoes) {
		this.shoes = shoes;
	}
}