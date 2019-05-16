package net.hncu.onlineShoes.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ShoesExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ShoesExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }
        protected void addCriterion(String condition, Object value, String property, boolean isLike) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value,isLike));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andShoesIdIsNull() {
            addCriterion("shoes_id is null");
            return (Criteria) this;
        }

        public Criteria andShoesIdIsNotNull() {
            addCriterion("shoes_id is not null");
            return (Criteria) this;
        }

        public Criteria andShoesIdEqualTo(Integer value) {
            addCriterion("shoes_id =", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdNotEqualTo(Integer value) {
            addCriterion("shoes_id <>", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdGreaterThan(Integer value) {
            addCriterion("shoes_id >", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("shoes_id >=", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdLessThan(Integer value) {
            addCriterion("shoes_id <", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdLessThanOrEqualTo(Integer value) {
            addCriterion("shoes_id <=", value, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdIn(List<Integer> values) {
            addCriterion("shoes_id in", values, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdNotIn(List<Integer> values) {
            addCriterion("shoes_id not in", values, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdBetween(Integer value1, Integer value2) {
            addCriterion("shoes_id between", value1, value2, "shoesId");
            return (Criteria) this;
        }

        public Criteria andShoesIdNotBetween(Integer value1, Integer value2) {
            addCriterion("shoes_id not between", value1, value2, "shoesId");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNull() {
            addCriterion("user_id is null");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNotNull() {
            addCriterion("user_id is not null");
            return (Criteria) this;
        }

        public Criteria andUserIdEqualTo(Integer value) {
            addCriterion("user_id =", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotEqualTo(Integer value) {
            addCriterion("user_id <>", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThan(Integer value) {
            addCriterion("user_id >", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("user_id >=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThan(Integer value) {
            addCriterion("user_id <", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("user_id <=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdIn(List<Integer> values) {
            addCriterion("user_id in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotIn(List<Integer> values) {
            addCriterion("user_id not in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdBetween(Integer value1, Integer value2) {
            addCriterion("user_id between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("user_id not between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andBrandIdIsNull() {
            addCriterion("brand_id is null");
            return (Criteria) this;
        }

        public Criteria andBrandIdIsNotNull() {
            addCriterion("brand_id is not null");
            return (Criteria) this;
        }

        public Criteria andBrandIdEqualTo(Integer value) {
            addCriterion("brand_id =", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdNotEqualTo(Integer value) {
            addCriterion("brand_id <>", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdGreaterThan(Integer value) {
            addCriterion("brand_id >", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("brand_id >=", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdLessThan(Integer value) {
            addCriterion("brand_id <", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdLessThanOrEqualTo(Integer value) {
            addCriterion("brand_id <=", value, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdIn(List<Integer> values) {
            addCriterion("brand_id in", values, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdNotIn(List<Integer> values) {
            addCriterion("brand_id not in", values, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdBetween(Integer value1, Integer value2) {
            addCriterion("brand_id between", value1, value2, "brandId");
            return (Criteria) this;
        }

        public Criteria andBrandIdNotBetween(Integer value1, Integer value2) {
            addCriterion("brand_id not between", value1, value2, "brandId");
            return (Criteria) this;
        }

        public Criteria andImgUuidIsNull() {
            addCriterion("img_uuid is null");
            return (Criteria) this;
        }

        public Criteria andImgUuidIsNotNull() {
            addCriterion("img_uuid is not null");
            return (Criteria) this;
        }

        public Criteria andImgUuidEqualTo(String value) {
            addCriterion("img_uuid =", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidNotEqualTo(String value) {
            addCriterion("img_uuid <>", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidGreaterThan(String value) {
            addCriterion("img_uuid >", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidGreaterThanOrEqualTo(String value) {
            addCriterion("img_uuid >=", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidLessThan(String value) {
            addCriterion("img_uuid <", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidLessThanOrEqualTo(String value) {
            addCriterion("img_uuid <=", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidLike(String value) {
            addCriterion("img_uuid like", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidNotLike(String value) {
            addCriterion("img_uuid not like", value, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidIn(List<String> values) {
            addCriterion("img_uuid in", values, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidNotIn(List<String> values) {
            addCriterion("img_uuid not in", values, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidBetween(String value1, String value2) {
            addCriterion("img_uuid between", value1, value2, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgUuidNotBetween(String value1, String value2) {
            addCriterion("img_uuid not between", value1, value2, "imgUuid");
            return (Criteria) this;
        }

        public Criteria andImgSuffixIsNull() {
            addCriterion("img_suffix is null");
            return (Criteria) this;
        }

        public Criteria andImgSuffixIsNotNull() {
            addCriterion("img_suffix is not null");
            return (Criteria) this;
        }

        public Criteria andImgSuffixEqualTo(String value) {
            addCriterion("img_suffix =", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixNotEqualTo(String value) {
            addCriterion("img_suffix <>", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixGreaterThan(String value) {
            addCriterion("img_suffix >", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixGreaterThanOrEqualTo(String value) {
            addCriterion("img_suffix >=", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixLessThan(String value) {
            addCriterion("img_suffix <", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixLessThanOrEqualTo(String value) {
            addCriterion("img_suffix <=", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixLike(String value) {
            addCriterion("img_suffix like", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixNotLike(String value) {
            addCriterion("img_suffix not like", value, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixIn(List<String> values) {
            addCriterion("img_suffix in", values, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixNotIn(List<String> values) {
            addCriterion("img_suffix not in", values, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixBetween(String value1, String value2) {
            addCriterion("img_suffix between", value1, value2, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andImgSuffixNotBetween(String value1, String value2) {
            addCriterion("img_suffix not between", value1, value2, "imgSuffix");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeIsNull() {
            addCriterion("online_time is null");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeIsNotNull() {
            addCriterion("online_time is not null");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeEqualTo(String value) {
            addCriterion("online_time =", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeNotEqualTo(String value) {
            addCriterion("online_time <>", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeGreaterThan(String value) {
            addCriterion("online_time >", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeGreaterThanOrEqualTo(String value) {
            addCriterion("online_time >=", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeLessThan(String value) {
            addCriterion("online_time <", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeLessThanOrEqualTo(String value) {
            addCriterion("online_time <=", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeLike(String value) {
            addCriterion("online_time like", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeNotLike(String value) {
            addCriterion("online_time not like", value, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeIn(List<String> values) {
            addCriterion("online_time in", values, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeNotIn(List<String> values) {
            addCriterion("online_time not in", values, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeBetween(String value1, String value2) {
            addCriterion("online_time between", value1, value2, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andOnlineTimeNotBetween(String value1, String value2) {
            addCriterion("online_time not between", value1, value2, "onlineTime");
            return (Criteria) this;
        }

        public Criteria andInPriceIsNull() {
            addCriterion("in_price is null");
            return (Criteria) this;
        }

        public Criteria andInPriceIsNotNull() {
            addCriterion("in_price is not null");
            return (Criteria) this;
        }

        public Criteria andInPriceEqualTo(BigDecimal value) {
            addCriterion("in_price =", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceNotEqualTo(BigDecimal value) {
            addCriterion("in_price <>", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceGreaterThan(BigDecimal value) {
            addCriterion("in_price >", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("in_price >=", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceLessThan(BigDecimal value) {
            addCriterion("in_price <", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceLessThanOrEqualTo(BigDecimal value) {
            addCriterion("in_price <=", value, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceIn(List<BigDecimal> values) {
            addCriterion("in_price in", values, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceNotIn(List<BigDecimal> values) {
            addCriterion("in_price not in", values, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("in_price between", value1, value2, "inPrice");
            return (Criteria) this;
        }

        public Criteria andInPriceNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("in_price not between", value1, value2, "inPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceIsNull() {
            addCriterion("out_price is null");
            return (Criteria) this;
        }

        public Criteria andOutPriceIsNotNull() {
            addCriterion("out_price is not null");
            return (Criteria) this;
        }

        public Criteria andOutPriceEqualTo(BigDecimal value) {
            addCriterion("out_price =", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceNotEqualTo(BigDecimal value) {
            addCriterion("out_price <>", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceGreaterThan(BigDecimal value) {
            addCriterion("out_price >", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("out_price >=", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceLessThan(BigDecimal value) {
            addCriterion("out_price <", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceLessThanOrEqualTo(BigDecimal value) {
            addCriterion("out_price <=", value, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceIn(List<BigDecimal> values) {
            addCriterion("out_price in", values, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceNotIn(List<BigDecimal> values) {
            addCriterion("out_price not in", values, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("out_price between", value1, value2, "outPrice");
            return (Criteria) this;
        }

        public Criteria andOutPriceNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("out_price not between", value1, value2, "outPrice");
            return (Criteria) this;
        }

        public Criteria andRatioIsNull() {
            addCriterion("ratio is null");
            return (Criteria) this;
        }

        public Criteria andRatioIsNotNull() {
            addCriterion("ratio is not null");
            return (Criteria) this;
        }

        public Criteria andRatioEqualTo(BigDecimal value) {
            addCriterion("ratio =", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioNotEqualTo(BigDecimal value) {
            addCriterion("ratio <>", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioGreaterThan(BigDecimal value) {
            addCriterion("ratio >", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("ratio >=", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioLessThan(BigDecimal value) {
            addCriterion("ratio <", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioLessThanOrEqualTo(BigDecimal value) {
            addCriterion("ratio <=", value, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioIn(List<BigDecimal> values) {
            addCriterion("ratio in", values, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioNotIn(List<BigDecimal> values) {
            addCriterion("ratio not in", values, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ratio between", value1, value2, "ratio");
            return (Criteria) this;
        }

        public Criteria andRatioNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ratio not between", value1, value2, "ratio");
            return (Criteria) this;
        }

        public Criteria andStockOutIsNull() {
            addCriterion("stock_out is null");
            return (Criteria) this;
        }

        public Criteria andStockOutIsNotNull() {
            addCriterion("stock_out is not null");
            return (Criteria) this;
        }

        public Criteria andStockOutEqualTo(String value) {
            addCriterion("stock_out =", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutNotEqualTo(String value) {
            addCriterion("stock_out <>", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutGreaterThan(String value) {
            addCriterion("stock_out >", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutGreaterThanOrEqualTo(String value) {
            addCriterion("stock_out >=", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutLessThan(String value) {
            addCriterion("stock_out <", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutLessThanOrEqualTo(String value) {
            addCriterion("stock_out <=", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutLike(String value) {
            addCriterion("stock_out like", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutNotLike(String value) {
            addCriterion("stock_out not like", value, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutIn(List<String> values) {
            addCriterion("stock_out in", values, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutNotIn(List<String> values) {
            addCriterion("stock_out not in", values, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutBetween(String value1, String value2) {
            addCriterion("stock_out between", value1, value2, "stockOut");
            return (Criteria) this;
        }

        public Criteria andStockOutNotBetween(String value1, String value2) {
            addCriterion("stock_out not between", value1, value2, "stockOut");
            return (Criteria) this;
        }

        public Criteria andNameIsNull() {
            addCriterion("name is null");
            return (Criteria) this;
        }

        public Criteria andNameIsNotNull() {
            addCriterion("name is not null");
            return (Criteria) this;
        }

        public Criteria andNameEqualTo(String value) {
            addCriterion("name =", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotEqualTo(String value) {
            addCriterion("name <>", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThan(String value) {
            addCriterion("name >", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThanOrEqualTo(String value) {
            addCriterion("name >=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThan(String value) {
            addCriterion("name <", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThanOrEqualTo(String value) {
            addCriterion("name <=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLike(String value) {
            addCriterion("name like", value, "name", true);
            return (Criteria) this;
        }

        public Criteria andNameNotLike(String value) {
            addCriterion("name not like", value, "name", true);
            return (Criteria) this;
        }

        public Criteria andNameIn(List<String> values) {
            addCriterion("name in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotIn(List<String> values) {
            addCriterion("name not in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameBetween(String value1, String value2) {
            addCriterion("name between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotBetween(String value1, String value2) {
            addCriterion("name not between", value1, value2, "name");
            return (Criteria) this;
        }
        
        public Criteria andFlagIsNull() {
            addCriterion("flag is null");
            return (Criteria) this;
        }

        public Criteria andFlagIsNotNull() {
            addCriterion("flag is not null");
            return (Criteria) this;
        }

        public Criteria andFlagEqualTo(Integer value) {
            addCriterion("flag =", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagNotEqualTo(Integer value) {
            addCriterion("flag <>", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagGreaterThan(Integer value) {
            addCriterion("flag >", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagGreaterThanOrEqualTo(Integer value) {
            addCriterion("flag >=", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagLessThan(Integer value) {
            addCriterion("flag <", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagLessThanOrEqualTo(Integer value) {
            addCriterion("flag <=", value, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagIn(List<Integer> values) {
            addCriterion("flag in", values, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagNotIn(List<Integer> values) {
            addCriterion("flag not in", values, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagBetween(Integer value1, Integer value2) {
            addCriterion("flag between", value1, value2, "flag");
            return (Criteria) this;
        }

        public Criteria andFlagNotBetween(Integer value1, Integer value2) {
            addCriterion("flag not between", value1, value2, "flag");
            return (Criteria) this;
        }
        
        public Criteria andFlagBitOr(Integer value) {
        	addCriterion("flag | " + value + " = " + value);
        	return (Criteria) this;
        }
        public Criteria andFlagBitAnd(Integer value) {
        	addCriterion("flag & " + value + " = " + value);
        	return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;
        
        private boolean like;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
        protected Criterion(String condition, Object value, boolean like) {
        	 this.condition = condition;
             this.value = value;
             this.like = like;
        }

		public boolean isLike() {
			return like;
		}

    }
}