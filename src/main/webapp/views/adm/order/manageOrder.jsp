<%@page import="net.hncu.onlineShoes.domain.OrderDetail"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.comm.*"%>
<%@page import="net.hncu.onlineShoes.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理产品</title>
<%@ include file="/inc/admCommon_js_css.jsp.inc" %>
<!-- 引入Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
table tr th,td {
	text-align: center;
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
}
#shoesTable tbody tr:hover{
	background-color: rgb(255,255,204);
}
#shoesTable tbody tr td{
	line-height: inherit;
}
.glyphicon-ok{
	color:green;
}
.glyphicon-remove{
	color:red;
}
.options{margin: 10px 0;}
.options button{
	margin-left: 10px;
}
label {
	font-weight: normal;
}
.table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
	border-top:none; 
}
.setting span:hover{
	color:#5874d8;
}
.shoesName{
	cursor: pointer;
	margin-right: 16px;
}
.shoesName:hover{
	color: #5874d8;
}
.tabBar{
	font-size: 20px;
	margin-bottom: 2px;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #eee;
	background-color: #fff;
}
.tab{
	cursor: pointer;
	display: inline-block;
	width: 120px;
	text-align: center;
}
.tab.active{
	box-sizing: border-box;
	border-bottom: 2px solid #f00;
}
</style>
</head>
<%	
	String startTime = "2019-04-01";
	Calendar c = Calendar.getInstance();
	c.set(Calendar.HOUR_OF_DAY, 0);
	c.set(Calendar.MINUTE, 0);
	c.set(Calendar.SECOND, 0);
	String endTime = DateUtil.calendarConversionString(c);
