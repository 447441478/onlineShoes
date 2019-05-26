<%@ page language="java" pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- 引入jquery -->
<script type="text/javascript"
	src="${APP_DIR}/js/jquery-3.1.0.js"></script>
<!-- 引入jquery.cookie -->
<script type="text/javascript"
	src="${APP_DIR}/js/jquery.cookie.js"></script>
<!-- 引入Bootstrap -->
<link rel="stylesheet"
	href="${APP_DIR}/bootstrap-3.3.7-dist/css/bootstrap.css" />
<script type="text/javascript"
	src="${APP_DIR}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!-- 引入vue -->
<script type="text/javascript"
	src="${APP_DIR}/js/vue.js"></script>
<!-- 引入自定义共用组件样式-->
<link rel="stylesheet"
	href="${APP_DIR}/css/myComponent.css"/>
<!-- 引入自定义共用组件 -->
<script type="text/javascript" src="${APP_DIR}/js/vueComponent/myComponent.js" ></script>
<!-- 引入layui -->
<link rel="stylesheet"
	  href="${APP_DIR}/lib/layui/css/layui.css" media="all"/>
<script src="${APP_DIR}/lib/layui/layui.js" charset="utf-8"></script>

<style type="text/css">
*{
	font-family: 'Microsoft Yahei';
}
input,button,a {
    outline:0 none !important; blr:expression(this.onFocus=this.blur());
}
.modal-open{
	overflow-y: auto;
	padding-left: 16px;
}
.backTop{
	position: fixed;
	bottom: 16px;
	right: 16px;
	font-size: 40px;
	text-decoration: none;
	color: #fff;
	background: #999;
	width: 50px;
	height: 50px;
	text-align: center;
	line-height: 50px;
	opacity: .5;
	border-radius: 4px;
}
.backTop:hover{
	opacity: 1;
	text-decoration: none;
	color: #fff;
}
.backTop:focus{
	text-decoration: none;
	color: #fff;
}
</style>
