<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<!-- 引入jquery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.0.js"></script>
<!-- 引入jquery.form -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<!-- 引入vue -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/vue.js"></script>
<!-- 引入自定义共用组件样式-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myComponent.css"/>
<!-- 引入自定义共用组件 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vueComponent/myComponent.js" ></script>
<!-- 引入easyUI -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.7.0/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.7.0/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
<style type="text/css">
html,body{
	height: 100%;
}
html,body,*{
	margin: 0;
	padding: 0;
}
.clear{
	clear: both;
}
.top_bar{
	position: relative;
    left: 0;
    top: 0;
    width: 100%;
    box-sizing:border-box;
    padding: 0 40px;
    border-bottom: 1px solid rgb(233, 235, 240); 
}
.top_bar_title{
	line-height: 64px;
    font-size: 18px;
    color: #5874d8;
    font-weight: normal;
    display: inline-block;
    cursor: default;
}
</style>