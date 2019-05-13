package net.hncu.onlineShoes.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

import net.hncu.onlineShoes.util.DateUtil;

public class User implements Serializable{
	public static class Flag{
		public static final int FREE = 0x0;  //普通会员权限
		public static final int VIP = 0x1;   //vip权限
		public static final int PRODUCT_MANAGER = 0x2; //产品管理员权限
		public static final int MEMBER_MANAGER = 0x4;  //会员管理员权限
		public static final int ORDER_MANAGER = 0x8;   //订单管理员权限
		public static final int SUPER_MANAGER = 0x10;  //超级管理员权限
		public static final int FREEZE = 0x20;         //冻结用户
	}
	
	private static final long serialVersionUID = 1L;

	private Integer userId;
	
    private String username;
    
    @JsonIgnore
    private String password;

    private String email;
    
    @JsonFormat(pattern=DateUtil.PATTERN_DATE_TIME)
    private Date createTime;

    private Integer flag;
    
    //购物车
    private List<ShoesItem> shoppingCar = new ArrayList<ShoesItem>();
    
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

	public List<ShoesItem> getShoppingCar() {
		return shoppingCar;
	}

	public void setShoppingCar(List<ShoesItem> shoppingCar) {
		this.shoppingCar = shoppingCar;
	}
}