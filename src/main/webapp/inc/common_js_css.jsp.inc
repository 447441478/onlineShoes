<%@ page language="java" pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
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
<style type="text/css">
*{
	font-family: 'Microsoft Yahei';
}
input,button,a {
    outline:0 none !important; blr:expression(this.onFocus=this.blur());
}
</style>
