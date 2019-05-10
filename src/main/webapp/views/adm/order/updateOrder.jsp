<%@page import="net.hncu.onlineShoes.domain.OrderDetail"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.comm.*"%>
<%@page import="net.hncu.onlineShoes.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理产品</title>
<jsp:include page="/inc/admCommon_js_css_inc.jsp" />
<!-- 引入Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
.orderDetail .item{
    margin-bottom: 20px;
}
.orderDetail .item .title{
    font-size: 13px;
    color: #333;
    display: inline-block;
    vertical-align: middle;
    margin-right: 15px;
}
.orderDetail .item .tip{
    font-size: 12px;
    color: #c9302c;
    display: inline-block;
    vertical-align: middle;
    margin-left: 13px;
}
</style>
</head>
<script type="text/javascript">
	
</script>
<body  style="overflow-x: hidden; overflow-y: auto;">
	<div class="top_bar">
		<div class="top_bar_title">修改订单</div>
	</div>
	<div id="orderDetail">
	<div class="orderDetail"  style="padding-top: 35px; padding-left: 35px;">
		<div class="item">
			<span class="title">名称：</span>
			{{orderDetail.shoes.name}}
			<span class="title" style="margin-left: 16px;padding-left: 16px;border-left: 1px solid ;">尺码：</span>
			{{orderDetail.shoesSize}}
		</div>
		<div class="item">
			<span class="title">价格：</span>
			￥{{Number(orderDetail.price).toFixed(2)}}
			<span class="title" style="margin-left: 16px;padding-left: 16px;border-left: 1px solid ;">数量：</span>
			{{orderDetail.amount}}
			<span class="title" style="margin-left: 16px;padding-left: 16px;border-left: 1px solid;">小计：</span>
			{{Number(orderDetail.price * orderDetail.amount).toFixed(2)}}
		</div>
		<hr/>
		<div class="item">
			<span class="title">姓名：</span>
			<input v-model="orderDetail.name"/>
			<span class='tip'>{{nameTip}}</span>
		</div>
		<div class="item">
			<span class="title">手机：</span>
			<input v-model="orderDetail.tel"/>
		</div>
		<div class="item">
			<span class="title">地址：</span>
			<input v-model="orderDetail.addr"/>
		</div>
	</div>
	<div style="text-align: center; margin-top: 50px;">
		<button type="button" class="btn btn-primary btn-sm" :disabled='!canSave' style="margin-right: 28px;" @click="save()">确 定</button>
		<button type="button" class="btn btn-danger btn-sm" @click="cancel()">取 消</button>
	</div>
	</div>
</body>

<script type="text/javascript">
	var orderDetail = ${orderDetail};
	var vm_orderDetail = new Vue({
		el:"#orderDetail",
		data:function(){
			return{
				orderDetail: orderDetail,
				nameTip:'',
				telTip:'',
				addrTip:'',
			}
		},
		computed:{
			canSave:function(){
				if(!this.nameTip && !this.telTip && !this.telTip){
					return true;
				}else{
					return false;
				}
			}
		},
		watch:{
			'orderDetail.name':function(val){
				if(!val){
					this.nameTip = '姓名不能为空';
					return;
				}
				if(val.length > 30){
					this.nameTip = '姓名不能超过30个字符';
					return;
				}
				this.nameTip = '';
			},
			'orderDetail.tel':function(val){
				if(!val){
					this.telTip = '手机不能为空';
					return;
				}
				if(val.length > 30){
					this.telTip = '手机不能超过20个字符';
					return;
				}
				this.telTip = '';
			},
			'orderDetail.addr':function(val){
				if(!val){
					this.addrTip = '地址不能为空';
					return;
				}
				if(val.length > 30){
					this.addrTip = '地址不能超过255个字符';
					return;
				}
				this.addrTip = '';
			},
		},
		methods:{
			cancel: function(){
				$(window.parent.document).find("#myModal").click();
			},
			save: function(){
				if(!confirm("确定修改？")){
					return ;
				}
				var data={
					orderDetailId: this.orderDetail.orderDetailId,
					name: this.orderDetail.name,
					tel: this.orderDetail.tel,
					addr: this.orderDetail.addr,
				};
				$.ajax({
					url: "${APP_DIR}/adm/order/updateOrder",
					type: "POST",
					data: data,
					success: function(){
						window.parent.location.reload();
					},
					error: function(){
						$(window.parent.document).find("#myModal").click();
					}
				});
			},
		}
	});
</script>
</html>