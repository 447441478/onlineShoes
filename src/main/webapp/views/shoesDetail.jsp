<%@page import="net.hncu.onlineShoes.util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<title>鲸鱼鞋店</title>
<jsp:include page="/inc/common_js_css_inc.jsp" />
<style type="text/css">
.shoesName{
	margin: 0;
	padding: 0;
	color: #000;
	font-weight:700;
	font-size: 24px;
}
.shoesDetail span{
	color: #838383;
	font-family: 微软雅黑;
}
.priceDiv{
	margin-top:16px;
	font-size: 18px;
	background-color: #eee;
}
#shoesDetail .passPrice{
	text-decoration: line-through;
	opacity: 0.5;
}
#shoesDetail .salayPrice{
	color: #f30c0c;
	font-size: 24px;
}
#shoesDetail .item span:first-child{	
	display:inline-block;
	width: 88px;
}
.shoesSizes{
	margin-top: 10px;
}
#shoesDetail .shoesSizes .checked{
	border: 2px solid #f30c0c;
	margin:-1px; 
}
#shoesDetail .shoesSizes ul li{
	display: inline-block;
	text-decoration: none;
	margin-right: 8px;
}
#shoesDetail .sizeItem{
	box-sizing:border-box;
	display: inline-block;
	padding: 4px 9px;
	font-size: 14px;
	background-color: #fff;
	cursor: pointer;
	border: 1px solid #ddd; 
}
#shoesDetail .sizeItem:hover{
	border: 2px solid #f30c0c;
	margin: -1px;
}
#shoesDetail .btns{
	margin-top: 20px;
}
#shoesDetail .btns div{
	height: 38px;
    line-height: 38px;
    text-align: center;
    font-size: 16px;
}
.linkBuy{
	margin-right: 0;
    float: left;
    overflow: hidden;
    position: relative;
    width: 178px;
    background-color: #ffeded;
    border: 1px solid #FF0036;
    color: #FF0036;
    font-family: 'Microsoft Yahei';
    cursor: pointer;
}
.linkBasket{
	margin-left:8px;
	background-color: #ff0036;
    border: 1px solid #ff0036;
    color: #fff;
    margin-right: 0;
    float: left;
    overflow: hidden;
    position: relative;
    width: 178px;
    cursor: pointer;
}
</style>
<title>产品详情</title>
</head>
<body>
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<jsp:include page="/inc/header_inc.jsp" />
		<div class="row">
			<div class="col-md-12" style="padding: 10px 0 0 0;">
				<ol class="breadcrumb">
				  <li><a href="${APP_DIR}">首页</a></li>
				  <li><a href="${APP_DIR}/brand/${shoes.brandId}">${shoes.brand.name}</a></li>
				  <li class="active">${shoes.name}</li>
				</ol>
			</div>
		</div>
		<div class="row shoesDetail" id="shoesDetail">
			<div class="col-md-3">
				<img id="shoesImg" style="width: 100%;" alt="" src="<%=FileUtil.PRODUCT_PATH%>/${shoes.imgUuid}${shoes.imgSuffix}">
				<div v-show="false"></div>
			</div>
			<div class="col-md-6">
				<h1 class="shoesName">${shoes.name}</h1>
				<div class="priceDiv">
					<div class="item">
						<span>价格</span>
						<span :class='hasRatio ? "passPrice" : "salayPrice"'>￥{{outPrice}}</span>
					</div>
					<div v-if='hasRatio' class="item" style="color: #f30c0c;font-size: 20px;">
						<span >狂欢价</span>
						<span class="salayPrice">￥{{salayPrice}}</span>
					</div>
				</div>
				<div class="shoesSizes">
					<span style="width: 80px; float: left;display: inline-block;">鞋码</span>
					<ul>
						<li v-for='(shoesSize,index) in shoesSizes'>
							<span class="sizeItem" :class='checkedIndex == index ? "checked" : ""' @click='check(index)' >{{shoesSize.size}}</span>
						</li>
					</ul>
				</div>
				<div style="margin-top: 10px;">
					<span style="width: 80px; float: left;display: inline-block;">数量</span>
					<span><input type="number" style="width: 66px;" v-model='buyNum'/>件</span>
					<span style="margin-left: 8px;">库存{{stock}}件</span>
				</div>
				<div style="margin-top: 10px;">
					<span style="width: 80px; float: left;display: inline-block;">邮费</span>
					<span>包邮 支持货到付款&ensp;<i class="glyphicon glyphicon-question-sign" style="cursor: pointer;" onclick="location.href='#'"></i></span>
				</div>
				<div class="btns">
					<div class='linkBuy' @click="buyNow()">立即购买</div>
					<div class="linkBasket" @click="addToBasket()"><i class="glyphicon glyphicon-shopping-cart"></i>&ensp;加入购物车</div>
				</div>
			</div>
		</div>
		<br/><br/>
		<!-- 底部 -->
		<jsp:include page="/inc/footer_inc.jsp" />
	</div>
