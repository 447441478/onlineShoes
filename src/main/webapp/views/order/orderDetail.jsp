<%@page import="net.hncu.onlineShoes.util.*"%>
<%@page import="net.hncu.onlineShoes.domain.OrderDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html style="background-image: none;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<jsp:include page="/inc/common_js_css_inc.jsp" />
<title>我的订单</title>
<style type="text/css">
#orderDetails .item{
	height: 120px;
	box-sizing: border-box;
	padding-top: 20px;
	padding-bottom: 20px;
}
#orderDetails .item span{
	float: left;
	max-height: 80px;
	margin-left: 16px;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
#orderDetails .head{
	box-sizing: border-box;
	padding-top: 5px;
	padding-bottom: 5px;
}
#orderDetails .head span{
	float: left;
	margin-left: 16px;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
	font-weight: bold;
}
.ths th{
	text-align: center;
}
.btns button{
	margin-top: 10px;
}
</style>
</head>
<body style="background-color: #fff;background-image: none;">
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<jsp:include page="/inc/header_inc.jsp" />
		<div class="row">
			<div id="orderDetails" class="col-md-10 col-md-offset-1">
				<div class="col-md-12" style="font-weight: bold; font-size: 20px;margin-bottom: 10px;">我的订单</div>
				<div class="col-md-12">
					<table class="table table-bordered">
						<tbody v-for="(item,index) in orderDetails" :id="item.orderDetailId">
							<!-- 订单标题行 -->
							<tr class="success">
								<th colspan="6" style="font-weight: bold;color:#fd8704" >
									<span>订单编号:{{item.orderDetailId}}&emsp;</span>
									<span class="odd">订单时间:{{new Date(item.createTime).toLocaleString()}}&nbsp;&nbsp;</span>
									<span>订单状态:{{getOrderState(item)}}<span style="color:red;font-size:18px;"></span>&nbsp;&nbsp;</span>
									<span class="odd">物流编号:{{item.logisticsId == null ? "还未生成订单号":item.logisticsId}}&nbsp;</span>
								</th>
							</tr>
							<tr class="warning ths" style="text-align:center;font-size: 16px;">
								<th width="15%">图片</th>
								<th width="32%">商品</th>
								<th width="15%">价格</th>
								<th width="8%">数量</th>
								<th width="15%">小计</th>
								<th width="10%">操作</th>
							</tr>
							<tr class="active" style="text-align:center">
								<td><center><img :src="'<%=FileUtil.PRODUCT_PATH%>/' + item.shoes.imgUuid + item.shoes.imgSuffix"  width="80" height="80" /></center></td>
								<td style="text-align:left">
									<a :href="'${shoesRoot}'+item.shoesId">{{item.shoes.name}}</a>&emsp;{{item.shoesSize}}码
								</td>
								<td>￥{{item.price}}</td>
								<td>{{item.amount}}</td>
								<td><span class="subtotal"  style="font-weight: bold;color:red">￥{{item.price*item.amount}}</span></td>
								<td class="btns" style="padding: 0;">
									<button @click="applyRefund(item)" v-if="item.flag ==  <%=OrderDetail.Flag.INIT%>" class="btn btn-danger btn-sm" >申请退款</button>
									<button @click="reminedDelever(item)" v-if="item.flag ==  <%=OrderDetail.Flag.INIT%>" class="btn btn-info btn-sm">提醒发货</button>
									<button @click="confirmReceipt(item)" v-if="item.flag ==  <%=OrderDetail.Flag.DELIVERED%>" class="btn btn-info btn-sm">确认收货</button>
									<button @click="goEvalute(item)" v-if="item.flag ==  <%=OrderDetail.Flag.ACCEPTED%> || item.flag == <%=OrderDetail.Flag.COMPLETE_TRANSACTION%>" class="btn btn-info btn-sm">去评价</button>
								</td>
							</tr>
							
							<tr class="success" height="8px">
								<td colspan="1" class="su_opreate" >收货地址:</td>
								<td colspan="5" class="su_opreate" style="text-align:left;color:#ef0b0b;">{{item.name}}&emsp;{{item.addr}}&emsp;{{item.tel}}</td>
							</tr>
							
							<tr class="su_opreate" height="8px">
								<th colspan="6" >&nbsp;</th>
							</tr>
							<!-- 换行 -->
						</tbody>
					
					</table>
				</div>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">
	nav.isShow = false;
	var orderDetails = ${orderDetails};	
	var vm_orderDetails = new Vue({
		el:"#orderDetails",
		data:function(){
			return{
				orderDetails:orderDetails,
			}
		},
		methods:{
			getOrderState:function(item){
				switch(item.flag){
				case <%=OrderDetail.Flag.INIT%>:
					return "未发货";
				case <%=OrderDetail.Flag.DELIVERED%>:
					return "已发货";
				case <%=OrderDetail.Flag.ACCEPTED%>:
					return "已签收";
				case <%=OrderDetail.Flag.APPLY_REFUND%>:
					return "申请退款";
				case <%=OrderDetail.Flag.COMPLETE_REFUND%>:
					return "退款成功";
				case <%=OrderDetail.Flag.COMPLETE_TRANSACTION%>:
					return "交易完成";
				case <%=OrderDetail.Flag.EVALUATED%>:
					return "已评价";
				}
			},
			changeOrderState:function(item,newFlag){
				var data = {
						orderDetailId:item.orderDetailId,
						flag:item.flag,
						newFlag:newFlag
				};
				$.ajax({
					url:"${APP_DIR}/order/changeOrderState",
					type:"POST",
					data:data,
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							item.flag = newFlag;
						}else{
							alert("系统繁忙，请稍后再试。");
						}
					},
					error:function(){
						alert("系统繁忙，请稍后再试。");
					}
				});
			},
			applyRefund:function(item){
				this.changeOrderState(item,<%=OrderDetail.Flag.APPLY_REFUND%>);
			},
			reminedDelever:function(item){
				this.changeOrderState(item,<%=OrderDetail.Flag.DELIVERED%>);
			},
			confirmReceipt:function(item){
				this.changeOrderState(item,<%=OrderDetail.Flag.ACCEPTED%>);
			},
			goEvalute:function(item){
				
				//item.flag = <%=OrderDetail.Flag.DELIVERED%>;
			},
			
		}
	});
</script>
</html>