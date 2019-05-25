<%@page import="net.hncu.onlineShoes.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html style="background-image: none;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<%@ include file="/inc/common_js_css.jsp.inc" %>
<title>购物车</title>
<style type="text/css">
#car .item{
	height: 120px;
	box-sizing: border-box;
	padding-top: 20px;
	padding-bottom: 20px;
}
#car .item span{
	float: left;
	max-height: 80px;
	margin-left: 16px;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
#car .checked{
	background: #fff4e8;
}
</style>
</head>
<body style="background-color: #f5f5f5;background-image: none;">
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<%@ include file="/inc/header.jsp.inc" %>
		<br/>
		<div id="car" class="row" >
			<div class="col-md-10 col-md-offset-1" style="border: 2px solid #f0f0f0; background-color: #fff; ">
				<div class="col-md-12" style="font-size: 20px; border-bottom: 2px solid #f0f0f0;">
					<span style="display: inline-block; padding: 8 5px;">我的购物车</span>
				</div>
				<div class="col-md-12" v-if="carInfo.length == 0">
					您的购物车空空如也，<a href="${APP_DIR}">去逛逛？</a>
				</div>
				<div class="col-md-12 item" v-else v-for="(item,index) in carInfo" style="border-bottom: 2px solid #f0f0f0;">
					<span >
						<input class="J_ck" type="checkbox" @change="changeCheck(index)">
					</span>
					<span >
						<img alt="" :src="'<%=FileUtil.PRODUCT_PATH%>/' + item.imgUuid + item.imgSuffix" style="height: 80px;width: 80px;">
					</span>
					<span style="width: 180px;">
						<a :href="'${shoesRoot}'+item.shoesId">{{item.name}}</a>
					</span>
					<span style="width: 60px;">{{item.size}}码</span>
					<span style="width: 60px;">￥{{getSalayPrice(item)}}</span>
					<span style="width: 120px;">
						<input style="width: 80px;" type="number" v-model="item.buyNum" @blur="changeBuyNum(item)"/>
						<div style="margin-top: 5px; color: #f00;" v-if="item.buyNum>item.amount">库存剩余{{item.amount}}件</div>
					</span>
					<span style="width: 100px;overflow:hidden;text-overflow:ellipsis; cursor: pointer;" :title="'￥'+getTotalPrice(item)">￥{{getTotalPrice(item)}}</span>
					<span style="width: 60px;"><a href="javascripit:;" @click="remove(index)">移除</a></span>
				</div>
				<div class="col-md-12" style="height: 50px;position: relative;">
					<div style="float: left;height: 18px;line-height: 18px;padding: 16px 0 16px 9px;white-space: nowrap;">
						<input class="J_ckAll" @change="changeCheckAll()" type="checkbox" />&ensp;全选
					</div>
					<div @click="goBuy()" style="float:right;cursor:pointer;width: 94px;height: 50px;background: #e64347;color: #fff;font-size: 18px;line-height: 50px;text-align: center;">去结算</div>
					<div style="float:right;height: 18px;line-height: 18px;padding: 16px 9px 16px 9px;white-space: nowrap;">总价：<em style="font-size: 16px;color: #E2231A;font-weight: 700;">￥{{total}}</em></div>
				</div>
			</div>
		</div>	
		<br/>
		<!-- 底部 -->
		<%@ include file="/inc/footer.jsp.inc" %>
	</div>
</body>
<script type="text/javascript">
	$(function () {
		$(".funs .shoppingCar").addClass("layui-this");
	})
	var carInfo = ${carInfo};
	var car = new Vue({
		el:"#car",
		data:function(){
			return {
				carInfo:carInfo,
				total:Number(0).toFixed(2)
			}
		},
		computed:{
			watchCarInfo:function(){
				var that = this;
				var arr = [];
				for(index in that.carInfo){
					var obj = {};
					Object.keys(that.carInfo[index]).forEach(function(key){
						obj[key] = that.carInfo[index][key];
					});
					arr.push(obj);
				}
				return arr;
			},
		},
		watch:{
			watchCarInfo:{
				handler:function(newArr,oldArr){
					var that = this;
					var reg = /^(\d{0,11}|0)?$/;
					$(newArr).each(function(index){
						if(!reg.test(newArr[index].buyNum)){
							that.carInfo[index].buyNum = oldArr[index].buyNum;
						}
						if(newArr[index].buyNum == ''){
							that.carInfo[index].buyNum = 0;
						}
						that.carInfo[index].buyNum = Number(that.carInfo[index].buyNum);
					});
                },
                deep: true
			}
		},
		methods:{
			getSalayPrice:function(item){
				if(item.ratio<100){
					return (item.outPrice*item.ratio/100).toFixed(2);
				}else{
					return item.outPrice
				}
			},
			getTotalPrice:function(item){
				return (this.getSalayPrice(item) * item.buyNum).toFixed(2);
			},
			remove:function(index){
				var url = "${APP_DIR}/basket/del?shoesId="+this.carInfo[index].shoesId+"&shoesSizeId="+this.carInfo[index].shoesSizeId;
				var that = this;
				$.ajax({
					url:url,
					type:"get",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.carInfo.splice(index,1);
						}else{
							alert("系统繁忙");
							window.location.reload();
						}
					},
				});
				
			},
			changeCheck:function(index){
				var checked = $("#car .item .J_ck").eq(index).prop("checked");
				if(checked){
					$("#car .item").eq(index).addClass("checked");
				}else{
					$("#car .item").eq(index).removeClass("checked");
				}
				var ckNum = 0;
				$("#car .item .J_ck").each(function(){
					if(this.checked){
						ckNum++;
					}
				});
				$("#car .J_ckAll").prop("checked",ckNum == $("#car .item .J_ck").length);
				this.total = this.getTotal();
			},
			changeCheckAll:function(){
				var checked = $("#car .J_ckAll").prop("checked");
				$("#car .item .J_ck").each(function(index){
					this.checked = checked;
					if(checked){
						$("#car .item").eq(index).addClass("checked");
					}else{
						$("#car .item").eq(index).removeClass("checked");
					}
				});
				this.total = this.getTotal();
			},
			getTotal:function(){
				var tatal = 0;
				var that = this;
				$("#car .item .J_ck").each(function(index){
					if(this.checked){
						var item = that.carInfo[index];
						tatal += Number(that.getTotalPrice(item));
					}
				});
				return Number(tatal).toFixed(2);
			},
			goBuy:function(){
				var url = "${APP_DIR}/buy/fromBasket?1=1";
				var that = this;
				var canBuy = false;
				$("#car .item .J_ck").each(function(index){
					if(this.checked){
						url += "&shoesId="+that.carInfo[index].shoesId;
						url += "&shoesSizeId="+that.carInfo[index].shoesSizeId;
						url += "&buyNum="+that.carInfo[index].buyNum;
						canBuy = true;
					}
				});
				if(canBuy){
					window.location.href = url;
				}else{
					alert("请至少选择一件商品哟~");
				}
			},
			changeBuyNum:function(item){
				if(item.buyNum == 0){
					alert("购买数量不能为0");
					item.buyNum = 1;
				}
				if(item.buyNum > item.amount){
					alert("购买数量不能为超过库存");
					item.buyNum = item.amount;
				}
			},
		}
	});
</script>
</html>