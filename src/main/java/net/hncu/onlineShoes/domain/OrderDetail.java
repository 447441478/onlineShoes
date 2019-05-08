package net.hncu.onlineShoes.domain;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 宋进宇
 *
 */
public class OrderDetail implements Serializable{
	private static final long serialVersionUID = 1L;

	@Override
	public String toString() {
		return "OrderDetail [orderDetailId=" + orderDetailId + ", userId=" + userId + ", shoesId=" + shoesId
				+ ", price=" + price + ", amount=" + amount + ", shoesSize=" + shoesSize + ", name=" + name + ", tel="
				+ tel + ", addr=" + addr + ", createTime=" + createTime + ", flag=" + flag + ", paymethod=" + paymethod
				+ ", logisticsId=" + logisticsId + ", shoes=" + shoes + "]";
	}

	public static class Flag{
		public static final int INIT = 0;          		   //订单初始化
		public static final int DELIVERED = 1;    		   //已发货
		public static final int ACCEPTED = 2;     		   //已签收
		public static final int APPLY_REFUND = 3;  		   //申请退款
		public static final int COMPLETE_REFUND = 4;       //退款成功
		public static final int COMPLETE_TRANSACTION = 5;  //交易完成
		public static final int EVALUATED = 6;    		   //已评价
	}
	//在线支付 必须 ONLINE_PAY&WX_PAY / ONLINE_PAY&AL_PAY  类推
	public static class Paymethod{
		public static final int DEFAULT = 0x0;              //货到付款
		public static final int ONLINE_PAY = 0x1;           //在线支付
		public static final int WX_PAY = 0x2;    			//微信支付
		public static final int AL_PAY = 0x4;    			//支付宝支付
	}
	
    private Integer orderDetailId;

    private Integer userId;

    private Integer shoesId;

    private BigDecimal price;

    private Integer amount;

    private BigDecimal shoesSize;
    
    private String name;

    private String tel;

    private String addr;

    private Date createTime;

    private Integer flag;

    private Integer paymethod;

    private String logisticsId;  //快递编号
    
    //一对一
    private Shoes shoes;
   
    public OrderDetail(Integer userId, String name, String tel, String addr, Integer paymethod) {
		super();
		this.userId = userId;
		this.name = name;
		this.tel = tel;
		this.addr = addr;
		this.paymethod = paymethod;
	}

	public OrderDetail() {
	}
    
    public Integer getOrderDetailId() {
        return orderDetailId;
    }

	public void setOrderDetailId(Integer orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getShoesId() {
        return shoesId;
    }

    public void setShoesId(Integer shoesId) {
        this.shoesId = shoesId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getShoesSize() {
        return shoesSize;
    }

    public void setShoesSize(BigDecimal shoesSize) {
        this.shoesSize = shoesSize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr == null ? null : addr.trim();
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

    public Integer getPaymethod() {
        return paymethod;
    }

    public void setPaymethod(Integer paymethod) {
        this.paymethod = paymethod;
    }

    public String getLogisticsId() {
        return logisticsId;
    }

    public void setLogisticsId(String logisticsId) {
        this.logisticsId = logisticsId == null ? null : logisticsId.trim();
    }
    
    public OrderDetail deepClone() throws CloneNotSupportedException, IOException, ClassNotFoundException {
		//将对象写到流里
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(baos);
		oos.writeObject(this);
		
		//从流里读出来
		ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
		ObjectInputStream ois = new ObjectInputStream(bais);
    	return (OrderDetail)ois.readObject();
    }

	public Shoes getShoes() {
		return shoes;
	}

	public void setShoes(Shoes shoes) {
		this.shoes = shoes;
	}
}