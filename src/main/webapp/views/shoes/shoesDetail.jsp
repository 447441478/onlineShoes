<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<title>鲸鱼鞋店</title>
<%@ include file="/inc/common_js_css.jsp.inc" %>
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
.comment{
	margin-top: 20px;
}
.comment .tabBar{
	height: 48px;
	font-size: 18px;
	line-height: 48px;
	background: #f5f5f5;
	border-bottom: 3px solid #fff;
}
.comment .tabBar .tab{
	color: #f00;
}
.comment .item.check{
	border: 2px solid #f00;
}
.comment .item{
	background: #f5f5f5;
	padding-bottom: 8px;
	padding-top:6px;
	border-bottom: 1px solid #eee;
}
</style>
<title>产品详情</title>
</head>
<body>
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<%@ include file="/inc/header.jsp.inc" %>
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
		<div class="row comment"  id="comments">
			<div class="col-md-12 tabBar">
				<span class="tab">产品评论</span>
			</div>
		<template v-if='showComment'>
			<div class="col-md-12 item" v-for="item in comments" :class="commentId == item.commentId ? 'check':''">
				<span style="width: 70px;text-align: left;display: inline-block;">
					<i class="glyphicon glyphicon-user" style="color: #f00;"></i>
					{{item.userName}}
				</span>
				<span style="color: #828282;">{{new Date(item.createTime).toLocaleString()}}</span>
				<pre style="color: #555;border: none;">{{item.content}}</pre>
			</div>
		</template>
			<div class="col-md-12" v-else='!showComment' style="background: #f5f5f5;padding-bottom: 8px;padding-top:6px;border-bottom: 1px solid #eee;">
				目前还没有人评论哟。
			</div>
			<template v-if='canComment'>
				<div class="col-md-8 col-md-offset-2" style="text-align: center;margin-top: 20px;">
					<textarea rows="5" cols="100" style="border: #ddd 1px solid;border-radius: 5px;" v-model='content' placeholder="产品评论"></textarea>
				</div>
				<div class="col-md-2 col-md-offset-5" style="text-align: center;margin-top: 20px;">
					<button type="button" class="btn btn-danger" @click='commitComment()'>提交评论</button>
				</div>
			</template>
		</div>
		<br/><br/>
		<!-- 底部 -->
		<%@ include file="/inc/footer.jsp.inc" %>
	</div>
</body>
<script type="text/javascript">
	
	var checkShoesSize = ${checkShoesSize};
	var shoes = ${shoesJson};
	shoes.checkedIndex = -1;
	$(shoes.shoesSizes).each(function(index){
		if(checkShoesSize == this.size){
			shoes.checkedIndex = index;
		}
	});
	shoes.buyNum = 1;
	nav.activeBrandId = ${shoes.brandId};
	var v_shoesDetail = new Vue({
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
	
	var commentId = ${commentId};
	var canComment = ${canComment};
	var comments = ${comments};
	var v_comments = new Vue({
		el: "#comments",
		data:function(){
			return {
				canComment: canComment,
				comments: comments,
				content: '',
				commentId: commentId,
			}
		},
		computed:{
			showComment: function(){
				return !!comments && comments.length > 0;
			}
		},
		methods:{
			commitComment: function(){
				var content = this.content;
				if(!content){
					alert("评论内容不能为哟");
					return ;
				}
				if(content.length > (1<<16)){
					alert("评论内容长度不能超过65535个字符哟");
					return ;
				}
				var data = {
					orderDetailId: ${orderDetailId},
					content: content,
				};
				$.ajax({
					url:"${APP_DIR}/comment/commit",
					type:"POST",
					data:data,
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							window.location.reload();
						}else{
							alert("系统繁忙，请稍后再试。");
						}
					},
					error:function(){
						alert("系统繁忙，请稍后再试。");
					}
				});
			},
		}
	});
</script>
</html>