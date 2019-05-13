<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<title>后台管理</title>
<jsp:include page="/inc/admCommon_js_css_inc.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/home.css">
<style type="text/css">
.admTitle{
    display: inline-block;
    border-collapse: separate;
    cursor: pointer;
    font-size: 32px;
    font-weight: 700;
    white-space: nowrap;
    position: relative;
    width: 200px;
    height: 42px;
    line-height: 42px;
    text-align: center;;
    top: 50%;
    left: 50%;
    margin-left: -100px;
    margin-top: -21px;
}
</style>
</head>
<body style="margin: 0;padding: 0;">
	<div class="easyui-layout" style="width:100%;height:100%">
		<div data-options="region:'north'" style="height:80px">
			<div class="admTitle">后台管理系统</div>
		</div>
		<div id="funPanel" data-options="region:'west',split:true" title="后台管理" style="width:180px;">
			<div id="funs" class="easyui-sidemenu"></div>
		</div>
		<div data-options="region:'center'">
			<iframe id="manageFramePage" src="" style="width: 100%;height: 100%" frameborder=0 scrolling="yes"></iframe>
		</div>

	</div>

</body>
<script type="text/javascript">
var manageFramePreUrl = "${pageContext.request.contextPath}/adm/";
var data = [{
    text: '产品',
    state: 'open',
    children: [{
        text: '添加产品<input type="hidden" value="product/add"/>'
    },{
        text: '管理产品<input id="manageProduct" type="hidden" value="product/manage"/>',
    }]
},{
    text: '订单',
    children: [{
        text: '管理订单<input type="hidden" value="order/manageOrder"/>'
    }]
},{
    text: '会员',
    children: [{
        text: '管理会员<input type="hidden" value="member/manageMember"/>'
    }]
},{
    text: '设置',
    children: [{
        text: '首页设置<input type="hidden" value="setting/homeSetting"/>'
       
    }]
}];
var funs = $("#funs").sidemenu({
	data:data,
	width:173,
	onSelect:function(item){
		var url = manageFramePreUrl+$(item.target).find("input").val();
		$("#manageFramePage").attr("src",url);
	}
});
$(function(){
	$("#manageProduct").parent("span").click();
})

</script>
</html>