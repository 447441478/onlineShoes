package net.hncu.onlineShoes.domain;

import java.io.Serializable;

public class ShoesItem extends ShoesItemKey implements Serializable {
	private static final long serialVersionUID = 1L;

	public static class Flag{
		public static final int INIT = 0x0;    //初始化
		public static final int ADD = 0x1;     //添加
		public static final int DEL = 0x2;     //删除
	}
	
    private Integer amount;

    private Integer flag = 0;

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }
}