</body>
<script type="text/javascript">
	var checkShoesSize = ${checkShoesSize};
	var shoes = ${shoesJson};
	shoes.checkedIndex = -1;
	$(shoes.shoesSizes).each(function(index){
		console.log(checkShoesSize);
		if(checkShoesSize == this.size){
			shoes.checkedIndex = index;
		}
	});
	shoes.buyNum = 1;
	nav.activeBrandId = ${shoes.brandId};
	var shoesDetail = new Vue({
		 el:"#shoesDetail",
		 data:shoes,
		 computed:{
			 hasRatio:function(){
				 return this.ratio<100;
			 },
			 salayPrice:function(){
				 if(this.hasRatio){
					 return (this.outPrice*this.ratio/100).toFixed(2);
				 }else{
					 return outPrice;
				 }
			 },
			 stock:function(){
				 var sum = 0;
				 if(this.checkedIndex != -1){
					 sum = this.shoesSizes[this.checkedIndex].amount;
				 }else{
					 for(var i = 0; i < this.shoesSizes.length; i++){
						 sum += this.shoesSizes[i].amount;
					 }
				 }
				 return sum;
			 }
		 },
		 methods:{
			 check:function(index){
				 this.checkedIndex = index;
				 this.buyNum = 1;
			 },
			 checkBuy:function(url){
				 var amount = this.buyNum;
				 amount = parseInt(amount) || 0;
				 if(amount == 0){
					alert("请输入有效的数量");
					return ;
				 }
				 if(this.checkedIndex < 0){
					alert("选择鞋码");
					return ;
				 }
				 var shoesId = this.shoesId;
				 var shoesSizeId = this.shoesSizes[this.checkedIndex].shoesSizeId;
				 url += "?shoesId="+shoesId+"&shoesSizeId="+shoesSizeId+"&amount="+amount;
				 if(${empty user}){
					 $.cookie("prePath",url,{path:"/"});
					 login();
				 }else{
					 window.location.href = url;
				 }
			 },
			 buyNow:function(){
				this.checkBuy("${APP_DIR}/buy/buyNow");
			 },
			 addToBasket:function(){
				 this.checkBuy("${APP_DIR}/basket/add");
			 }
		 },
		 watch:{
			 buyNum:function(newVal, oldVal){
				 if(this.stock == 0){
					 this.buyNum = 0;
					 return;
				 }
				 if(newVal == ''){
					 return;
				 }
				 if(newVal < 1){
					 this.buyNum = oldVal;
				 }
				 if(newVal > this.stock){
					 this.buyNum = oldVal;
					 alert('库存不足，剩余：'+this.stock+'件');
					 return;
				 }
				 try{
					 this.buyNum = parseInt(newVal) || 1;
				 }catch(e){
					 this.buyNum = 1;
				 }
				 
			 }
		 }
	});
</script>
</html>