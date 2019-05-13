package net.hncu.onlineShoes.domain;

import java.util.Date;

public class HomeProp {
    private Integer homePropId;

    private Integer shoesId;

    private Integer type;

    private Date createTime;

    public Integer getHomePropId() {
        return homePropId;
    }

    public void setHomePropId(Integer homePropId) {
        this.homePropId = homePropId;
    }

    public Integer getShoesId() {
        return shoesId;
    }

    public void setShoesId(Integer shoesId) {
        this.shoesId = shoesId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}