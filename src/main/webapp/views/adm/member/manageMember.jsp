<%@page import="net.hncu.onlineShoes.domain.User"%>
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
<title>管理会员</title>
<jsp:include page="/inc/admCommon_js_css_inc.jsp" />
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
.homeSetting tbody tr:hover{
	background-color: rgb(255,255,204);
}
.homeSetting tbody tr td{
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
<body style="overflow-x: hidden; overflow-y: auto;">
	<div class="top_bar">
		<div class="top_bar_title">管理会员</div>
	</div>
	<div class="container-fluid">
		<div class="homeSetting row" id='homeSetting'>
			<div v-show='tip!=""' style="position: fixed;z-index:100;top:5px;" class="alert alert-warning col-md-offset-5" >
			    <a href="#" class="close" @click.stop="tip=''" style="margin-left: 8px;">&times;</a>
			    <span>{{tip}}</span>
			</div>
			<div class="options col-md-12">
				<button @click.stop="add()" type="button" class="btn btn-info btn-sm">添加</button>
				<button @click.stop="update()" type="button" class="btn btn-warning btn-sm">修改</button>
			</div>
			<div class="searchs col-md-12">
				<form class="form-inline">
					<div class="form-group">
						<label for="keyWord">账号：</label>
						<input type="text" class="form-control" id="keyWord" placeholder=""  />
					</div>
					<div class="form-group" style="margin-left: 8px;">
						<div class="checkbox" style="border: none;">
							<label><input id="openTime" type="checkbox" />注册时间：</label>
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
							<th width="40px;"></th>
							<th style="width: 200px;cursor: pointer;" @click="changeOrder('<%=SearchField.UserDef.USERNAME %>')">
								账号
								<i v-if="orderColum == '<%=SearchField.UserDef.USERNAME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.UserDef.USERNAME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 200px;cursor: pointer;" @click="changeOrder('<%=SearchField.UserDef.EMAIL %>')">
								邮箱
								<i v-if="orderColum == '<%=SearchField.UserDef.EMAIL %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.UserDef.EMAIL %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 180px;cursor: pointer;" @click="changeOrder('<%=SearchField.UserDef.CREATE_TIME %>')">
								注册时间
								<i v-if="orderColum == '<%=SearchField.UserDef.CREATE_TIME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.UserDef.CREATE_TIME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 200px;cursor: pointer;" @click="changeOrder('<%=SearchField.UserDef.FLAG %>')">
								权限
								<i v-if="orderColum == '<%=SearchField.UserDef.FLAG %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.UserDef.FLAG %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(user,index) in users" @click="check(index)">
							<td class="cbx"><input :id="'s-'+user.userId" style="cursor: pointer;" :class="['cbx-'+index]" type="checkbox"  /></td>
							<td>{{user.username}}</td>
							<td>{{user.email}}</td>
							<td>{{user.createTime}}</td>
							<td>{{getAuthority(user.flag)}}</td>
						</tr>
					</tbody>
				</table>
				<div v-if='pageInfo.total == 0'>很抱歉,没有找到符合的数据。</div>
				<products-pagination :page-info="pageInfo"></products-pagination>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
var pageSize = 10;
var v_homeSetting = new Vue({
	el:"#homeSetting",
	data:function(){
		return{
			pageInfo:{
				currentPage:1,
				total:${total},
				pageSize: pageSize,
			},
			users:${users},
			checkAll:false,
			timer:null,
			orderColum:"",
			isDesc:false,
			keyWord:"",
			openTime:false,
			startTime:"",
			endTime:"",
			tip: "",
		}
	},
	methods:{
		getAuthority: function(flag){
			if((flag & <%=User.Flag.FREEZE%>) == <%=User.Flag.FREEZE%>){
				return "已被冻结";
			}
			if((flag & <%=User.Flag.SUPER_MANAGER%>) == <%=User.Flag.SUPER_MANAGER%>){
				return "超级管理员";
			}
			var str = "";
			if((flag & <%=User.Flag.PRODUCT_MANAGER%>) == <%=User.Flag.PRODUCT_MANAGER%>){
				str += "产品管理员，";
			}
			if((flag & <%=User.Flag.ORDER_MANAGER%>) == <%=User.Flag.ORDER_MANAGER%>){
				str += "订单管理员，";
			}
			if((flag & <%=User.Flag.MEMBER_MANAGER%>) == <%=User.Flag.MEMBER_MANAGER%>){
				str += "会员管理员，";
			}
			if(str != ""){
				return str.substring(0,str.length-1);
			}
			if((flag & <%=User.Flag.VIP%>) == <%=User.Flag.VIP%>){
				return "超级会员";
			}
			if(flag == <%=User.Flag.FREE%>){
				return "普通会员";
			}
		},
		check:function(index){
			var $input = $("#homeSetting .cbx input").eq(index);
			var checked = $input.prop("checked");
			$("#homeSetting .cbx input").prop("checked",false);
			$input.prop("checked",!checked);
		},
		changeOrder:function(orderColum){
			this.orderColum = orderColum;
			this.isDesc = !this.isDesc ;
			this.refresh();
		},
		refresh:function(){
			var that = this;
			var data = this.getSearchArg();
			$.ajax({
				url:"${APP_DIR}/adm/member/get",
				data:data,
				type:"get",
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						that.pageInfo.total = msg.datas.total;
						that.users = msg.datas.users;
						that.refreshSearch(msg.datas);
						$("#shoesTable .cbx input:checked").prop("checked",false);
						$("#shoesTable .cbxAll").prop("checked",false);
					}
				}
			});
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
	}
});
$(function(){
	/* $("#myModal").on("hidden.bs.modal",function(){
		manageProduct.refresh();
	}); */
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