%>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">管理订单</div>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
			<i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
		</a>
	</div>
	<div class="container-fluid">
		<div id='orderDetails'  class="row" >
			<div v-show='tip!=""' style="position: fixed;z-index:100;top:5px;" class="alert alert-warning col-md-offset-5" >
			    <a href="#" class="close" @click.stop="tip=''">&times;</a>
			    <span>{{tip}}</span>
			</div>
			<br/>
			<div class="searchs col-md-12">
				<form class="layui-form layui-col-space5">
					<div class="layui-input-inline layui-show-xs-block">
						<label for="keyWord" >产品名称：</label>
						<div class="layui-input-inline layui-show-xs-block">
	                  		<input id="keyWord" type="text"  placeholder="请输入产品名称" autocomplete="off" class="layui-input">
	                   	</div>
                   	</div>
					<div class="layui-input-inline layui-show-xs-block">
                        <select id='payMethod' name="contrller">
                        	<option value="-1">支付方式</option>	
							<option value="<%=OrderDetail.Paymethod.DEFAULT%>">货到付款</option>	
							<option value="<%=OrderDetail.Paymethod.ONLINE_PAY%>">在线支付</option>	
                        </select>
                    </div>
					<div class="layui-input-inline layui-show-xs-block">
						<span>下单时间：</span>
						<div class="layui-input-inline layui-show-xs-block">
                           <input class="layui-input" placeholder="开始日" name="startTime" id="startTime" value='<%=startTime%>' />
                       	</div>
                       	<i class="glyphicon glyphicon-resize-horizontal"></i>
                      	<div class="layui-input-inline layui-show-xs-block">
                           <input class="layui-input" placeholder="截止日" name="endTime" id="endTime" value='<%=endTime%>' />
                        </div>
					</div>
					<div class="layui-btn" @click.stop="search()">
                    	<i class="iconfont">&#xe6ac;</i>
                    	搜索
                    </div>
					<div class="layui-btn" @click.stop="exportAll()">
                    	<i class="iconfont">&#xe714;</i>
                    	数据导出
                    </div>
					<br/><br/>
				</form>
			</div>
		<div class="col-md-12" style="background-color: #e9eaee;padding: 20px;">
			<div class="col-md-12 tabBar" >
				<span class="tab" @click='checkTabIndex = index' v-for="(tab, index) in tabs" :class="index == checkTabIndex ? 'active' : ''">
				{{tab.txt}}
				</span>
			</div>
			<div class="col-md-12 table-responsive" style="background-color: #f8f9fb;">
				<table class="table table-striped" style="margin-bottom: 0;font-size: 13px;font-family: 微软雅黑;table-layout: fixed;">
					<thead>
						<tr>
							<th style="width: 200px;" >
								产品名称
							</th>
							<th style="width: 120px;">
								单价/数量
							</th>
							<th style="width: 180px;" >
								买家
							</th>
							<th style="width: 120px;" >
								实付金额
							</th>
							<th style="width: 120px;" >
								订单状态
							</th>
						</tr>
					</thead>
					<tbody v-if = 'orderDetails.length > 0'>
						<template v-for="(item,index) in orderDetails">
							<tr style="background-color: #fff;height: 13px;border-top:1px solid rgb(221,221,221);">
								<td colspan="5"></td>
							</tr>
							<tr>
								<td colspan="3" style="text-align: left;">
									下单时间：{{new Date(item.createTime).Format("yyyy-MM-dd hh:mm:ss")}}
									&emsp;
									订单编号：{{item.orderDetailId}}
									&emsp;
									快递单号：{{getLogistics(item)}}
								</td>
								<td colspan="2" class="setting">
									<span @click="updateOrder(item)" v-if="item.flag == <%=OrderDetail.Flag.INIT%>" class="glyphicon glyphicon-edit" style="cursor: pointer;margin-right: 16px;">&ensp;修改</span>
								</td>
							</tr>
							<tr style="background-color: #fff;">
								<td style="white-space:normal;text-align: left;">
									<span class="shoesName" @click="openShoes(item)">{{item.shoes.name}}</span>
									<span style="border-left: 1px solid #000;padding-left: 16px;">尺码：{{item.shoesSize}}</span>
								</td>
								<td style="vertical-align: middle;border-left: 1px solid rgb(221,221,221);">￥{{Number(item.price).toFixed(2)}} x {{item.amount}}</td>
								<td style="border-left: 1px solid rgb(221,221,221);">
									<div>
										<i class="iconfont">&#xe753;</i>&ensp;{{item.name}}
									</div>
									<div>
										<span class="glyphicon glyphicon-phone">{{item.tel}}</span>
									</div>
									<div :title="item.addr" style="cursor: pointer;">
										<span class="glyphicon glyphicon-map-marker">{{item.addr}}</span>
									</div>
								</td>
								<td style="vertical-align: middle;border-left: 1px solid rgb(221,221,221);">￥{{Number(item.price*item.amount).toFixed(2)}}</td>
								<td style="vertical-align: middle;border-left: 1px solid rgb(221,221,221);">
									{{getOrderFlag(item)}}<br/>
									<button @click.stop='sendGoods(item)' v-if="item.flag == <%=OrderDetail.Flag.INIT%>" type="button" class="btn btn-info btn-sm" style="margin-top: 6px;">发货</button>
									<button @click.stop='completeTransaction(item)' v-if="item.flag == <%=OrderDetail.Flag.ACCEPTED%>" type="button" class="btn btn-info btn-sm" style="margin-top: 6px;">交易完成</button>
									<button @click.stop='completeRefund(item)' v-if="item.flag == <%=OrderDetail.Flag.APPLY_REFUND%>" type="button" class="btn btn-info btn-sm" style="margin-top: 6px;">确认退款</button>
								</td>
							</tr>
						</template>
					</tbody>
				</table>
				<div v-if='pageInfo.total == 0'>很抱歉，没有找到符合的数据。</div>
				<products-pagination :page-info="pageInfo"></products-pagination>
			</div>
		</div>	
<!-- 模式对话框 -->
<div class="modal fade" id="myModal" style="overflow:hidden;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="dialog" style="width: 450px;height: 350px;">
		<div class="modal-content">
			<span style="position: relative;right: 20px;top: 20px;z-index: 100;" type="button" class="close" data-dismiss="modal" aria-hidden="true">
				&times;
			</span>
			<div class="modal-body" style="padding: 0px;">
				<iframe src="" style="width: 100%;height: 100%;position: fixed;" frameborder=0 scrolling="yes"></iframe>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>		
		</div>
	</div>

</body>

