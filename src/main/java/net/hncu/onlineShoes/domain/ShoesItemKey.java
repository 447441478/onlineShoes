package net.hncu.onlineShoes.domain;

public class ShoesItemKey {
    private Integer userId;

    private Integer shoesId;

    private Integer shoesSizeId;

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

    public Integer getShoesSizeId() {
        return shoesSizeId;
    }

    public void setShoesSizeId(Integer shoesSizeId) {
        this.shoesSizeId = shoesSizeId;
    }

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((shoesId == null) ? 0 : shoesId.hashCode());
		result = prime * result + ((shoesSizeId == null) ? 0 : shoesSizeId.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ShoesItemKey other = (ShoesItemKey) obj;
		if (shoesId == null) {
			if (other.shoesId != null)
				return false;
		} else if (!shoesId.equals(other.shoesId))
			return false;
		if (shoesSizeId == null) {
			if (other.shoesSizeId != null)
				return false;
		} else if (!shoesSizeId.equals(other.shoesSizeId))
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}
    
    
}