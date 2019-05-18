<%@ page language="java" pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<!-- 引入jquery -->
<script type="text/javascript"
	src="${APP_DIR}/js/jquery-3.1.0.js"></script>
<!-- 引入jquery.form -->
<script type="text/javascript"
	src="${APP_DIR}/js/jquery.form.js"></script>
<!-- 引入jquery.cookie -->
<script type="text/javascript"
	src="${APP_DIR}/js/jquery.cookie.js"></script>
<!-- 引入vue -->
<script type="text/javascript"
	src="${APP_DIR}/js/vue.js"></script>
<!-- 引入自定义共用组件样式-->
<link rel="stylesheet"
	href="${APP_DIR}/css/myComponent.css"/>
<!-- 引入自定义共用组件 -->
<script type="text/javascript" src="${APP_DIR}/js/vueComponent/myComponent.js" ></script>
<!-- 引入easyUI -->
<link rel="stylesheet" type="text/css" href="${APP_DIR}/jquery-easyui-1.7.0/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${APP_DIR}/jquery-easyui-1.7.0/themes/icon.css">
<script type="text/javascript" src="${APP_DIR}/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
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
<script type="text/javascript">
//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt)   
{ //author: meizz   
var o = {   
  "M+" : this.getMonth()+1,                 //月份   
  "d+" : this.getDate(),                    //日   
  "h+" : this.getHours(),                   //小时   
  "m+" : this.getMinutes(),                 //分   
  "s+" : this.getSeconds(),                 //秒   
  "q+" : Math.floor((this.getMonth()+3)/3), //季度   
  "S"  : this.getMilliseconds()             //毫秒   
};   
if(/(y+)/.test(fmt))   
  fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
for(var k in o)   
  if(new RegExp("("+ k +")").test(fmt))   
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
return fmt;   
} 
</script>
