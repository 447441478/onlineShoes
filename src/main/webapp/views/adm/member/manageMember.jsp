<%@page import="net.hncu.onlineShoes.domain.User"%>
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
<title>管理会员</title>
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
.searchs{margin: 10px 0;}
.glyphicon-edit{
	cursor: pointer;
}
.glyphicon-edit:hover{
	color:#5874d8;
}
label{
font-weight: normal;
}
</style>
</head>
<%
	Calendar c = Calendar.getInstance();
	c.add(Calendar.DAY_OF_MONTH, -1);
	c.set(Calendar.HOUR_OF_DAY, 0);
	c.set(Calendar.MINUTE, 0);
	c.set(Calendar.SECOND, 0);
	String startTime = DateUtil.calendarConversionString(c);
	c.add(Calendar.DAY_OF_MONTH, 1);
	String endTime = DateUtil.calendarConversionString(c);
%>
<body style="overflow-x: hidden; overflow-y: auto;">
	<div class="top_bar">
		<div class="top_bar_title">管理会员</div>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
			<i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
		</a>
	</div>
	<div class="container-fluid">
		<div class="homeSetting row" id='homeSetting'>
			<div v-show='tip!=""' style="position: fixed;z-index:100;top:5px;" class="alert alert-warning col-md-offset-5" >
			    <a href="#" class="close" @click.stop="tip=''" style="margin-left: 8px;">&times;</a>
			    <span>{{tip}}</span>
			</div>
			<div class="searchs col-md-12">
				<form class="layui-form layui-col-space5">
					<div class="layui-input-inline layui-show-xs-block">
						<label for="keyWord" >账号：</label>
						<div class="layui-input-inline layui-show-xs-block">
	                  		<input id="keyWord" type="text"  placeholder="请输入产品名称" autocomplete="off" class="layui-input">
	                   	</div>
                   	</div>
					<div class="layui-input-inline layui-show-xs-block">
						<input id="openTime" type="checkbox" lay-skin="primary" title="注册时间：" />
						<div class="layui-input-inline layui-show-xs-block">
                           <input class="layui-input" placeholder="开始日" name="startTime" id="startTime" value='<%=startTime%>' />
                       	</div>
						<i class="glyphicon glyphicon-resize-horizontal"></i>
                      	<div class="layui-input-inline layui-show-xs-block">
                           <input class="layui-input" placeholder="截止日" name="endTime" id="endTime" value='<%=endTime%>' />
                        </div>
					</div>
					<div class="layui-btn" @click.stop="refresh()">
                    	<i class="iconfont">&#xe6ac;</i>
                    	搜索
                    </div>
				</form>
			</div>
			<div class="col-md-12 table-responsive">
				<table class="table table-striped" style="margin-bottom: 0;font-size: 13px;font-family: 微软雅黑;table-layout: fixed;">
					<thead>
						<tr>
							<th width="80px;">操作</th>
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
						<tr v-for="(user,index) in users" >
							<td class="cbx">
								<span class="glyphicon glyphicon-edit" @click="update(user.userId)">修改</span>
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
		update: function(userId){
			$("#myModal .modal-dialog").css({width:"600px",height:"450px"});
			$("#myModal iframe").attr("src","update?userId="+userId);
			$('#myModal').modal("show");
		},
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
				startTime:new Date($("#startTime").val()).getTime(),
				endTime: new Date($("#endTime").val()).getTime(),
			};
		},
		refreshSearch:function(data){
			$("#keyWord").val(data.keyWord);
			$("#openTime").prop("checked",data.openTime);
			$("#startTime").val(new Date(data.startTime).Format("yyyy-MM-dd"));
			$("#endTime").val(new Date(data.endTime).Format("yyyy-MM-dd"));
		},
	}
});
$(function(){
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