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
<%@ include file="/inc/admCommon_js_css.jsp.inc" %>
<!-- 引入Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
.logistics .item{
    margin-bottom: 20px;
}
.logistics .item .title{
    font-size: 13px;
    color: #333;
    display: inline-block;
    vertical-align: middle;
    margin-right: 15px;
}

</style>
</head>
<script type="text/javascript">
	
</script>
<body style="overflow-x: hidden; overflow-y: auto;">
	<div class="top_bar">
		<div class="top_bar_title">设置物流信息</div>
	</div>
	<div class="logistics" style="padding-top: 35px; padding-left: 35px;">
		<div class="item">
			<span class="title">快递单号：</span>
			<span>
				<input id="logisticsId"/>
				&ensp;
				<span onclick='$("#logisticsId").val("");' style="float: none;" type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</span>
			</span>
		</div>
	</div>
	<div style="text-align: center; margin-top: 50px;">
		<button type="button" class="btn btn-primary btn-sm" style="margin-right: 28px;" onclick="save()">确 定</button>
		<button type="button" class="btn btn-danger btn-sm" onclick="cancel()">取 消</button>
	</div>
</body>

<script type="text/javascript">
	function cancel(){
		$(window.parent.document).find("#myModal").click();
	}
	function save(){
		var logisticsId = $("#logisticsId").val();
		if(!logisticsId){
			alert("快递单号不能为空");
			return ;
		}
		if(logisticsId.length > 50){
			alert("快递单号不能超过50个字符");
			return ;
		}
		$.ajax({
			url:"${APP_DIR}/adm/order/sendGoods?orderDetailId=<%=request.getParameter("orderDetailId")%>&logisticsId="+logisticsId,
			type:"POST",
			success:function(){
				window.parent.location.reload();
			},
			error:function(){
				window.parent.location.reload();
			}
		});
	}
</script>
</html>