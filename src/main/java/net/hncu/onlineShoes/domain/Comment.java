package net.hncu.onlineShoes.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import net.hncu.onlineShoes.util.DateUtil;

public class Comment {
	public static class Flag{
		public static final Integer PUBLIC = 0;  		 //默认 - 公开
		public static final Integer HIDDENT = 0x1;       //隐藏
	}
	
    private Integer commentId;

    private Integer orderDetailId;

    private Integer userId;

    private Integer shoesId;

    private String ip;
    
    @JsonFormat(pattern=DateUtil.PATTERN_DATE_TIME)
    private Date createTime;

    private Integer flag;

    private String userName;

    private String content;
    /**
     * 该属性不存储到数据库，只供传输
     */
    private String shoesName;

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
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

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip == null ? null : ip.trim();
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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	public String getShoesName() {
		return shoesName;
	}

	public void setShoesName(String shoesName) {
		this.shoesName = shoesName;
	}
}