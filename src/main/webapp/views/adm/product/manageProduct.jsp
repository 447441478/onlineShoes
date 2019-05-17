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
<jsp:include page="/inc/admCommon_js_css_inc.jsp"/>
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
</style>
</head>
<%
	Calendar c = Calendar.getInstance();
	c.add(Calendar.DAY_OF_MONTH, -1);
	c.set(Calendar.HOUR_OF_DAY, 0);
	c.set(Calendar.MINUTE, 0);
	c.set(Calendar.SECOND, 0);
	String startTime = DateUtil.dateTimeConversionString(c.getTime());
	c.add(Calendar.DAY_OF_MONTH, 2);
	String endTime = DateUtil.timeConversionString(c.getTime().getTime()-1000);
%>
<script type="text/javascript">
$.fn.datebox.defaults.parser = function(s){
	var t = Date.parse(s);
	if (!isNaN(t)){
		return new Date(t);
	} else {
		return new Date();
	}
}
</script>
<body style="overflow-x:hidden;overflow-y:auto;margin: 0 !important;">
	<div class="top_bar">
		<div class="top_bar_title">管理产品</div>
	</div>
	<div class="container-fluid">
		<div id='shoesTable'  class="row" >
			<div v-show='tip!=""' style="position: fixed;z-index:100;top:5px;" class="alert alert-warning col-md-offset-5" >
			    <a href="#" class="close" @click.stop="tip=''" style="margin-left: 8px;">&times;</a>
			    <span>{{tip}}</span>
			</div>
			<div class="options col-md-12">
				<button @click.stop="add()" type="button" class="btn btn-info btn-sm">添加</button>
				<button @click.stop="del()" type="button" class="btn btn-danger btn-sm">批量删除</button>
				<button @click.stop="update()" type="button" class="btn btn-warning btn-sm">修改</button>
			</div>
			<div class="searchs col-md-12">
				<form class="form-inline">
					<div class="form-group">
						<label for="keyWord">产品名称:</label>
						<input type="text" class="form-control" id="keyWord" placeholder="产品名称"  />
					</div>
					<div class="form-group">
						<div class="checkbox" style="border: none;">
							<label><input id="openTime" type="checkbox" />录入时间:</label>
						</div>
						<input class="easyui-datebox" id="startTime" name="startTime" data-options="editable:false" value='<%=startTime%>' style="width:110px">
						<i class="glyphicon glyphicon-resize-horizontal"></i>
						<input class="easyui-datebox" id="endTime" name="endTime" data-options="editable:false" value='<%=endTime%>' style="width:110px">
					</div>
					<div @click.stop="refresh()" class="btn btn-default" style="margin-left: 8px;">搜索</div>
				</form>
			</div>
			<div class="col-md-12 table-responsive">
				<table class="table table-striped" style="margin-bottom: 0;font-size: 13px;font-family: 微软雅黑;table-layout: fixed;">
					<thead>
						<tr>
							<th width="40px;"><input style="cursor: pointer;" class="cbxAll" type="checkbox" @click.stop="checkChangeAll()"/></th>
							<th style="width: 300px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.NAME %>')">
								产品名称
								<i v-if="orderColum == '<%=SearchField.ShoesDef.NAME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.NAME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 120px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.BRAND_NAME %>')">
								产品品牌
								<i v-if="orderColum == '<%=SearchField.ShoesDef.BRAND_NAME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.BRAND_NAME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 180px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.ONLINE_TIME %>')">
								录入时间
								<i v-if="orderColum == '<%=SearchField.ShoesDef.ONLINE_TIME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.ONLINE_TIME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 120px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.SALE_PRICE %>')">
								售价
								<i v-if="orderColum == '<%=SearchField.ShoesDef.SALE_PRICE %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.SALE_PRICE %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 120px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.STOCK %>')">
								库存
								<i v-if="orderColum == '<%=SearchField.ShoesDef.STOCK %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.STOCK %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 80px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.ShoesDef.STOCK_OUT %>')">
								上架
								<i v-if="orderColum == '<%=SearchField.ShoesDef.STOCK_OUT %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.ShoesDef.STOCK_OUT %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(shoes,index) in shoess" @click="check(index)">
							<td class="cbx"><input :id="'s-'+shoes.id" style="cursor: pointer;" :class="['cbx-'+index]" type="checkbox"  @click.stop="checkChange()"/></td>
							<td><a style="cursor: pointer;" @click="openShoes(shoes.id)">{{shoes.name}}</a></td>
							<td>{{shoes.brandName}}</td>
							<td>{{shoes.onlineTime}}</td>
							<td>{{shoes.salePrice.toFixed(2)}}</td>
							<td>{{shoes.stock}}</td>
							<td>
								<i @click="changeStockOut(index)" style="cursor: pointer;" :class="['glyphicon',{'glyphicon-ok':shoes.stockOut==0,'glyphicon-remove':shoes.stockOut==1}]"></i>
							</td>
							<td>
								<div  @click.stop="del(shoes.id)" style="color: #f00;cursor: pointer;" class="glyphicon glyphicon-trash" data-toggle="tooltip" title="删除"></div>
							</td>
						</tr>
					</tbody>
				</table>
				<div v-if='pageInfo.total == 0'>很抱歉,没有找到符合的数据。</div>
				<products-pagination :page-info="pageInfo"></products-pagination>
			</div>
