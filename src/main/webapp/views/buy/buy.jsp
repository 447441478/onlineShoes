<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.domain.OrderDetail"%>
<%@page import="net.hncu.onlineShoes.util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html style="background-image: none;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<jsp:include page="/inc/common_js_css_inc.jsp" />
<title>结算页</title>
<style type="text/css">
.receiver input{
	-webkit-box-shadow: 0 0 0px 1000px #fff inset;
	-moz-box-shadow: 0 0 0px 1000px #fff inset;
	-ms-box-shadow: 0 0 0px 1000px #fff inset;
    border-radius: unset;
    outline:none;
    text-align: center;
}
.receiver .item{
	border: none;
	border-bottom: 1px solid;
}
.receiver .addr{
	width: 400px;
}
</style>
</head>
<body style="background-color: #fff;background-image: none;">
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<jsp:include page="/inc/header_inc.jsp" />
		<div class="col-md-10 col-md-offset-1" id="order">
			<div class="col-md-12" style="color: #666;height: 42px;line-height: 42px;font-size: 16px;">
				填写并核对订单信息
			</div>
			<div class="col-md-12 receiver" style="border: 1px solid #e0e0e0;" >
				<br>
				<b>收货人信息</b><br><br>
				&emsp;&emsp;姓名:&ensp;<input class="item" type="text" name="name" v-model="name" />
				&emsp;&emsp;电话:&ensp;<input class="item" type="text" name="tel" v-model="tel" /><br><br>
				&emsp;&emsp;地址:&ensp;<input class="item addr" type="text" name="addr" v-model="addr" /><br><br>
			</div>
			<div class="col-md-12 order" style="border: 1px solid #e0e0e0;border-top: none;" >
				<br>
				<b>送货清单</b><br><br>
				<div class="col-md-10 col-md-offset-1 orderDetail" style="margin-bottom: 10px;" v-for="(item,index) in orderDetails">
					<img alt="" :src="'<%=FileUtil.PRODUCT_PATH%>/' + item.imgUuid + item.imgSuffix" style="height: 80px;width: 80px;">
					&emsp;{{item.name}}&emsp;{{item.size}}码&emsp;￥{{getSalayPrice(item)}}&emsp;x{{item.buyNum}}&emsp;￥{{getTotalPrice(item)}}
				</div>
				<div class="col-md-2 col-md-offset-9">应付款：￥{{total}}</div>
			</div>
			<div class="col-md-12 payMethod" style="border: 1px solid #e0e0e0;border-top: none; margin-bottom: 10px;" >
				<br>
				<b>支付方式</b><br><br>
					<div style="display: inline-block;float: left;">
						<label><input type="radio" name="payMethod" value='default' v-model='payMethod'>货到付款</label>&emsp;
						<label><input type="radio" name="payMethod" value='online' v-model='payMethod'>在线支付</label>
					</div>
				<div v-if="isShowPayDetail" style="display: inline-block;float: left; text-align: center;">
					<img :alt="payDetailAlt" :src="payDetailSrc" style="width: 160px;height: 160px;"><br>
					&emsp;<label><input type="radio" name="payDetail" value='wx' v-model='payDetail'>微信</label>&emsp;
					<label><input type="radio" name="payDetail" value='al' v-model='payDetail'>支付宝</label><br>
				</div>
			</div>
			<div @click="submit()" class="col-md-2 col-md-offset-10" style="margin-bottom: 10px;background: #f00;color: #fff;height: 42px;line-height: 42px; font-size: 18px; text-align: center; width: 108px;cursor: pointer;">提交订单</div>
		</div>	
	</div>
</body>
<script type="text/javascript">
	nav.isShow = false;
	var orderDetails = ${orderJson};
	var vm_order = new Vue({
		el:"#order",
		data:function(){
			return{
				orderDetails:orderDetails,
				payMethod:"default",
				payDetail:'wx',
				name:"",
				tel:"",
				addr:"",
			}
		},
		computed:{
			total:function(){
				var tatal = 0;
				var that = this;
				for(var i = 0; i < this.orderDetails.length; i++){
					var item = this.orderDetails[i];
					tatal += Number(that.getTotalPrice(item));
				}
				return Number(tatal).toFixed(2);
			},
			isShowPayDetail:function(){
				return this.payMethod != "default";
			},
			payDetailSrc:function(){
				var pre = "${APP_DIR}/img/pay/";
				switch(this.payDetail){
				case "wx":
					return pre + "wx.png";
				case "al":
					return pre + "al.png";
				}
				return "";
			},
			payDetailAlt:function(){
				switch(this.payDetail){
				case "wx":
					return "微信";
				case "al":
					return "支付宝";
				}
				return "";
			},
		},
		watch:{
			
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
			submit:function(){
				var that = this;
				var name = $.trim(that.name);
				var tel = $.trim(that.tel);
				var addr = $.trim(that.addr);
				if(name == ""){
					alert("收货人姓名不能为空.");
					return;
				}
				if(tel == ""){
					alert("收货人电话不能为空.");
					return;
				}
				var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
				if(!reg.test(tel)){
					alert("请输入正确的电话号码.");
					return;
				}
				
				if(addr == ""){
					alert("收货人地址不能为空.");
					return;
				}
				var payMethod = this.payMethod;
				var payDetail = this.payDetail;
				var flag = 0x0;
				if(payMethod == "online"){
					flag |= <%=OrderDetail.Paymethod.ONLINE_PAY%>;
					if(payDetail == 'wx'){
						flag |= <%=OrderDetail.Paymethod.WX_PAY%>;
					}else if(payDetail == 'al'){
						flag |= <%=OrderDetail.Paymethod.AL_PAY%>;
					}
				}
				var data = {};
				data.name = name;
				data.tel = tel;
				data.addr = addr;
				data.payMethod = flag;
				$.ajax({
					url:"${APP_DIR}/buy/pay",
					type:"POST",
					data:data,
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							alert(msg.info);
						}else{
							alert("系统繁忙...");
						}
						location.reload();
					},
				});				
				
			}
		},
	});
</script>
</html>