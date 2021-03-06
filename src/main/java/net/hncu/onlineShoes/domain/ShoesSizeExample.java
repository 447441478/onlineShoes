package net.hncu.onlineShoes.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ShoesSizeExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ShoesSizeExample() {
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

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andShoesSizeIdIsNull() {
            addCriterion("shoes_size_id is null");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdIsNotNull() {
            addCriterion("shoes_size_id is not null");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdEqualTo(Integer value) {
            addCriterion("shoes_size_id =", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdNotEqualTo(Integer value) {
            addCriterion("shoes_size_id <>", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdGreaterThan(Integer value) {
            addCriterion("shoes_size_id >", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("shoes_size_id >=", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdLessThan(Integer value) {
            addCriterion("shoes_size_id <", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdLessThanOrEqualTo(Integer value) {
            addCriterion("shoes_size_id <=", value, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdIn(List<Integer> values) {
            addCriterion("shoes_size_id in", values, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdNotIn(List<Integer> values) {
            addCriterion("shoes_size_id not in", values, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdBetween(Integer value1, Integer value2) {
            addCriterion("shoes_size_id between", value1, value2, "shoesSizeId");
            return (Criteria) this;
        }

        public Criteria andShoesSizeIdNotBetween(Integer value1, Integer value2) {
            addCriterion("shoes_size_id not between", value1, value2, "shoesSizeId");
            return (Criteria) this;
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

        public Criteria andAmountIsNull() {
            addCriterion("amount is null");
            return (Criteria) this;
        }

        public Criteria andAmountIsNotNull() {
            addCriterion("amount is not null");
            return (Criteria) this;
        }

        public Criteria andAmountEqualTo(Integer value) {
            addCriterion("amount =", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotEqualTo(Integer value) {
            addCriterion("amount <>", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountGreaterThan(Integer value) {
            addCriterion("amount >", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountGreaterThanOrEqualTo(Integer value) {
            addCriterion("amount >=", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountLessThan(Integer value) {
            addCriterion("amount <", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountLessThanOrEqualTo(Integer value) {
            addCriterion("amount <=", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountIn(List<Integer> values) {
            addCriterion("amount in", values, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotIn(List<Integer> values) {
            addCriterion("amount not in", values, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountBetween(Integer value1, Integer value2) {
            addCriterion("amount between", value1, value2, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotBetween(Integer value1, Integer value2) {
            addCriterion("amount not between", value1, value2, "amount");
            return (Criteria) this;
        }

        public Criteria andValueIsNull() {
            addCriterion("value is null");
            return (Criteria) this;
        }

        public Criteria andValueIsNotNull() {
            addCriterion("value is not null");
            return (Criteria) this;
        }

        public Criteria andValueEqualTo(BigDecimal value) {
            addCriterion("value =", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueNotEqualTo(BigDecimal value) {
            addCriterion("value <>", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueGreaterThan(BigDecimal value) {
            addCriterion("value >", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("value >=", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueLessThan(BigDecimal value) {
            addCriterion("value <", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueLessThanOrEqualTo(BigDecimal value) {
            addCriterion("value <=", value, "value");
            return (Criteria) this;
        }

        public Criteria andValueIn(List<BigDecimal> values) {
            addCriterion("value in", values, "value");
            return (Criteria) this;
        }

        public Criteria andValueNotIn(List<BigDecimal> values) {
            addCriterion("value not in", values, "value");
            return (Criteria) this;
        }

        public Criteria andValueBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("value between", value1, value2, "value");
            return (Criteria) this;
        }

        public Criteria andValueNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("value not between", value1, value2, "value");
            return (Criteria) this;
        }

        public Criteria andDescriptionIsNull() {
            addCriterion("description is null");
            return (Criteria) this;
        }

        public Criteria andDescriptionIsNotNull() {
            addCriterion("description is not null");
            return (Criteria) this;
        }

        public Criteria andDescriptionEqualTo(String value) {
            addCriterion("description =", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotEqualTo(String value) {
            addCriterion("description <>", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionGreaterThan(String value) {
            addCriterion("description >", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionGreaterThanOrEqualTo(String value) {
            addCriterion("description >=", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionLessThan(String value) {
            addCriterion("description <", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionLessThanOrEqualTo(String value) {
            addCriterion("description <=", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionLike(String value) {
            addCriterion("description like", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotLike(String value) {
            addCriterion("description not like", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionIn(List<String> values) {
            addCriterion("description in", values, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotIn(List<String> values) {
            addCriterion("description not in", values, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionBetween(String value1, String value2) {
            addCriterion("description between", value1, value2, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotBetween(String value1, String value2) {
            addCriterion("description not between", value1, value2, "description");
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
    }
}