<script type="text/javascript">
	var tabs = [
		{
			txt:"所有订单",
			flag:-1,
		},
		{
			txt:"待发货",
			flag:<%=OrderDetail.Flag.INIT%>,
		},
		{	txt:"已发货",
			flag:<%=OrderDetail.Flag.DELIVERED%>,
		},
		{	
			txt:"已签收",
			flag:<%=OrderDetail.Flag.ACCEPTED%>,
		},
		{	
			txt:"交易完成",
			flag:<%=OrderDetail.Flag.COMPLETE_TRANSACTION%>,
		},
		{	
			txt:"退款中",
			flag:<%=OrderDetail.Flag.APPLY_REFUND%>,
		},
		{	
			txt:"已退款",
			flag:<%=OrderDetail.Flag.COMPLETE_REFUND%>,
		},
		{	
			txt:"已评价",
			flag:<%=OrderDetail.Flag.EVALUATED%>,
		},
	];
	var pageSize = 10;
	var orderDetails = ${orderDetails == null ? "[]" : orderDetails};
	var vm_orderDetails = new Vue({
		el:"#orderDetails",
		data:function(){
			return {
				orderDetails: orderDetails,
				tip:'',
				pageInfo: {
					currentPage:1,
					total:0,
					pageSize:pageSize,
				},
				tabs: tabs,
				checkTabIndex: 0,
			}
		},
		methods:{
			getOrderFlag: function(item){
				var flag = item.flag;
				switch(flag){
				case <%=OrderDetail.Flag.INIT%>:
					return "待发货";
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
			getLogistics: function(item){
				var logisticsId = item.logisticsId;
				if(logisticsId){
					return logisticsId;
				}
				return "无";
			},
			sendGoods:function(item){
				this.tip="";
				$("#myModal .modal-dialog").css({width:"350px",height:"250px"});
				$("#myModal iframe").attr("src","sendGoods?orderDetailId="+item.orderDetailId);
				$("#myModal").modal("show");
			},
			updateOrder: function(item){
				this.tip="";
				$("#myModal .modal-dialog").css({width:"600px",height:"450px"});
				$("#myModal iframe").attr("src","updateOrder?orderDetailId="+item.orderDetailId);
				$("#myModal").modal("show");
			},
			changeOrderState: function(item,newFlag){
				var data = {
						orderDetailId:item.orderDetailId,
						flag:item.flag,
						newFlag:newFlag
				};
				$.ajax({
					url:"${APP_DIR}/adm/order/changeOrderState",
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
			completeTransaction: function(item){
				this.changeOrderState(item,<%=OrderDetail.Flag.COMPLETE_TRANSACTION%>);
			},
			completeRefund:function(item){
				this.changeOrderState(item,<%=OrderDetail.Flag.COMPLETE_REFUND%>);
			},
			openShoes:function(item){
				window.open("${APP_DIR}/shoes/"+item.shoesId+"?size="+item.shoesSize);
			},
			search: function(){
				this.pageInfo.currentPage = 1;
				this.refresh();
			},
			exportAll: function(){
				var url = "${APP_DIR}/adm/order/download";
		        $.download(url,"get","");
			},
			getSearchArg:function(){
				return {
					currentPage:this.pageInfo.currentPage,
					pageSize:this.pageInfo.pageSize,
					keyWord:$("#keyWord").val(),
					payMethod:$("#payMethod").val(),
					startTime:new Date($("#startTime").val()).getTime(),
					endTime: new Date($("#endTime").val()).getTime(),
					flag: this.tabs[this.checkTabIndex].flag,
				};
			},
			refreshSearch:function(data){
				$("#keyWord").val(data.keyWord);
				$("#payMethod").val(data.payMethod);
				$("#startTime").val(new Date(data.startTime).Format("yyyy-MM-dd"));
				$("#endTime").val(new Date(data.endTime).Format("yyyy-MM-dd"));
			},
			refresh:function(){
				var that = this;
				$(function(){
					var data = that.getSearchArg();
					$.ajax({
						url:"${APP_DIR}/adm/order/get",
						data:data,
						type:"get",
						success:function(msg){
							if(msg.code == <%=Msg.Code.SUCCESS%>){
								that.pageInfo.total = msg.datas.total;
								that.orderDetails = msg.datas.orderDetails;
								that.refreshSearch(msg.datas);
							}
						}
					});
				})
			},
		},
		watch:{
			'pageInfo.currentPage':function(val){
				this.refresh();
			},
			'pageInfo.total':function(val){
				if(val != 0 && val < this.pageInfo.currentPage*this.pageInfo.pageSize){
					this.pageInfo.currentPage = parseInt((val+this.pageInfo.pageSize-1)/this.pageInfo.pageSize);
				}
			},
			checkTabIndex : function(val){
				this.refresh();
			}
		},
		created:function(){
			this.refresh();			
		}
	});
	$(function(){
		$("#myModal").on("hidden.bs.modal",function(){
			$("#myModal .modal-dialog").css({width:"450px",height:"350px"});
			/* app.refresh(); */
		});
		layui.use(['laydate', 'form'],function() {
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#startTime' //指定元素
            });

            //执行一个laydate实例
            laydate.render({
                elem: '#endTime' //指定元素
            });
        });
	})
	
	
</script>
</html>