<!-- 模式对话框 -->
<div class="modal fade" id="myModal" style="overflow:hidden;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="dialog" style="width: 900px;height: 450px;">
		<div class="modal-content">
			<span style="position: relative;right: 25px;top: 25px;z-index: 100;" type="button" class="close" data-dismiss="modal" aria-hidden="true">
				&times;
			</span>
			<div class="modal-body" style="width: 900px;height: 450px;padding: 0px;">
				<iframe src="" style="width: 100%;height: 100%;position: fixed;" frameborder=0 scrolling="yes"></iframe>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>		
		</div>
	</div>

</body>

<script type="text/javascript">
	
	var pageSize = 10;
	var manageProduct = new Vue({
		el:"#shoesTable",
		data:function(){
			return{
				pageInfo:{
					currentPage:1,
					total:0,
					pageSize:pageSize,
				},
				shoess:[],
				checkAll:false,
				tip:"",
				timer:null,
				orderColum:"",
				isDesc:false,
				keyWord:"",
				openTime:false,
				startTime:"",
				endTime:"",
			}
		},
		methods:{
			openShoes: function(shoesId){
				window.open("${APP_DIR}/shoes/"+shoesId);;
			},
			checkChange:function(){
				$cbxs = $("#shoesTable .cbx input");
				var len = $cbxs.length;
				$cbxs.each(function(){
					if(this.checked){
						len--;
					}
				});
				if(len == 0){
					$("#shoesTable .cbxAll").prop("checked",true);
				}else{
					$("#shoesTable .cbxAll").prop("checked",false);
				}
			},
			checkChangeAll:function(){
				var val = $("#shoesTable .cbxAll").prop("checked");
				$("#shoesTable .cbx input").prop("checked",val);
			},
			changeStockOut:function(index){
				var stockOut = this.shoess[index].stockOut;
				if(stockOut == 1){
					stockOut = 0;
				}else{
					stockOut = 1;
				}
				var shoesId = this.shoess[index].id;
				var that = this;
				$.ajax({
					url:"${APP_DIR}/adm/product/update?shoesId="+shoesId,
					data:{
						stock_out:stockOut
					},
					type:"post",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.refresh();
						}
					}
				});
			},
			check:function(index){
				var $input = $("#shoesTable .cbx input").eq(index);
				$input.prop("checked",!$input.prop("checked"));
			},
			update:function(){
				this.tip="";
				$cbxs = $("#shoesTable .cbx input:checked");
				if($cbxs.length == 0){
					this.tip="请选择要修改的记录";
				}else if($cbxs.length == 1){
					var shoesId = $cbxs[0].id.substring(2);
					$("#myModal iframe").attr("src","update?shoesId="+shoesId);
					$('#myModal').modal("show");
				}else{
					this.tip = "无法同时修改多条记录";
				}
			},
			del:function(id){
				var shoesIds = [];
				if(id){
					if(!confirm("确定删除？")){
						$("#s-"+id).prop("checked",false);
						return;
					}
					shoesIds.push(id);
				}else{
					this.tip="";
					$cbxs = $("#shoesTable .cbx input:checked");
					if($cbxs.length == 0){
						this.tip="请选择删除的记录";
					}else{
						if(!confirm("确定删除？")){
							$cbxs.prop("checked",false);
							$("#shoesTable .cbxAll").prop("checked",false);
							return;
						}
						var shoesIds=[];
						$cbxs.each(function(){
							var shoesId = this.id.substring(2);
							shoesIds.push(shoesId);
						});
					}
				}
				var arr = [-1,0,1];
				var that = this;
				$.ajax({
					url:"${APP_DIR}/adm/product/del",
					type:"POST",
					data:{
						shoesIds:shoesIds,
					},
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.refresh();
							that.tip = msg.info;
						}
					}
				});
				
			},
			add:function(){
				this.tip="";
				$("#myModal iframe").attr("src","add");
				$("#myModal").modal("show");
			},
			refresh:function(){
				var that = this;
				var data = this.getSearchArg();
				$.ajax({
					url:"${APP_DIR}/adm/product/get",
					data:data,
					type:"get",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.pageInfo.total = msg.datas.total;
							that.shoess = msg.datas.shoesList;
							that.refreshSearch(msg.datas);
							$("#shoesTable .cbx input:checked").prop("checked",false);
							$("#shoesTable .cbxAll").prop("checked",false);
						}
					}
				});
			},
			changeOrderBy: function(orderColum){
				this.orderColum = orderColum;
				this.isDesc = !this.isDesc ;
				this.refresh();
			},
			getSearchArg:function(){
				return {
					currentPage:this.pageInfo.currentPage,
					pageSize:this.pageInfo.pageSize,
					orderColum:this.orderColum,
					isDesc:this.isDesc,
					keyWord:$("#keyWord").val(),
					openTime:$("#openTime").prop("checked"),
					startTime:new Date($("#startTime").datebox("getValue")).getTime(),
					endTime: new Date($("#endTime").datebox("getValue")).getTime(),
				};
			},
			refreshSearch:function(data){
				$("#keyWord").val(data.keyWord);
				$("#openTime").prop("checked",data.openTime);
				try{
					$("#startTime").datebox('setValue', data.startTime);
					$("#endTime").datebox('setValue', data.endTime);
				}catch(e){}
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
			tip:function(val){
				var that = this;
				if(val != ""){
					clearTimeout(that.timer);
					that.timer = setTimeout(function(){
						that.tip="";
					},1500);
				} 
			},
		},
		created:function(){
			var that = this;
			var data = {
				currentPage:this.pageInfo.currentPage,
				pageSize:this.pageInfo.pageSize,
			};
			$.ajax({
				url:"${APP_DIR}/adm/product/get",
				data:data,
				type:"get",
				asycn:false, //同步请求
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						that.pageInfo.total = msg.datas.total;
						that.shoess = msg.datas.shoesList;
						that.refreshSearch(msg.datas);
					}
				}
			});
			
		}
	});
	
	$(function(){
		$("#myModal").on("hidden.bs.modal",function(){
			manageProduct.refresh();
		});
		$('#startTime').datebox({
		    formatter: function(date){
		    	return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
		    },
		    parser: function(date){ 
		    	return new Date(Date.parse(date.replace(/-/g,"/")));
		    },
		    onSelect:function(date){
		    	if(new Date($('#endTime').datebox("getValue")) - date < 0){
		    		manageProduct.tip = "开始时间不能大于结束时间";
		    		var oldDate = $(this).datebox("getValue");
		    		setTimeout(function(){
		    			$("#startTime").datebox('setValue', oldDate);
		    		});
		    	}
		    }
		});
		$('#endTime').datebox({
		    formatter: function(date){ 
		    	return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
		    },
		    parser: function(date){ 
		    	return new Date(Date.parse(date.replace(/-/g,"/")));
		    },
		    onSelect:function(date){
		    	if(date - new Date($('#startTime').datebox("getValue")) < 0){
		    		manageProduct.tip = "结束时间不能小于开始时间";
		    		var oldDate = $(this).datebox("getValue");
		    		setTimeout(function(){
		    			$("#endTime").datebox('setValue', oldDate);
		    		});
		    	}
		    }
		});
		$("[data-toggle='tooltip']").tooltip();
	})
	
	
</script>
</html>