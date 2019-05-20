<%@page import="net.hncu.onlineShoes.domain.Comment"%>
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
<title>评论管理</title>
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
#comments tbody tr:hover{
	background-color: rgb(255,255,204);
}
#comments tbody tr td{
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
<body style="overflow-x:hidden;overflow-y:auto;margin: 0 !important;">
	<div class="top_bar">
		<div class="top_bar_title">评论管理</div>
		<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
			<i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
		</a>
	</div>
	<div class="container-fluid">
		<div id='comments'  class="row" >
			<div v-show='tip!=""' style="position: fixed;z-index:100;top:5px;" class="alert alert-warning col-md-offset-5" >
			    <a href="#" class="close" @click.stop="tip=''" style="margin-left: 8px;">&times;</a>
			    <span>{{tip}}</span>
			</div>
			<div class="options col-md-12">
				<button @click.stop="public()" type="button" class="btn btn-danger btn-sm">公开评论</button>
				<button @click.stop="hidden()" type="button" class="btn btn-warning btn-sm">隐藏评论</button>
			</div>
			<div class="searchs col-md-12">
				<form class="layui-form layui-col-space5">
					<div class="layui-input-inline layui-show-xs-block">
						<label for="keyWord" >产品名称：</label>
						<div class="layui-input-inline layui-show-xs-block">
	                  		<input id="keyWord" type="text"  placeholder="请输入产品名称" autocomplete="off" class="layui-input">
	                   	</div>
                   	</div>
					<div class="layui-input-inline layui-show-xs-block">
						<input id="openTime" type="checkbox" lay-skin="primary" title="评论时间：" />
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
							<th width="40px;"><input style="cursor: pointer;" class="cbxAll" type="checkbox" @click.stop="checkChangeAll()"/></th>
							<th style="width: 80px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.CommentDef.FLAG %>')">
								状态
								<i v-if="orderColum == '<%=SearchField.CommentDef.FLAG %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.CommentDef.FLAG %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 200px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.CommentDef.SHOES_NAME %>')">
								产品名称
								<i v-if="orderColum == '<%=SearchField.CommentDef.SHOES_NAME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.CommentDef.SHOES_NAME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 120px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.CommentDef.USER_NAME %>')">
								用户名
								<i v-if="orderColum == '<%=SearchField.CommentDef.USER_NAME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.CommentDef.USER_NAME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 180px;cursor: pointer;">
								内容
							</th>
							<th style="width: 180px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.CommentDef.CREATE_TIME %>')">
								发表时间
								<i v-if="orderColum == '<%=SearchField.CommentDef.CREATE_TIME %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.CommentDef.CREATE_TIME %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							<th style="width: 120px;cursor: pointer;" @click="changeOrderBy('<%=SearchField.CommentDef.IP %>')">
								IP
								<i v-if="orderColum == '<%=SearchField.CommentDef.IP %>' && !isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-up"></i>
								<i v-if="orderColum == '<%=SearchField.CommentDef.IP %>' && isDesc" style="margin-left: 10px;" class="glyphicon glyphicon-chevron-down"></i>
							</th>
							
						</tr>
					</thead>
					<tbody>
						<tr v-for="(comment,index) in comments" @click="check(index)">
							<td class="cbx"><input :id="'c-'+comment.commentId" style="cursor: pointer;" :class="['cbx-'+index]" type="checkbox"  @click.stop="checkChange()"/></td>
							<td>
								{{getState(comment.flag)}}
							</td>
							<td><a style="cursor: pointer;" @click="openShoes(comment.shoesId, comment.commentId)">{{comment.shoesName}}</a></td>
							<td>{{comment.userName}}</td>
							<td>{{comment.content}}</td>
							<td>{{comment.createTime}}</td>
							<td>{{comment.ip}}</td>
							
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
	var v_comments = new Vue({
		el:"#comments",
		data:function(){
			return{
				pageInfo:{
					currentPage:1,
					total:${total},
					pageSize:pageSize,
				},
				comments: ${comments},
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
			'public': function(){
				this.tip="";
				$cbxs = $("#comments .cbx input:checked");
				if($cbxs.length == 0){
					this.tip="请选择要公布的评论";
				}else{
					var commentIds=[];
					$cbxs.each(function(){
						var commentId = this.id.substring(2);
						commentIds.push(commentId);
					});
					var data = {
						commentIds:commentIds,
						'public': true,
					};
					var that = this;
					$.ajax({
						url:"${APP_DIR}/adm/product/updateComment",
						data: data,
						type:"POST",
						success:function(msg){
							if(msg.code == <%=Msg.Code.SUCCESS%>){
								$("#comments .cbxAll").prop("checked",false);
								that.refresh();
							}
						},
						error: function(){
							that.tip="系统繁忙...";
						}
					});
					
					
				}
			},
			hidden: function(){
				this.tip="";
				$cbxs = $("#comments .cbx input:checked");
				if($cbxs.length == 0){
					this.tip="请选择要隐藏的评论";
				}else{
					var commentIds=[];
					$cbxs.each(function(){
						var commentId = this.id.substring(2);
						commentIds.push(commentId);
					});
					var data = {
						commentIds:commentIds,
						hidden: true,
					};
					var that = this;
					$.ajax({
						url:"${APP_DIR}/adm/product/updateComment",
						data: data,
						type:"POST",
						success:function(msg){
							if(msg.code == <%=Msg.Code.SUCCESS%>){
								$("#comments .cbxAll").prop("checked",false);
								that.refresh();
							}
						},
						error: function(){
							that.tip="系统繁忙...";
						}
					});
					
					
				}
			},
			getState: function(flag){
				if(flag == <%=Comment.Flag.PUBLIC%>){
					return "已公开";
				}
				if(flag & <%=Comment.Flag.HIDDENT%> == <%=Comment.Flag.HIDDENT%>){
					return "隐藏";
				}
			},
			openShoes: function(shoesId, commentId){
				window.open("${APP_DIR}/shoes/"+shoesId+"?commentId="+commentId);;
			},
			checkChange:function(){
				$cbxs = $("#comments .cbx input");
				var len = $cbxs.length;
				$cbxs.each(function(){
					if(this.checked){
						len--;
					}
				});
				if(len == 0){
					$("#comments .cbxAll").prop("checked",true);
				}else{
					$("#comments .cbxAll").prop("checked",false);
				}
			},
			checkChangeAll:function(){
				var val = $("#comments .cbxAll").prop("checked");
				$("#comments .cbx input").prop("checked",val);
			},
			check:function(index){
				var $input = $("#comments .cbx input").eq(index);
				$input.prop("checked",!$input.prop("checked"));
			},
			refresh:function(){
				var that = this;
				var data = this.getSearchArg();
				$.ajax({
					url:"${APP_DIR}/adm/product/getComment",
					data:data,
					type:"get",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.pageInfo.total = msg.datas.total;
							that.comments = msg.datas.comments;
							that.refreshSearch(msg.datas);
							$("#comments .cbx input:checked").prop("checked",false);
							$("#comments .cbxAll").prop("checked",false);
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
					startTime: new Date($("#startTime").val()).getTime(),
					endTime: new Date($("#endTime").val()).getTime(),
				};
			},
			refreshSearch:function(data){
				$("#keyWord").val(data.keyWord);
				$("#openTime").prop("checked",data.openTime);
				$("#startTime").val(new Date(data.startTime).Format("yyyy-MM-dd"));
				$("#endTime").val(new Date(data.endTime).Format("yyyy-MM-dd"));
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
			
		}
	});
	
	$(function(){
		$("#myModal").on("hidden.bs.modal",function(){
			manageProduct.refresh();
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